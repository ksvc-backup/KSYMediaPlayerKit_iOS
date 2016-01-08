//
//  KSYNavigationView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/8.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYNavigationView.h"

@implementation KSYNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self addsubViews];
    }
    return self;
}

- (void)addsubViews{
    //设置返回按钮
    UIButton *ksyBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    ksyBackBtn.frame=CGRectMake(5, 5, 40, 30);
    [ksyBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [ksyBackBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    ksyBackBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    [ksyBackBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ksyBackBtn];
    
    //添加标题标签
    UILabel *ksyTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    ksyTitleLabel.text=@"视频标题";
    ksyTitleLabel.textColor=[UIColor whiteColor];
    ksyTitleLabel.textAlignment=NSTextAlignmentCenter;
    ksyTitleLabel.font=[UIFont systemFontOfSize:WORDFONT18];
    ksyTitleLabel.center=self.center;
    [self addSubview:ksyTitleLabel];
    
    
    //添加选项按钮
    UIButton *ksyMenuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    ksyMenuBtn.frame=CGRectMake(self.right-45, 5, 40, 30);
    [ksyMenuBtn setTitle:@"选项" forState:UIControlStateNormal];
    [ksyMenuBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    ksyMenuBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    [ksyMenuBtn addTarget:self action:@selector(menu) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ksyMenuBtn];
}
- (void)back{
    
}
- (void)menu{
    
}
@end
