//
//  RootViewController.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/9/17.
//  Copyright (c) 2015年 kingsoft. All rights reserved.
//

#import "KSYMainViewController.h"
#import "VideoViewController.h"
#import "KSYPopilarLivePlayVC.h"
#import "KSYPopilarLivePlayBackVC.h"
#import "KSYPhoneLivePlayVC.h"
#import "KSYPhoneLivePlayBackVC.h"
#import "KSYVideoOnDemandPlayVC.h"
#import "KSYShortVideoPlayVC.h"

@interface KSYMainViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *_sesionArr;
    UITextField *_httpTextF;
    UITextField *_rtmpTextF;
    UISwitch *_switchControl;
}
@end

@implementation KSYMainViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"KSYPlayer";
    self.view.backgroundColor = [UIColor whiteColor];
    _sesionArr = [[NSArray alloc] initWithObjects:@"传统直播",@"手机直播",@"在线视频点播",@"短视频播放",@"列表浮窗", nil];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 64 + 20, 300, 20)];
    label1.text = @"APP退到后台，锁屏，来电等中断是否释放播放器";
    label1.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:label1];
    
    _switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(20, label1.bottom+5, 40, 25)];
    [_switchControl addTarget:self action:@selector(switchControlEvent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_switchControl];
    
    
    
    UILabel *httpUrlLabl = [[UILabel alloc] initWithFrame:CGRectMake(label1.left, _switchControl.bottom + 5, 60, 20)];
    httpUrlLabl.text = @"点播URL";
    httpUrlLabl.font = [UIFont systemFontOfSize:13.0];

    [self.view addSubview:httpUrlLabl];
    
    UILabel *rtmpUrlLabl = [[UILabel alloc] initWithFrame:CGRectMake(label1.left, httpUrlLabl.bottom + 7, 60, 20)];
    rtmpUrlLabl.text = @"直播URL";
    rtmpUrlLabl.font = [UIFont systemFontOfSize:13.0];

    [self.view addSubview:rtmpUrlLabl];

    
    _httpTextF = [[UITextField alloc] initWithFrame:CGRectMake(httpUrlLabl.right + 5, httpUrlLabl.top,self.view.width-httpUrlLabl.right-10, 20)];
    _httpTextF.adjustsFontSizeToFitWidth = YES;
    _httpTextF.text = @"http://121.42.58.232:8980/hls_test/1.m3u8";
    _httpTextF.borderStyle = UITextBorderStyleRoundedRect;
    _httpTextF.returnKeyType = UIReturnKeyDone;
    _httpTextF.font = [UIFont systemFontOfSize:13.0];
    _httpTextF.delegate = self;
    [self.view addSubview:_httpTextF];
    
    _rtmpTextF = [[UITextField alloc] initWithFrame:CGRectMake(rtmpUrlLabl.right + 5, rtmpUrlLabl.top, self.view.width-_httpTextF.left-5, 20)];
    _rtmpTextF.adjustsFontSizeToFitWidth = YES;
    _rtmpTextF.text = @"rtmp://live.hkstv.hk.lxdns.com/live/hks";
    _rtmpTextF.borderStyle = UITextBorderStyleRoundedRect;
    _rtmpTextF.returnKeyType = UIReturnKeyDone;
    _rtmpTextF.font = [UIFont systemFontOfSize:13.0];
    _rtmpTextF.delegate = self;
    [self.view addSubview:_rtmpTextF];

    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, rtmpUrlLabl.bottom + 10, self.view.frame.size.width, self.view.frame.size.height - rtmpUrlLabl.bottom - 10)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [self.view addSubview:tableView];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"netWorkStateChanged" object:@(netStatus)];
}

- (void)switchControlEvent:(UISwitch *)switchControl
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sesionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    switch (section) {
        case 0:
            row = 2;
            break;
        case 1:
            row = 2;
            break;
        case 2:
            row = 1;
            break;
        case 3:
            row = 1;
            break;
        case 4:
            row = 1;
            break;
        default:
            break;
    }
    return row;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sesionArr objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.textAlignment = 1;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"传统直播播放";
            }else {
                cell.textLabel.text = @"传统直播回放";
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"手机直播播放";
            }else {
                cell.textLabel.text = @"手机直播回放";
            }

        }
            break;
        case 2:
        {
            cell.textLabel.text = @"在线视频点播";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"短视频播放";
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"列表浮窗";
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                KSYPopilarLivePlayVC *view=[[KSYPopilarLivePlayVC alloc]init];
                view.urlPath=_rtmpTextF.text;
                [self.navigationController pushViewController:view animated:YES];
               
            }else {
                KSYPopilarLivePlayBackVC *view=[[KSYPopilarLivePlayBackVC alloc]init];
                view.urlPath=_httpTextF.text;
                view.isReleasePlayer=_switchControl.isOn;
                [self.navigationController pushViewController:view animated:YES];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                KSYPhoneLivePlayVC *phoneLivePlayerVC = [KSYPhoneLivePlayVC new];
                phoneLivePlayerVC.videoUrlString = _rtmpTextF.text;
                phoneLivePlayerVC.isReleasePlayer = _switchControl.isOn;                [self.navigationController presentViewController:phoneLivePlayerVC animated:YES completion:nil];
            }else{
                KSYPhoneLivePlayBackVC *phoneLivePlayBackVC = [KSYPhoneLivePlayBackVC new];
                phoneLivePlayBackVC.videoUrlString = _httpTextF.text;
                phoneLivePlayBackVC.isReleasePlayer = _switchControl.isOn;
                [self.navigationController presentViewController:phoneLivePlayBackVC animated:YES completion:nil];

            }
        }
            break;
        case 2:
        {
            KSYVideoOnDemandPlayVC *view=[[KSYVideoOnDemandPlayVC alloc]init];
            view.urlPath=_httpTextF.text;
            view.isReleasePlayer=_switchControl.isOn;
            [self.navigationController pushViewController:view animated:YES];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂未开放，敬请期待" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alertView show];

        }
            break;
        case 3:
        {
            KSYShortVideoPlayVC *view=[[KSYShortVideoPlayVC alloc]init];
            view.videoPath=_httpTextF.text;
            view.isReleasePlayer = _switchControl.isOn;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 4:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂未开放，敬请期待" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
            break;
        default:
            break;
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
