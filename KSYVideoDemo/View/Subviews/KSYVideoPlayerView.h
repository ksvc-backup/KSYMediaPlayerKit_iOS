//
//  KSYVideoPlayerView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//


#import "KSYBasePlayView.h"

@interface KSYVideoPlayerView : KSYBasePlayView


- (instancetype)initWithFrame:(CGRect)frame UrlFromString:(NSString *)urlString playState:(KSYPopularLivePlayState)playState;
- (void)lunchFullScreen;
- (void)minFullScreen;
@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, copy) void (^lockScreen)(BOOL isLocked);
@property (nonatomic, copy) void (^clickFullBtn)();
@property (nonatomic, copy) void (^clicUnkFullBtn)();
@property (nonatomic, copy) void (^showNextVideo)(NSString *str);
@property (nonatomic, copy) void (^hiddenNavigation)(BOOL hidden);

@end
