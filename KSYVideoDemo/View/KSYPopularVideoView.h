//
//  KSYPopularVideoView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/25.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYBasePlayView.h"
#import "KSYDetailView.h"
#import "KSYCommentView.h"
#import "KSYVideoPlayerView.h"
@interface KSYPopularVideoView : UIView


@property (nonatomic, strong)  KSYVideoPlayerView *ksyVideoPlayerView;

@property (nonatomic, copy) void (^changeNavigationBarColor)();
@property (nonatomic, copy) void (^lockWindow)(BOOL isLocked);

- (instancetype)initWithFrame:(CGRect)frame UrlWithString:(NSString *)urlString playState:(KSYPopularLivePlayState)playState;

- (void)unregisterObservers;




@end
