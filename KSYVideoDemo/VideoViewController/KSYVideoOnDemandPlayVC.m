//
//  KSYVideoOnDemandPlayVC.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYVideoOnDemandPlayVC.h"
#import "KSYPopularVideoView.h"
#import "AppDelegate.h"
@interface KSYVideoOnDemandPlayVC ()
{
    KSYPopularVideoView *ksyPoularbackView;
}
@end
@implementation KSYVideoOnDemandPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self changeNavigationStayle];
    ksyPoularbackView=[[KSYPopularVideoView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) UrlWithString:_urlPath playState:KSYPopularPlayBack];
    ksyPoularbackView.ksyVideoPlayerView.isBackGroundReleasePlayer=self.isReleasePlayer;
    WeakSelf(KSYVideoOnDemandPlayVC);
    ksyPoularbackView.changeNavigationBarColor=^(){
        [weakSelf changeNavigationBarCLO];
    };
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
- (void)changeNavigationBarCLO
{
    self.navigationController.navigationBar.alpha=0.0;
}
- (void)changeNavigationStayle
{
    //设置返回按钮
    UIButton *ksyBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    ksyBackBtn.frame=CGRectMake(5, 5, 40, 30);
    [ksyBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [ksyBackBtn setTitleColor:KSYCOLER(52, 211, 220) forState:UIControlStateNormal];
    ksyBackBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    [ksyBackBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:ksyBackBtn];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    //添加标题标签
    UILabel *ksyTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    ksyTitleLabel.text=@"视频标题";
    ksyTitleLabel.textColor=[UIColor whiteColor];
    ksyTitleLabel.textAlignment=NSTextAlignmentCenter;
    ksyTitleLabel.font=[UIFont systemFontOfSize:WORDFONT18];
    ksyTitleLabel.center=self.navigationItem.titleView.center;
    self.navigationItem.titleView = ksyTitleLabel;
    
    
    //添加选项按钮
    UIButton *ksyMenuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    ksyMenuBtn.frame=CGRectMake(self.view.right-45, 5, 40, 30);
    [ksyMenuBtn setTitle:@"选项" forState:UIControlStateNormal];
    [ksyMenuBtn setTitleColor:KSYCOLER(52, 211, 220) forState:UIControlStateNormal];
    ksyMenuBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    [ksyMenuBtn addTarget:self action:@selector(menu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:ksyMenuBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}
- (void)back
{
    [ksyPoularbackView.ksyVideoPlayerView shutDown];
    [ksyPoularbackView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
}
- (void)menu
{
    
}
- (void)dealloc
{
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation=NO;
}


@end
