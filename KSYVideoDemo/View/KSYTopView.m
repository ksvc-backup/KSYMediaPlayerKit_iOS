//
//  KSYTopView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYTopView.h"

@implementation KSYTopView
@synthesize kUserImageView;
@synthesize kUserName;
@synthesize kForcBtn;





- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews
{

    self.backgroundColor=[UIColor blackColor];
    self.alpha=0.6;
    //用户名和关注按钮
    kUserImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [self addSubview:kUserImageView];
    kUserImageView.layer.masksToBounds=YES;
    kUserImageView.layer.cornerRadius=15;
    kUserImageView.contentMode=UIViewContentModeScaleAspectFit;//等比例缩放
    kUserImageView.image=[UIImage imageNamed:@"touxiang.png"];

     kUserName=[[UILabel alloc]initWithFrame:CGRectMake(kUserImageView.right+5, kUserImageView.center.y-10, 80, 20)];
    [self addSubview:kUserName];
    kUserName.text=@"用户名ID";
    kUserName.textColor=[UIColor whiteColor];
    kUserName.font=[UIFont systemFontOfSize:WORDFONT16];

    kForcBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.right-70, 5, 60, 30)];
    [self addSubview:kForcBtn];
    [kForcBtn setTitle:@"＋关注" forState:UIControlStateNormal];
    [kForcBtn setTitleColor:KSYCOLER(92, 223, 232) forState:UIControlStateNormal];
    //设置边框
    kForcBtn.layer.masksToBounds=YES;
    kForcBtn.layer.cornerRadius=5;
    kForcBtn.layer.borderColor=[KSYCOLER(92, 223, 232)CGColor];
    kForcBtn.layer.borderWidth=1;
}

@end
