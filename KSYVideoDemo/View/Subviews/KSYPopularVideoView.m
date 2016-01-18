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

@property (nonatomic,strong) KSYDetailView *detailView;
@property (nonatomic,strong)  KSYCommentView *commtenView;

@end




@implementation KSYPopularVideoView

- (instancetype)initWithFrame:(CGRect)frame UrlWithString:(NSString *)urlString playState:(KSYPopularLivePlayState)playState;
{

    self = [super initWithFrame:frame];//初始化父视图的(frame、url)
    if (self) {
        self.backgroundColor=DEEPCOLOR;
        WeakSelf(KSYPopularVideoView);
        self.ksyVideoPlayerView=[[KSYVideoPlayerView alloc]initWithFrame: CGRectMake(0, 0, self.width, self.height/2-60) UrlFromString:urlString playState:playState];
        self.ksyVideoPlayerView.lockScreen=^(BOOL isLocked){
            [weakSelf lockTheScreen:isLocked];
        };
        self.ksyVideoPlayerView.clickFullBtn=^(){
            [weakSelf FullScreen];
        };
        self.ksyVideoPlayerView.clicUnkFullBtn=^(){
            [weakSelf unFullScreen];
        };
        self.ksyVideoPlayerView.showNextVideo=^(NSString *str){
            [weakSelf nextVideo:(str)];
        };
        [self addSubview:self.ksyVideoPlayerView];
        [self addDetailView];
        [self addCommtenView];
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
- (void)hideNavigation{
    if (self.changeNavigationBarColor) {
        self.changeNavigationBarColor();
    }
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
    self.frame=CGRectMake(0, 0, _HEIGHT, _WIDTH);
//    NSLog(NSStringFromCGRect(self.frame));
    self.ksyVideoPlayerView.frame=self.frame;
    [self.ksyVideoPlayerView lunchFullScreen];
    self.detailView.hidden=YES;
    [self.commtenView removeFromSuperview];
}
- (void)unLunchFull{
    if (!self.ksyVideoPlayerView.isLock) {
        return;
    }
    self.frame=CGRectMake(0, 64, _WIDTH,_HEIGHT-64);
    UITextField *textField=(UITextField *)[self viewWithTag:kCommentFieldTag];
    [textField resignFirstResponder];
    self.ksyVideoPlayerView.frame=CGRectMake(0, 0, self.width, self.height/2-60);
    [self.ksyVideoPlayerView minFullScreen];
    self.detailView.hidden=NO;
    [self addCommtenView];
}
- (void)lockTheScreen:(BOOL)islocked{
    if (self.lockWindow) {
        self.lockWindow(islocked);
    }
}

- (void)addDetailView
{
    _detailView=[[KSYDetailView alloc]initWithFrame:CGRectMake(0, self.ksyVideoPlayerView.bottom,self.width,self.height/2-40)];
    [self addSubview: _detailView];
}

- (void)addCommtenView
{
    WeakSelf(KSYPopularVideoView);
    _commtenView=[[KSYCommentView alloc]initWithFrame:CGRectMake(0, self.height-40, self.width, 40)];
    _commtenView.textFieldDidBeginEditing=^{
        [weakSelf changeTextFrame];
    };
    _commtenView.send=^{
        [weakSelf resetTextFrame];
    };
    [self addSubview:_commtenView];
}
- (void)changeTextFrame
{
    
}
- (void)keyboardWillChangeFrame:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGFloat height = endKeyboardRect.size.height;
    
    CGRect newFrame = CGRectMake(0, self.height-height-40, self.width, 40);
    
    [UIView animateWithDuration:0.25 animations:^{
        _commtenView.frame = newFrame;
    }];
}
- (void)resetTextFrame
{
//    //设置时间格式
//    NSDate *date=[NSDate date];
//    UITextField *textField=(UITextField *)[self viewWithTag:kCommentFieldTag];
//    [textField resignFirstResponder];
//    if (![textField.text isEqualToString:@""]) {
//        //向数据库中添加数据
//        [[KSYCommentService sharedKSYCommentService]addCoreDataModelWithImageName:@"avatar60" UserName:@"孙健" Time:date Content:textField.text];
//        //刷新数据库
//        [self.detailView loadData];
//        [self.detailView.kTableView reloadData];
//        [self.detailView.kTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.detailView.models.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }
    //重置评论视图的frame
    UITextField *textField=(UITextField *)[self viewWithTag:kCommentFieldTag];
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.commtenView.frame=CGRectMake(0, self.height-40, self.width, 40);
    } completion:^(BOOL finished) {
        NSLog(@"Animation Over!");
    }];
}

- (void)registerObservers
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)unregisterObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeRight||orientation == UIDeviceOrientationLandscapeLeft)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO
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
        [self hideNavigation];
        [self lunchFull];
    }
    else if (orientation == UIDeviceOrientationPortrait)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO
                                                withAnimation:UIStatusBarAnimationFade];
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
        [self unLunchFull];
    }
}

@end
