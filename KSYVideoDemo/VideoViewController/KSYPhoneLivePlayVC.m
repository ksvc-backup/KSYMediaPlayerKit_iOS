//
//  KSYPhoneLivePlayVC.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYPhoneLivePlayVC.h"
#import "KSYPhoneLivePlayView.h"
#import "CommentModel.h"
#import "SpectatorModel.h"
#import "UserInfoModel.h"

@interface KSYPhoneLivePlayVC ()<UIAlertViewDelegate>
{
    KSYPhoneLivePlayView    *_phoneLivePlayVC;
    NSMutableArray          *_spectatorsArr;
    NSTimer                 *_commetnTimer;
    NSTimer                 *_commetnTimer1;
    NSTimer                 *_praiseTimer0;
    NSTimer                 *_praiseTimer1;
    NSInteger               _index;         //测试数据
}

@property (nonatomic, strong)UserInfoModel *userModel;
@end

@implementation KSYPhoneLivePlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    appDelegate.allowRotation=NO;
    WeakSelf(KSYBaseViewController);
    //模拟观众评论
    _commetnTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addNewCommentWith) userInfo:nil repeats:YES];
    //模拟用户进入
    _commetnTimer1 = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(addNewUserName) userInfo:nil repeats:YES];

    //模拟点赞事件
    _praiseTimer0 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(praiseEvent) userInfo:nil repeats:YES];
//    _praiseTimer1 = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(presentEvent) userInfo:nil repeats:YES];

    //模拟观众信息
    _spectatorsArr = [[NSMutableArray alloc] initWithCapacity:0];
    _index = 0;
    [self requestSepctators];
    
    _phoneLivePlayVC = [[KSYPhoneLivePlayView alloc] initWithFrame:self.view.bounds urlString:self.videoUrlString playState:KSYPhoneLivePlay];
    //观看用户
    _phoneLivePlayVC.spectatorsArray = _spectatorsArr;
    _phoneLivePlayVC.userModel = self.userModel;
    _phoneLivePlayVC.liveBroadcastCloseBlock = ^{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定退出观看？" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    };
    _phoneLivePlayVC.liveBroadcastReporteBlock = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请调用举报接口" delegate:weakSelf cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    };
    _phoneLivePlayVC.shareBlock = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请调用分享接口" delegate:weakSelf cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
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
    model.userComment = @"评论评论评论";
    model.userName = @"用户名";

    [_phoneLivePlayVC addNewCommentWith:model];
}

- (void)addNewUserName
{
    
    [_phoneLivePlayVC addNewCommentWith:[NSString stringWithFormat:@"王大锤%@",@(_index)]];
    _index++;

}

- (void)requestSepctators
{
    for (int i = 0; i < 20; i++) {
        SpectatorModel *model = [SpectatorModel new];
        model.name = @"王大锤";
        model.signConent = @"我叫王大锤，万万没想到的是...我的生涯一片无悔，我想起那天夕阳下的奔跑，那是我逝去的青春";
        model.liveNumber = @"888";
        model.fansNumber = @"20K";
        model.followNumber = @"88";
        model.praiseNumber = @"5.5w";
        [_spectatorsArr addObject:model];
    }
}

- (UserInfoModel *)userModel
{
    if (_userModel == nil) {
        _userModel = [UserInfoModel new];
    }
    _userModel.name = @"王大锤";
    _userModel.signConent = @"我叫王大锤，万万没想到的是...我的生涯一片无悔，我想起那天夕阳下的奔跑，那是我逝去的青春";
    _userModel.liveNumber = @"888";
    _userModel.fansNumber = @"20K";
    _userModel.followNumber = @"88";
    _userModel.praiseNumber = @"5.5w";

    return _userModel;
}
//获取随机色
- (UIColor *)getRandomColorWithalpha:(float)alpla
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpla];
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
        [_commetnTimer1 invalidate];
        [_praiseTimer0 invalidate];
        [_praiseTimer1 invalidate];
        [_phoneLivePlayVC shutDown];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}

@end
