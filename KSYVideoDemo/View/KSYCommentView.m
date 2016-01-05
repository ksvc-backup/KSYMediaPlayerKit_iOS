//
//  KSYCommentView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYCommentView.h"

@interface KSYCommentView ()<UITextFieldDelegate>

@end


@implementation KSYCommentView

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
    self.backgroundColor=KSYCOLER(34, 34, 34);
    
    UITextField *kTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, self.width-10-50, 30)];
    kTextField.tag=kCommentFieldTag;
    [self addSubview:kTextField];
    kTextField.backgroundColor=KSYCOLER(100, 100, 100);
    kTextField.placeholder=@"填写评论内容";
    kTextField.delegate=self;
    
    
    UIButton *kSendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    kSendBtn.frame=CGRectMake(kTextField.right+10, 5, 40, 30);
    [self addSubview:kSendBtn];
    [kSendBtn setTitle:@"发送"forState:UIControlStateNormal];
    [kSendBtn setTitleColor:KSYCOLER(32, 223, 232) forState:UIControlStateNormal];
    kSendBtn.layer.masksToBounds=YES;
    kSendBtn.layer.borderColor=[KSYCOLER(32, 223, 232)CGColor];
    kSendBtn.layer.borderWidth=1;
    kSendBtn.layer.cornerRadius=5;
    [kSendBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.textFieldDidBeginEditing) {
        self.textFieldDidBeginEditing();
    }
}
- (void)sendComment
{
    if (self.send) {
        self.send();
    }
}

@end
