//
//  KSYToolView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/26.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSYToolView : UIView
@property (nonatomic, copy) void (^showSetView)(UIButton *btn);
@property (nonatomic, copy) void (^backEventBlock)();
@end
