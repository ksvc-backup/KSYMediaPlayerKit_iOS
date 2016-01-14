//
//  KSYBarrageView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/12.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "KSYBarrage.h"
@class KSYBarrageView;
@protocol KSYBarrageDelegate <NSObject>

@required
- (NSTimeInterval)barrageViewGetPlayTime:(KSYBarrageView *)barrageView;

- (BOOL)barrageViewIsBuffing:(KSYBarrageView *)barrateView;

@end
@interface KSYBarrageView : UIView
@property (nonatomic, weak) id<KSYBarrageDelegate>delegate;
@property (nonatomic, readonly, assign) BOOL isPrepared;
@property (nonatomic, readonly, assign) BOOL isPlaying;
@property (nonatomic, readonly, assign) BOOL isPauseing;

- (void)prepareBarrage:(NSArray *)barrages;

@property (nonatomic, assign) CGFloat duration;//弹幕时间
@property (nonatomic, assign) CGFloat lineHeight;//弹道高度
@property (nonatomic, assign) CGFloat lineMargin;//弹道间距
@property (nonatomic, assign) NSInteger maxShowLineCount;//弹道行数


- (void)start;
- (void)stop;

- (void)sendBarrage:(KSYBarrage *)barrage;

@end
