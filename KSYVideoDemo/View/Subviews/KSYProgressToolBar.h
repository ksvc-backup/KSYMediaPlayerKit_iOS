//
//  KSYProgressToolBar.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/17.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  进度控制Bar

#import <UIKit/UIKit.h>

@interface KSYProgressToolBar : UIView

@property (nonatomic, copy)void (^playControlEventBlock)(BOOL isStop);

@property (nonatomic, copy)void (^seekToBlock)(double position);
@property (strong ,nonatomic) void (^userEventBlock)(NSInteger index);

- (void)updataSliderWithPosition:(NSInteger)position duration:(NSInteger)duration;
- (void)playerIsStop:(BOOL)isStop;

@end
