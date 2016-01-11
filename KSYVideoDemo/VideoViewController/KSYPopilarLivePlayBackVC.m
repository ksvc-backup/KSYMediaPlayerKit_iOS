//
//  KSYPopilarLivePlayBackVC.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYPopilarLivePlayBackVC.h"
#import "KSYPopularVideoView.h"
#import "AppDelegate.h"

@interface KSYPopilarLivePlayBackVC ()<UIActionSheetDelegate>
{
    KSYPopularVideoView *ksyPoularbackView;
    UIAlertView *alertView;
}
@end

@implementation KSYPopilarLivePlayBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
     self.navigationController.navigationBar.hidden=YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    ksyPoularbackView=[[KSYPopularVideoView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) UrlWithString:self.urlPath playState:KSYPopularPlayBack];
    ksyPoularbackView.ksyVideoPlayerView.isBackGroundReleasePlayer=self.isReleasePlayer;
    WeakSelf(KSYPopilarLivePlayBackVC);
    ksyPoularbackView.lockWindow=^(BOOL isLocked){
        [weakSelf lockTheWindow:(isLocked)];
    };
    [self.view addSubview:ksyPoularbackView];
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    appDelegate.allowRotation=YES;
}

- (void)lockTheWindow:(BOOL)isLocked
{
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation=!isLocked;
}
- (void)back
{
    [ksyPoularbackView.ksyVideoPlayerView shutDown];
    [ksyPoularbackView unregisterObservers];
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"以提供订阅按钮接口" delegate:self cancelButtonTitle:nil otherButtonTitles: @"OK",nil];
            [alertView show];
            break;
        case 1:
            alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"以提供举报按钮接口" delegate:self cancelButtonTitle:nil otherButtonTitles: @"OK",nil];
            [alertView show];
        default:
            break;
    }
}
- (void)dealloc
{
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation=NO;
}

@end
