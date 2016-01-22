//
//  KSYProgressVI.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/15.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSYProgressVI : UIView

@property (nonatomic, copy) void (^progDidBegin)(UISlider *slider);
@property (nonatomic, copy) void (^progChanged)(UISlider *slider);
@property (nonatomic, copy) void (^progChangeEnd)(UISlider *slider);
@property (nonatomic, strong) UISlider *kPlaySlider;
@property (nonatomic, strong) UIProgressView *kProgressView;


- (void)updateProgress:(NSInteger)duration Position:(NSInteger)currentPlaybackTime playAbleDuration:(NSInteger)playableDuration;
- (void)setLength;
- (void)resetLength;
@end
