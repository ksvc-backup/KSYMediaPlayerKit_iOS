//
//  KSYLockView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/26.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYLockView.h"

@implementation KSYLockView


- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    //锁屏按钮大小
    self.backgroundColor = [UIColor clearColor];

    
    //锁屏背景视图
    UIView *lockBgView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundColor = [UIColor blackColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.width / 2;
    self.alpha = 0.6f;
    [self addSubview:lockBgView];
    
    //锁屏按钮
    UIButton *lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lockBtn.alpha = 0.6f;
    lockBtn.frame = CGRectMake(10, 10, self.width - 20, self.width - 20);
    UIImage *lockOpenImg_n = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_lock_open_normal"];
    UIImage *lockOpenImg_h = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_lock_open_hl"];
    [lockBtn setImage:lockOpenImg_n forState:UIControlStateNormal];
    [lockBtn setImage:lockOpenImg_h forState:UIControlStateHighlighted];
    [lockBtn addTarget:self action:@selector(clickLockBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lockBtn];
}

- (void)clickLockBtn:(UIButton *)btn{
    if (self.kLockViewBtn) {
        self.kLockViewBtn(btn);
    }
}



@end
