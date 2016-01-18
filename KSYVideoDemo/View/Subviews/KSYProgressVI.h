//
//  KSYProgressVI.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/15.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KSYProgressDelegate <NSObject>

- (void)progDidBegin;
- (void)progChanged;
- (void)progChangeEnd;

@end


@interface KSYProgressVI : UIView

@property (nonatomic, strong) id<KSYProgressDelegate>delegate;
@property (nonatomic, strong) UISlider *kPlaySlider;
@property (nonatomic, strong) UIProgressView *kProgressView;


- (void)updateProgress:(NSInteger)duration Position:(NSInteger)currentPlaybackTime playAbleDuration:(NSInteger)playableDuration;
- (void)setLength;
- (void)resetLength;
@end
