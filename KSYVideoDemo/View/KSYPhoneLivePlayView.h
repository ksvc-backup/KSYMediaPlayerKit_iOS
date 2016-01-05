//
//  KSYPhoneLivePlayView.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  手机直播视图

#import <UIKit/UIKit.h>
#import "KSYInteractiveView.h"
#import "KSYBasePlayView.h"


@interface KSYPhoneLivePlayView : KSYBasePlayView

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString playState:(KSYPhoneLivePlayState)playState;

@property (nonatomic, copy) void (^liveBroadcastCloseBlock)();//设置声明方法

@property (nonatomic, copy) void (^liveBroadcastReporteBlock)();

@property (nonatomic, copy) void (^shareBlock)();
@property (nonatomic ,strong)   NSArray     *spectatorsArray;

- (void)addNewCommentWith:(id)model;

- (void)onPraiseWithSpectatorsInteractiveType:(SpectatorsInteractiveType )type;
@end
