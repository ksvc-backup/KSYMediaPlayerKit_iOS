//
//  KSBarrageView.m
//
//
//  Created by yuchenghai on 14/12/22.
//  Copyright (c) 2014年 kuwo.cn. All rights reserved.
//

#import "KSBarrageView.h"
#import "KSBarrageItemView.h"

#define ITEMTAG 300

@implementation KSBarrageView {
    
    UIImageView *_avatarView;
    UIImageView *_giftView;
    
    NSTimer *_timer;
    NSInteger _curIndex;
    
    //创建弹幕项目
    KSBarrageItemView *_item;
    CGFloat _font;
    CGFloat _alpha;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self setClipsToBounds:YES];
        _curIndex = 0;
    }
    return self;
}

- (void)start {

    if (_dataArray && _dataArray.count > 0) {
        if (!_timer) {

            _timer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(postView) userInfo:nil repeats:YES];
        }
    }
}

- (void)stop {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)setDanmuFont:(CGFloat)font
{
    _font=font;
}

-(void)setDanmuAlpha:(CGFloat)alpha
{
    _alpha=alpha;
}

- (void)postView {

    if (_dataArray && _dataArray.count > 0) {

        int indexPath = random()%(int)((self.frame.size.height)/20);
        int top = indexPath * 20;

        UIView *view = [self viewWithTag:indexPath + ITEMTAG];  
        if (view && [view isKindOfClass:[KSBarrageItemView class]]) {
            return;
        }
        
        NSDictionary *dict = nil;
        if (_dataArray.count > _curIndex) {
            dict = _dataArray[_curIndex];
            _curIndex++;
        } else {
            _curIndex = 0;
            dict = _dataArray[_curIndex];
            _curIndex++;
        }
        
        for (KSBarrageItemView *view in self.subviews) {
            if ([view isKindOfClass:[KSBarrageItemView class]] && view.itemIndex == _curIndex-1) {
                return;
            }
        }
        
        _item = [[KSBarrageItemView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, top, 10, 30)];
        [_item KSBarrageItemViewsetDanmuFont:_font];
        [_item KSBarrageItemViewsetDanmuAlpha:_alpha];
        id avatar = [dict objectForKey:@"avatar"];
        NSString *content = [dict objectForKey:@"content"];
        if ([avatar isKindOfClass:[UIImage class]]) {
            [_item setAvatarWithImage:avatar withContent:content];
        } else if ([avatar isKindOfClass:[NSString class]]){
            UIImage *image = [UIImage imageNamed:avatar];
            if (image) {
                [_item setAvatarWithImage:image withContent:content];
            } else {
                // 这里使用网络图片，请加入sdwebImage库
//                [item setAvatarUrl:avatar withContent:content];
            }
        } else {
            return;
        }
        
        _item.itemIndex = _curIndex-1;
        _item.tag = indexPath + ITEMTAG;
        [self addSubview:_item];
        
        CGFloat speed = 100;
        speed += random()%10;
        CGFloat time = (_item.width+[[UIScreen mainScreen] bounds].size.width) / speed;
        
        [UIView animateWithDuration:time delay:0.f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear  animations:^{
            _item.left = -_item.width;
        } completion:^(BOOL finished) {
            [_item removeFromSuperview];
        }];
        
    }
}

@end
