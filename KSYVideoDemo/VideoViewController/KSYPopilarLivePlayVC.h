//
//  KSYPopilarLivePlayVC.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  传统视频直播播放

#import <UIKit/UIKit.h>
#import "KSYBaseViewController.h"
@interface KSYPopilarLivePlayVC : KSYBaseViewController
@property (nonatomic, copy)     NSString    *urlPath;
@property (nonatomic ,strong)   NSArray     *spectatorsArray;
@end
