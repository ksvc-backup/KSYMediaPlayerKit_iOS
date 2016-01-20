//
//  KSYPopilarLivePlayVC.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYPopilarLivePlayVC.h"
#import "AppDelegate.h"

@interface KSYPopilarLivePlayVC ()<UIActionSheetDelegate>{
    KSYPopularVideoView *ksyPoularLiveView;
    UIAlertView *alertView;
}
@end

@implementation KSYPopilarLivePlayVC

- (void)dealloc
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self changeNavigationStyle];
    ksyPoularLiveView=[[KSYPopularVideoView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) UrlWithString:self.urlPath playState:KSYPopularLivePlay];
    WeakSelf(KSYPopilarLivePlayVC);
    ksyPoularLiveView.lockWindow=^(BOOL isLocked){
        [weakSelf lockWindow:(isLocked)];
    };
    ksyPoularLiveView.hiddenNvgt=^(BOOL hidden){
        [weakSelf changeNavigationBarCLO:hidden];
    };
    [self.view addSubview:ksyPoularLiveView];
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    appDelegate.allowRotation=YES;
}
#pragma mark 修改导航栏颜色
- (void)changeNavigationBarCLO:(BOOL)hidden
{
    self.navigationController.navigationBar.hidden=hidden;
}
#pragma mark 锁屏
- (void)lockWindow:(BOOL)isLocked
{
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation=!isLocked;
}

#pragma mark 修改导航栏模式
- (void)changeNavigationStyle
{
    //设置返回按钮
    UIButton *ksyBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    ksyBackBtn.frame=CGRectMake(5, 5, 40, 30);
    [ksyBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [ksyBackBtn setTitleColor:KSYCOLER(52, 211, 220) forState:UIControlStateNormal];
    ksyBackBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    [ksyBackBtn addTarget:self action:@selector(backBtnclick) forControlEvents:UIControlEventTouchUpInside];
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

- (void)backBtnclick{
    
    [ksyPoularLiveView.ksyVideoPlayerView shutDown];
    [ksyPoularLiveView unregisterObservers];//在这里要记的注销通知
    [ksyPoularLiveView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    //修改状态栏颜色
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation=NO;
}
- (void)menu
{
    UIActionSheet *ksyActionSheet=[[UIActionSheet alloc]initWithTitle:@"想要做什么？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"订阅",@"举报", nil];
    [ksyActionSheet showInView:self.view];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
