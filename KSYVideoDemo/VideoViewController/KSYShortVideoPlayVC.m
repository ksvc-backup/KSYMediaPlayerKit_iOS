//
//  KSYShortVideoPlayVC.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYShortVideoPlayVC.h"
#import "KSYShortVideoPlayView.h"

@interface KSYShortVideoPlayVC ()
{
    KSYShortVideoPlayView *ksyShortVideoplayView;
    UIAlertView *alertView;
}

@end

@implementation KSYShortVideoPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self changeNavigationStayle];
    ksyShortVideoplayView=[[KSYShortVideoPlayView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) UrlPathString:_videoPath];
    ksyShortVideoplayView.isDidRelease=self.isReleasePlayer;
    [self.view addSubview:ksyShortVideoplayView];
}

#pragma mark 改变导航栏状态
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

#pragma mark 转到另一个控制器


- (void)back
{
    [ksyShortVideoplayView.videoCell.ksyShortView shutDown];
    [ksyShortVideoplayView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
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


@end
