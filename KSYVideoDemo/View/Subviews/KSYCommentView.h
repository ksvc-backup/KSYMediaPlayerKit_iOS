//
//  KSYCommentView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSYCommentView : UIView
@property (nonatomic, copy) void (^textFieldDidBeginEditing)();
@property (nonatomic, copy) void (^send)();
@end
