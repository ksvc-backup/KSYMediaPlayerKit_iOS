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
    self.backgroundColor = [UIColor blackColor];
    self.alpha=0.7;
    //锁屏背景视图
    UIView *lockBgView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundColor = [UIColor blackColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.width / 2;
    [self addSubview:lockBgView];
    
    //锁屏按钮
    UIButton *lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lockBtn.frame = CGRectMake(10, 10, self.width - 20, self.width - 20);
    UIImage *lockOpenImg_n = [UIImage imageNamed:@"screenLock_off"];
    [lockBtn setImage:lockOpenImg_n forState:UIControlStateNormal];
    [lockBtn addTarget:self action:@selector(clickLockBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lockBtn];
}

- (void)clickLockBtn:(UIButton *)btn{
    if (self.kLockViewBtn) {
        self.kLockViewBtn(btn);
    }
}



@end
