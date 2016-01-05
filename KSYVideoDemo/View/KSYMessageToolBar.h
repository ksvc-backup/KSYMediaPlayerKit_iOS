//
//  KSYMessageToolBar.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/10.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  发送消息Bar

#import <UIKit/UIKit.h>

@protocol KSYMessageToolBarDelegate;

@interface KSYMessageToolBar : UIView


@property (nonatomic, weak)id<KSYMessageToolBarDelegate> delegate;
/**
 *  用于输入文本消息的输入框
 */
@property (strong, nonatomic) UITextField *inputTexField;

@property (strong ,nonatomic) void (^userEventBlock)(NSInteger index);
@end

@protocol KSYMessageToolBarDelegate <NSObject>

@optional

/**
 *  文字输入框开始编辑
 *
 *  @param inputTextView 输入框对象
 */
- (void)inputTextViewDidBeginEditing:(UITextField *)messageInputTextView;

/**
 *  文字输入框将要开始编辑
 *
 *  @param inputTextView 输入框对象
 */
- (void)inputTextViewWillBeginEditing:(UITextField *)messageInputTextView;

/**
 *  发送文字消息，可能包含系统自带表情
 *
 *  @param text 文字消息
 */
- (void)didSendText:(NSString *)text;

@required
/**
 *  高度变到toHeight
 */
- (void)didChangeFrameToHeight:(CGFloat)toHeight endHeight:(CGFloat)endHeight;

@end
