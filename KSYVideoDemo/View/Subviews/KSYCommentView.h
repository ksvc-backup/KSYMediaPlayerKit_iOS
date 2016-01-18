//
//  KSYCommentView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSYCommentView : UIView
@property (nonatomic, strong) UITextField *kTextField;
@property (nonatomic, copy) void (^changeFrame)(CGFloat keyBoardHeight);
@property (nonatomic, copy) void (^send)();
@end
