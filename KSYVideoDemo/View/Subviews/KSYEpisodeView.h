//
//  KSYEpisodeView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/11.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSYEpisodeView : UIView


@property (nonatomic, copy) void(^changeVidoe)(NSString  *videoStr);

@property (nonatomic, strong) UITableView *episodeTableView;

@end
