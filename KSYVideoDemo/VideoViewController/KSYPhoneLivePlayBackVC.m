//
//  KSYPhoneLivePlayBackVC.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYPhoneLivePlayBackVC.h"

#import "KSYPhoneLivePlayView.h"
#import "CommentModel.h"


@interface KSYPhoneLivePlayBackVC ()
{
    KSYPhoneLivePlayView    *_phoneLivePlayVC;
    NSTimer                 *_commetnTimer;
    NSTimer                 *_praiseTimer0;
    NSTimer                 *_praiseTimer1;

}

@end

@implementation KSYPhoneLivePlayBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf(KSYBaseViewController);
    //模拟观众评论
    _commetnTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addNewCommentWith) userInfo:nil repeats:YES];
    //模拟点赞事件
    _praiseTimer0 = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(praiseEvent) userInfo:nil repeats:YES];
//    _praiseTimer1 = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(presentEvent) userInfo:nil repeats:YES];
    
    _phoneLivePlayVC = [[KSYPhoneLivePlayView alloc] initWithFrame:self.view.bounds urlString:self.videoUrlString playState:KSYPhoneLivePlayBack];
    _phoneLivePlayVC.isBackGroundReleasePlayer = self.isReleasePlayer;

    _phoneLivePlayVC.liveBroadcastCloseBlock = ^{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定退出观看？" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    };
    _phoneLivePlayVC.shareBlock = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请调用分享接口" delegate:weakSelf cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    };
    _phoneLivePlayVC.liveBroadcastReporteBlock = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请调用举报接口" delegate:weakSelf cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    };
    [self.view addSubview:_phoneLivePlayVC];


}

- (void)praiseEvent
{
    [_phoneLivePlayVC onPraiseWithSpectatorsInteractiveType:SpectatorsInteractivePraise];
}

- (void)presentEvent
{
    [_phoneLivePlayVC onPraiseWithSpectatorsInteractiveType:SpectatorsInteractivePresent];
    
}

- (void)addNewCommentWith
{
    CommentModel *model = [[CommentModel alloc] init];
    model.userComment = @"哇，大美女！";
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    model.backColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.9];
    
    CGFloat hue1 = ( arc4random() % 256 / 256.0 );
    CGFloat saturation1 = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness1 = ( arc4random() % 128 / 256.0 ) + 0.5;
    model.headColor = [UIColor colorWithHue:hue1 saturation:saturation1 brightness:brightness1 alpha:1];
    
    [_phoneLivePlayVC addNewCommentWith:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [_commetnTimer invalidate];
        [_praiseTimer0 invalidate];
        [_praiseTimer1 invalidate];
        [_phoneLivePlayVC shutDown];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

@end
