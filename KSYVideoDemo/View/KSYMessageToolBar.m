//
//  KSYMessageToolBar.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/10.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYMessageToolBar.h"
#import "UIView+BFExtension.h"
@interface KSYMessageToolBar ()<UITextFieldDelegate>


@property (nonatomic) CGFloat version;


@property (strong, nonatomic) UIView *toolbarBackView;
@property (strong, nonatomic) UIButton *controCommentBtn;
@property (strong, nonatomic) UIButton *shareBtn;
@end

@implementation KSYMessageToolBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupConfigure];
        [self setupSubviews];

    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self setupConfigure];
        [self setupSubviews];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _delegate = nil;
    _inputTexField.delegate = nil;
    _inputTexField = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _controCommentBtn.frame = CGRectMake(10, 5, 40, 40);
    _inputTexField.frame = CGRectMake(_controCommentBtn.right + 10, 5, self.frame.size.width - 120, 40);
    _shareBtn.frame = CGRectMake(_inputTexField.right + 10, 5, 40, 40);
}

- (void)setupConfigure
{
    self.version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    self.toolbarBackView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.toolbarBackView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupSubviews
{
    
    //控制评论
    _controCommentBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
    [_controCommentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _controCommentBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_controCommentBtn setTitle:@"互动开" forState:UIControlStateNormal];
    _controCommentBtn.tag = 231;
    _controCommentBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_controCommentBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //分享
    _shareBtn = [[UIButton alloc] init];
    [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    _shareBtn.tag = 232;
    _shareBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [_shareBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _inputTexField = [[UITextField  alloc] init];
    _inputTexField.backgroundColor = [UIColor grayColor];
    _inputTexField.placeholder = @" 说点什么吧...";
    _inputTexField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _inputTexField.returnKeyType = UIReturnKeySend;
    _inputTexField.enablesReturnKeyAutomatically = YES; // UITextView内部判断send按钮是否可以用
    _inputTexField.delegate = self;
    _inputTexField.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    _inputTexField.layer.borderWidth = 0.65f;
    _inputTexField.layer.cornerRadius = 6.0f;
    
    
    [self addSubview:self.controCommentBtn];
    [self addSubview:self.shareBtn];
    [self addSubview:self.inputTexField];
}

#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button
{
    if (button.tag == 231) {
        if (!button.selected) {
            [_controCommentBtn setTitle:@"互动关" forState:UIControlStateNormal];

            if (self.userEventBlock) {
                self.userEventBlock(button.tag - 230);
            }

        }else {
            [_controCommentBtn setTitle:@"互动开" forState:UIControlStateNormal];

            if (self.userEventBlock) {
                self.userEventBlock(button.tag - 231);
            }

        }
        button.selected = !button.selected;

    }else {
        if (self.userEventBlock) {
            self.userEventBlock(button.tag - 230);
        }

    }
}
#pragma mark - change frame

- (void)willShowBottomHeight:(CGFloat)bottomHeight
{
//    CGRect fromFrame = self.frame;
    if (bottomHeight == 184) {
        return;
    }
    CGFloat toHeight = self.frame.size.height + bottomHeight;

    //    NSLog(@"toheight is %f",toHeight);
//    CGRect toFrame = CGRectMake(fromFrame.origin.x, fromFrame.origin.y + (fromFrame.size.height - toHeight), fromFrame.size.width, toHeight);
//    
//    if(bottomHeight == 0 && self.frame.size.height == self.toolbarBackView.frame.size.height)
//    {
//        return;
//    }
//    
//    
//    self.frame = toFrame;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didChangeFrameToHeight:endHeight:)]) {
        [_delegate didChangeFrameToHeight:toHeight endHeight:bottomHeight];
    }
}
- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {

        [self willShowBottomHeight:toFrame.size.height];
    }
    else if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        [self willShowBottomHeight:-toFrame.size.height];
    }
    else{
        [self willShowBottomHeight:toFrame.size.height];
    }
}


- (CGFloat)getTextViewContentH:(UITextView *)textView
{
    if (self.version >= 7.0)
    {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    } else {
        return textView.contentSize.height;
    }
}

#pragma mark - UIKeyboardNotification

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{

    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    void(^animations)() = ^{
        [self willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    
    void(^completion)(BOOL) = ^(BOOL finished){
    };
    
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:completion];
}

#pragma mark - UITextViewDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(inputTextViewWillBeginEditing:)]) {
        [self.delegate inputTextViewWillBeginEditing:self.inputTexField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidBeginEditing:)]) {
        [self.delegate inputTextViewDidBeginEditing:self.inputTexField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(didSendText:)]) {
            [self.delegate didSendText:textView.text];
            self.inputTexField.text = @"";
        }
        
        return NO;
    }
    return YES;
}

@end
