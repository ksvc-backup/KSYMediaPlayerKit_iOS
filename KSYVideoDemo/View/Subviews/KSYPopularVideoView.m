//
//  KSYPopularVideoView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/25.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYPopularVideoView.h"
#import "AppDelegate.h"
#import "KSYCommentService.h"
@interface KSYPopularVideoView (){
    CGFloat _WIDTH;
    CGFloat _HEIGHT;
}

@end

@implementation KSYPopularVideoView



-(void)hiddenNavigater:(BOOL)hidden{
    if (self.hiddenNvgt) {
        self.hiddenNvgt(hidden);
    }
}
- (instancetype)initWithFrame:(CGRect)frame UrlWithString:(NSString *)urlString playState:(KSYPopularLivePlayState)playState;
{

    self = [super initWithFrame:frame];//初始化父视图的(frame、url)
    if (self) {
        self.backgroundColor=DEEPCOLOR;
        WeakSelf(KSYPopularVideoView);
        _ksyVideoPlayerView=[[KSYVideoPlayerView alloc]initWithFrame: CGRectMake(0, 0, self.width, self.height/2-60) UrlFromString:urlString playState:playState];
        _ksyVideoPlayerView.lockScreen=^(BOOL isLocked){
            [weakSelf lockTheScreen:isLocked];
        };
        _ksyVideoPlayerView.clickFullBtn=^(){
            [weakSelf FullScreen];
        };
        _ksyVideoPlayerView.clicUnkFullBtn=^(){
            [weakSelf unFullScreen];
        };
        _ksyVideoPlayerView.showNextVideo=^(NSString *str){
            [weakSelf nextVideo:(str)];
        };
        _ksyVideoPlayerView.hiddenNavigation=^(BOOL hidden){
            [weakSelf hiddenNavigater:hidden];
        };
        [self addSubview:_ksyVideoPlayerView];
        [self addDetailView];
//        [self addCommtenView];
        [self registerObservers];
        _WIDTH = THESCREENWIDTH;
        _HEIGHT = THESCREENHEIGHT;
    }
    return self;

}
- (void)nextVideo:(NSString *)str{
//    [self.ksyVideoPlayerView shutDown];
//    KSYMoviePlayerController *player = [[KSYMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:str]];
//    self.ksyVideoPlayerView.player = player;
//    [self.ksyVideoPlayerView addSubview:self.ksyVideoPlayerView.player.view];
}


// 退出全屏模式
- (void)changeDeviceOrientation:(UIInterfaceOrientation)toOrientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = toOrientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
- (void)FullScreen{
    [self changeDeviceOrientation:UIInterfaceOrientationLandscapeRight];
    [self lunchFull];
}
- (void)unFullScreen{
    [self changeDeviceOrientation:UIInterfaceOrientationPortrait];
    [self unLunchFull];
}
- (void)lunchFull{
    [_detailView.commtenView.kTextField resignFirstResponder];
    [_detailView resetTextFrame];
    self.frame=CGRectMake(0, 0, _HEIGHT, _WIDTH);
    _ksyVideoPlayerView.frame=self.frame;
    [_ksyVideoPlayerView lunchFullScreen];
    _detailView.hidden=YES;
}
- (void)unLunchFull{
    if (_ksyVideoPlayerView.isLock) {
        return;
    }
    self.frame=CGRectMake(0, 64, _WIDTH,_HEIGHT-64);
    _ksyVideoPlayerView.frame=CGRectMake(0, 0, self.width, self.height/2-60);
    [_ksyVideoPlayerView minFullScreen];
    _detailView.hidden=NO;
}
- (void)lockTheScreen:(BOOL)islocked{
    if (self.lockWindow) {
        self.lockWindow(islocked);
    }
}
- (void)addDetailView
{
    _detailView=[[KSYDetailView alloc]initWithFrame:CGRectMake(0, self.ksyVideoPlayerView.bottom,self.width,self.height-_ksyVideoPlayerView.height)];
    [self addSubview: _detailView];
}

- (void)registerObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)unregisterObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil];
}
- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeRight||orientation == UIDeviceOrientationLandscapeLeft)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES
                                                withAnimation:UIStatusBarAnimationFade];
        UIDeviceOrientation  orientation=[[UIDevice currentDevice] orientation];
        if (orientation == UIDeviceOrientationLandscapeRight) {
            if (!KSYSYS_OS_IOS8) {
                [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
            }
            else {
            }
        }
        else {
            if (!KSYSYS_OS_IOS8) {
                [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
            }
            else {
            }
        }
        [self hiddenNavigater:YES];
        [self lunchFull];
    }
    else if (orientation == UIDeviceOrientationPortrait)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO
                                                withAnimation:UIStatusBarAnimationFade];
        [self unLunchFull];
    }
}
- (void)dealloc{
    
}
@end
