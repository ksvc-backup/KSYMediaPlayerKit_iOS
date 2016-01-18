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
    self.alpha=0.5;
    //用户名和关注按钮
    kUserImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [self addSubview:kUserImageView];
    kUserImageView.layer.masksToBounds=YES;
    kUserImageView.layer.cornerRadius=15;
    kUserImageView.contentMode=UIViewContentModeScaleAspectFit;//等比例缩放
    kUserImageView.image=[UIImage imageNamed:@"avatar20"];

     kUserName=[[UILabel alloc]initWithFrame:CGRectMake(kUserImageView.right+5, kUserImageView.center.y-10, 80, 20)];
    [self addSubview:kUserName];
    kUserName.text=@"用户名ID";
    kUserName.textColor=[UIColor whiteColor];
    kUserName.font=[UIFont systemFontOfSize:WORDFONT16];

    
    
    
    kForcBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.right-65, 7.5, 55, 25)];
    [self addSubview:kForcBtn];
    [kForcBtn setTitle:@"＋关注" forState:UIControlStateNormal];
    [kForcBtn setTitleColor:THEMECOLOR forState:UIControlStateNormal];
    kForcBtn.titleLabel.font=[UIFont systemFontOfSize:WORDFONT16];
    //设置边框
    kForcBtn.layer.masksToBounds=YES;
    kForcBtn.layer.cornerRadius=5;
    kForcBtn.layer.borderColor=[THEMECOLOR CGColor];
    kForcBtn.layer.borderWidth=1;
    [kForcBtn addTarget:self action:@selector(clickForceBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickForceBtn:(UIButton *)btn{
    if (self.forceBtn) {
        self.forceBtn(btn);
    }
}
@end
