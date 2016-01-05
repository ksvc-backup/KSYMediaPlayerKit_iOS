//
//  KSYBrightnessView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/25.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYBrightnessView.h"

@implementation KSYBrightnessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    // **** brightness view
    //亮度条
//    CGRect brightnessRect = CGRectMake(kCoverBarLeftMargin, size.height / 4, kCoverBarWidth, size.height / 2);
//    UIView *brightnessView = [[UIView alloc] initWithFrame:brightnessRect];
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;

    
    //亮度条背景视图
    UIView *brightnessBgView = [[UIView alloc] initWithFrame:self.bounds];
    brightnessBgView.backgroundColor = [UIColor blackColor];
    brightnessBgView.alpha = 0.6f;
    [self addSubview:brightnessBgView];
    
    UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot_normal"];
    UIImage *minImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"slider_color"];
    //高亮模式图片
    CGRect brightnessImgViewRect1 = CGRectMake(3, 3, self.width - 6, self.width - 6);
    UIImageView *brightnessImgView1 = [[UIImageView alloc] initWithFrame:brightnessImgViewRect1];
    UIImage *brightnessImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"brightness"];
    brightnessImgView1.image = brightnessImg;
    [self addSubview:brightnessImgView1];
    
    //亮度条
    CGFloat sliderWidth = self.height - 45;
    CGFloat sliderHeight = 15;
    CGFloat X = -sliderWidth / 2 + self.width / 2;
    CGFloat Y = self.height / 2 - sliderHeight / 2 + 4;
    CGRect brightnessSliderRect = CGRectMake(X, Y, sliderWidth, sliderHeight);
    UISlider *brightnessSlider = [[UISlider alloc] initWithFrame:brightnessSliderRect];
    [brightnessSlider setMinimumTrackImage:minImg forState:UIControlStateNormal];
    brightnessSlider.maximumTrackTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    [brightnessSlider setThumbImage:dotImg forState:UIControlStateNormal];
    brightnessSlider.value = [[UIScreen mainScreen] brightness];
    brightnessSlider.tag = kBrightnessSliderTag;
    [brightnessSlider addTarget:self action:@selector(brightnessChanged:) forControlEvents:UIControlEventValueChanged];
    [brightnessSlider addTarget:self action:@selector(brightnessDidBegin:) forControlEvents:UIControlEventTouchDown];
    [brightnessSlider addTarget:self action:@selector(brightnessChangeEnd:) forControlEvents:(UIControlEventTouchUpOutside | UIControlEventTouchCancel|UIControlEventTouchUpInside)];
    [self addSubview:brightnessSlider];
    brightnessSlider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    
    //低亮模式图片
    CGFloat low_brightness = kCoverBarWidth - 10;
    CGRect brightnessImgViewRect2 = CGRectMake(5, self.height - low_brightness - 3, low_brightness, low_brightness);
    UIImageView *brightnessImgView2 = [[UIImageView alloc] initWithFrame:brightnessImgViewRect2];
    brightnessImgView2.image = brightnessImg;
    [self addSubview:brightnessImgView2];
}




- (void)brightnessDidBegin:(UISlider *)slider
{
    if (self.brightDidBegin)
    {
        self.brightDidBegin(slider);
    }
}

- (void)brightnessChanged:(UISlider *)slider {
    
    if (self.brightChanged)
    {
        self.brightChanged(slider);
    }
    
}

- (void)brightnessChangeEnd:(UISlider *)slider {
    if(self.brightChangeEnd)
    {
        self.brightChangeEnd(slider);
    }
}
@end
