//
//  KSYShortVideoPlayView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/25.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYPopularVideoView.h"
#import "KSYShortTabelViewCell.h"

@interface KSYShortVideoPlayView : UIView

- (instancetype)initWithFrame:(CGRect)frame UrlPathString:(NSString *)urlPathString;

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) NSMutableArray *modelsCells;
@property (nonatomic, strong) KSYShortTabelViewCell *videoCell;
@property (nonatomic, assign) BOOL isDidRelease;
@end
