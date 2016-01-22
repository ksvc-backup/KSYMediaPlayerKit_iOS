//
//  KSYLockView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/26.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSYLockView : UIView
@property (nonatomic, copy) void (^kLockViewBtn)(UIButton *btn);
@end
