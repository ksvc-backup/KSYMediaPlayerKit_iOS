//
//  KSYProgressView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/26.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYProgressView.h"

@implementation KSYProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self){
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    // **** progress view
    //进度指示
    self.backgroundColor = [UIColor clearColor];
    self.tag = kProgressViewTag;
    
    //进度指示背景视图
    UIView *progressBgView = [[UIView alloc] initWithFrame:self.bounds];
    progressBgView.backgroundColor = [UIColor blackColor];
    progressBgView.layer.masksToBounds = YES;
    progressBgView.layer.cornerRadius = 5;
    progressBgView.alpha = 0.7;
    [self addSubview:progressBgView];
    
    //当前进度标签
    CGRect curProgressLabelRect = CGRectMake(0, 0, self.width, 50);
    UILabel *curProgressLabel = [[UILabel alloc] initWithFrame:curProgressLabelRect];
    curProgressLabel.alpha = 0.6f;
    curProgressLabel.tag = kCurProgressLabelTag;
    curProgressLabel.text = @"00:00";
    curProgressLabel.font = [UIFont boldSystemFontOfSize:20];
    curProgressLabel.textAlignment = NSTextAlignmentCenter;
    curProgressLabel.textColor = [UIColor whiteColor];
    [self addSubview:curProgressLabel];
    
    //快进图片
    CGRect wardImgViewRect = CGRectMake(10, 15, 20, 20);
    UIImageView *wardImgView = [[UIImageView alloc] initWithFrame:wardImgViewRect];
    wardImgView.alpha = 0.6f;
    UIImage *forwardImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_forward_normal"];
    wardImgView.image = forwardImg;
    wardImgView.tag =kWardMarkImgViewTag;
    [self addSubview:wardImgView];

}



@end
