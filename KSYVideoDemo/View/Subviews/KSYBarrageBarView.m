//
//  KSYBarrageBarView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/12.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYBarrageBarView.h"
#define font [UIFont systemFontOfSize:15]

@interface KSYBarrageBarView () <KSYBarrageDelegate> {
    
    KSYBarrageView *_barrageView;
    NSDate *_startDate;
    
    NSTimer *_timer;
}
@end

@implementation KSYBarrageBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self setupBarrageView];
        [self setupBarrageData];
    }
    return self;
}
- (void)setupBarrageView
{
    //弹幕视图的大小
    CGRect rect =  CGRectMake(0, 2, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-50);
    _barrageView = [[KSYBarrageView alloc] initWithFrame:rect];
    _barrageView.duration = 6.5;
    _barrageView.lineHeight = 25;
    _barrageView.maxShowLineCount = 15;
    
    _barrageView.delegate = self;
    [self addSubview:_barrageView];
}
- (void)setupBarrageData
{
    //获得弹幕数据
    NSString *danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
    NSArray *danmakusDicts = [NSArray arrayWithContentsOfFile:danmakufile];
    
    NSMutableArray* barrages = [NSMutableArray array];
    for (NSDictionary* dict in danmakusDicts) {
        KSYBarrage* barrage = [[KSYBarrage alloc] init];
        NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:dict[@"m"] attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : kRandomColor}];
        
        NSString* emotionName = [NSString stringWithFormat:@"smile_%zd", arc4random_uniform(90)];
        UIImage* emotion = [UIImage imageNamed:emotionName];
        NSTextAttachment* attachment = [[NSTextAttachment alloc] init];
        attachment.image = emotion;
        attachment.bounds = CGRectMake(0, -font.lineHeight*0.3, font.lineHeight*1.5, font.lineHeight*1.5);
        NSAttributedString* emotionAttr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        [contentStr appendAttributedString:emotionAttr];
        barrage.contentStr = contentStr;
        
        NSString* attributesStr = dict[@"p"];
        NSArray* attarsArray = [attributesStr componentsSeparatedByString:@","];
        barrage.timePoint = [[attarsArray firstObject] doubleValue] / 1000;
        barrage.position = [attarsArray[1] integerValue];
        //        if (danmaku.position != 0) {
        
        [barrages addObject:barrage];
        //        }
    }
    
    [_barrageView prepareBarrage:barrages];
}
- (void)start{
    [_barrageView start];
}
- (void)stop{
    [_barrageView stop];
}
#pragma mark - 弹幕视图代理
- (NSTimeInterval)danmakuViewGetPlayTime:(KSYBarrageView *)danmakuView
{
//    if(_slider.value == 1.0) [_danmakuView stop]
//        ;
//    return _slider.value*120.0;
    return 10;
}

- (BOOL)danmakuViewIsBuffering:(KSYBarrageView *)danmakuView
{
    return YES;
}
@end
