//
//  KSYNavigationView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/8.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYNavigationView.h"
@interface KSYNavigationView (){
    UIButton *_ksyBackBtn;
    UILabel *_ksyTitleLabel;
    UIButton *_ksyMenuBtn;
}
@end
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
    _ksyBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _ksyBackBtn.frame=CGRectMake(5, 5, 40, 30);
    [_ksyBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_ksyBackBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    _ksyBackBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    [_ksyBackBtn addTarget:self action:@selector(myback:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_ksyBackBtn];
    
    //添加标题标签
    _ksyTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.width/2-50, 0, 100, 40)];
    _ksyTitleLabel.text=@"视频标题";
    _ksyTitleLabel.textColor=[UIColor whiteColor];
    _ksyTitleLabel.textAlignment=NSTextAlignmentCenter;
    _ksyTitleLabel.font=[UIFont systemFontOfSize:WORDFONT18];
    [self addSubview:_ksyTitleLabel];
    
    
    //添加选项按钮
    _ksyMenuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _ksyMenuBtn.frame=CGRectMake(self.right-45, 5, 40, 30);
    [_ksyMenuBtn setTitle:@"选项" forState:UIControlStateNormal];
    [_ksyMenuBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    _ksyMenuBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    [_ksyMenuBtn addTarget:self action:@selector(mymenu:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_ksyMenuBtn];
}
- (void)myback:(UIButton *)btn{
    NSLog(@"点击按钮");
    if (self.back) {
        self.back(btn);
    }
}
- (void)mymenu:(UIButton *)btn{
    if (self.mune) {
        self.mune(btn);
    }
}
@end
