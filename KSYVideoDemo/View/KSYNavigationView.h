//
//  KSYNavigationView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/8.
//  Copyright © 2016年 kingsoft. All rights reserved.
//  这里使用代理

#import <UIKit/UIKit.h>

@interface KSYNavigationView : UIView

@property (nonatomic, copy) void (^back)(UIButton *btn);
@property (nonatomic, copy) void (^mune)(UIButton *btn);

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UIButton *ksyBackBtn;
@property (nonatomic, strong) UILabel *ksyTitleLabel;
@property (nonatomic, strong) UIButton *ksyMenuBtn;

@end
