//
//  KSYToolView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/26.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYToolView.h"
#define  TOPSPACING 10


@implementation KSYToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

#pragma mark 添加子视图
- (void)addSubviews
{
    self.backgroundColor=[UIColor blackColor];
    self.alpha=0.7;
    
    
    //添加返回按钮 做啥才能体现你的水平
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(2, TOPSPACING, 40, 40);
    [self addSubview:backBtn];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    [backBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //添加视屏标签
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(backBtn.right+10, TOPSPACING, 100, 40)];
    titleLable.text=@"视屏名称";
    [self addSubview:titleLable];
    titleLable.font=[UIFont systemFontOfSize:WORDFONT18];
    titleLable.textColor=[UIColor whiteColor];
    
    //循环添加三个按钮
    NSArray *array=[NSArray arrayWithObjects:@"report",@"subscribed",@"set", nil];
    for (int i=0; i<3; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.frame=CGRectMake(self.width-(170-50*i), TOPSPACING, 80, 40);
        [btn setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=99-i;
        btn.showsTouchWhenHighlighted=YES;
    }
}

- (void)back
{
    if (self.backEventBlock) {
        self.backEventBlock();
    }
}

- (void)clickBtn:(UIButton *)btn
{
    if (btn.tag==97) {
        if (self.showSetView) {
            self.showSetView(btn);
        }
    }else if (btn.tag==98){
        if (self.subscribeBtn) {
            self.subscribeBtn(btn);
        }
    }else if (btn.tag==99){
        if (self.reportBtn) {
            self.reportBtn(btn);
        }
    }
}
@end
