//
//  KSYBarrageView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/12.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYBarrageView.h"
#import "KSYBarrageInfo.h"

@interface KSYBarrageView (){
    NSTimer *_timer;
}
@property (nonatomic, strong) NSMutableArray *barrages;
@property (nonatomic, strong) NSMutableArray *currentBarrages;
@property (nonatomic, strong) NSMutableArray *subBarragesInfos;
@property (nonatomic, strong) NSMutableDictionary *linesDict;

@end

static NSTimeInterval const timeMargin = 0.5;

@implementation KSYBarrageView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (NSMutableArray *)subBarragesInfos{
    if (!_subBarragesInfos) {
        _subBarragesInfos = [[NSMutableArray alloc]init];
    }
    return _subBarragesInfos;
}
- (NSMutableDictionary *)linesDict{
    if (!_linesDict) {
        _linesDict = [[NSMutableDictionary alloc]init];
    }
    return _linesDict;
}
- (NSMutableArray *)currentBarrages{
    if (!_currentBarrages) {
        _currentBarrages=[[NSMutableArray alloc]init];
    }
    return _currentBarrages;
}


#pragma mark － perpare
- (void)prepareBarrage:(NSArray *)barrages{
    self.barrages = [[barrages sortedArrayUsingComparator:^NSComparisonResult(KSYBarrage *obj1, KSYBarrage  *obj2) {
        if (obj1.timePoint>obj2.timePoint) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }]mutableCopy];
}

- (void)getCurrentTime{
//    if ([self.delegate barrageViewIsBuffing:self])  return;
    [self.subBarragesInfos enumerateObjectsUsingBlock:^(KSYBarrageInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTimeInterval lefeTime = obj.leftTime;
        lefeTime -= timeMargin;
        obj.leftTime = lefeTime;
    }];
    [self.currentBarrages removeAllObjects];
    
//    NSTimeInterval timeInterval = [self.delegate barrageViewGetPlayTime:self];
//    NSString *timeStr = [NSString stringWithFormat:@"%0.1f",timeInterval];
    NSTimeInterval timeInterval = 12.0;
    
    //遍历弹幕数组
    [self.barrages enumerateObjectsUsingBlock:^(KSYBarrage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.timePoint >= timeInterval && obj.timePoint < timeInterval+timeMargin){
            [self.currentBarrages addObject:obj];
        }else if (obj.timePoint>timeInterval){
            *stop = YES;
        }
    }];
    if (self.currentBarrages.count>0) {
        for (KSYBarrage *barrage in self.currentBarrages) {
            [self playBarrage:barrage];
        }
    }
}
- (void)playBarrage:(KSYBarrage *)barrage{
    UILabel *playerLabel = [[UILabel alloc]init];
    
    playerLabel.attributedText = barrage.contentStr;
    
    [playerLabel sizeToFit];
    
    [self addSubview:playerLabel];
    
    playerLabel.backgroundColor = [UIColor clearColor];
    
    [self playFromRightBarrage:barrage playerLabel:playerLabel];
}
- (void)playFromRightBarrage:(KSYBarrage *)barrage playerLabel:(UILabel *)playLabel{
    KSYBarrageInfo *newInfo = [[KSYBarrageInfo alloc]init];
    
    newInfo.playLabel = playLabel;
    
    newInfo.leftTime =self.duration;
    
    newInfo.barrage = barrage;
    
    playLabel.frame = CGRectMake(self.width, 0, playLabel.width, playLabel.height);
    
    NSInteger valueCount = self.linesDict.allKeys.count;
    
    if (valueCount == 0) {
        newInfo.lineCount = 0;
        [self addAnimationToViewWithInfo:newInfo];
        return;
    }
    
    for (int i=0; i<valueCount; i++) {
        KSYBarrageInfo *oldInfo = self.linesDict[@(i)];
        if (!oldInfo) break;
        if (![self judgeIsRunintoWithFirstBarrageInfo:oldInfo behindLabel:playLabel]) {
            newInfo.lineCount = i;
            [self addAnimationToViewWithInfo:newInfo];
            break;
        }else if (i== valueCount - 1){
            if (valueCount<self.maxShowLineCount) {
                newInfo.lineCount = i+1;
                [self addAnimationToViewWithInfo:newInfo];
            }else{
                [self.barrages removeObject:barrage];
                [playLabel removeFromSuperview];
                NSLog(@"同一时间评论太多--排不开了------------");
            }
        }
    }
}
- (void)addAnimationToViewWithInfo:(KSYBarrageInfo *)info{
    UILabel *label = info.playLabel;
    NSInteger lineCount = info.lineCount;
    
    label.frame = CGRectMake(self.width, (self.lineHeight+self.lineMargin)*lineCount, label.width, label.height);
    [self.subBarragesInfos addObject:info];
    self.linesDict[@(lineCount)]=info;
    
    [self performAnimationWithDuration:info.leftTime barrageInfo:info];
}
- (void)performAnimationWithDuration:(NSTimeInterval)duration barrageInfo:(KSYBarrageInfo *)info
{
    _isPlaying = YES;
    _isPauseing = NO;
    
    UILabel *label = info.playLabel;
    CGRect endFrame = CGRectMake(-label.width, label.top, label.width, label.height);
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        label.frame = endFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [label removeFromSuperview];
            [self.subBarragesInfos removeObject:info];
        }
    }];
}
- (BOOL)judgeIsRunintoWithFirstBarrageInfo:(KSYBarrageInfo *)info behindLabel:(UILabel *)last
{
    UILabel* firstLabel = info.playLabel;
    CGFloat firstSpeed = [self getSpeedFromLabel:firstLabel];
    CGFloat lastSpeed = [self getSpeedFromLabel:last];
    
    
    //    CGRect firstFrame = info.labelFrame;
    CGFloat firstFrameRight = info.leftTime * firstSpeed;
    
    if(info.leftTime <= 1) return NO;
    
    
    
    if(last.left - firstFrameRight > 10) {
        
        if( lastSpeed <= firstSpeed)
        {
            return NO;
        }else{
            CGFloat lastEndLeft = last.left - lastSpeed * info.leftTime;
            if (lastEndLeft >  10) {
                return NO;
            }
        }
    }
    
    return YES;
}
- (CGFloat)getSpeedFromLabel:(UILabel *)label
{
    return (self.bounds.size.width + label.bounds.size.width) / self.duration;
}
#pragma mark - 公共方法

- (BOOL)isPrepared
{
    NSAssert(self.duration && self.maxShowLineCount && self.lineHeight, @"必须先设置弹幕的时间\\最大行数\\弹幕行高");
    if (self.barrages.count && self.lineHeight && self.duration && self.maxShowLineCount) {
        return YES;
    }
    return NO;
}
- (void)start
{
    
    if(_isPauseing) [self resume];
    
    if ([self isPrepared]) {
        if (!_timer) {
            _timer = [NSTimer timerWithTimeInterval:timeMargin target:self selector:@selector(getCurrentTime) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            [_timer fire];
        }
    }
}
- (void)pause
{
    if(!_timer || !_timer.isValid) return;
    
    _isPauseing = YES;
    _isPlaying = NO;
    
    [_timer invalidate];
    _timer = nil;
    
    for (UILabel* label in self.subviews) {
        
        CALayer *layer = label.layer;
        CGRect rect = label.frame;
        if (layer.presentationLayer) {
            rect = ((CALayer *)layer.presentationLayer).frame;
        }
        label.frame = rect;
        [label.layer removeAllAnimations];
    }
}
- (void)resume
{
    if( ![self isPrepared] || _isPlaying || !_isPauseing) return;
    for (KSYBarrageInfo* info in self.subBarragesInfos) {
    [self performAnimationWithDuration:info.leftTime barrageInfo:info];

    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeMargin * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self start];
    });
}
- (void)stop
{
    _isPauseing = NO;
    _isPlaying = NO;
    
    [_timer invalidate];
    _timer = nil;
    [self.barrages removeAllObjects];
    self.linesDict = nil;
}

- (void)clear
{
    [_timer invalidate];
    _timer = nil;
    self.linesDict = nil;
    _isPauseing = YES;
    _isPlaying = NO;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)sendDanmakuSource:(KSYBarrage *)danmaku
{
    [self playBarrage:danmaku];
}

@end
