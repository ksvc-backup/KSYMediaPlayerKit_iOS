//
//  KSYProgressVI.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/15.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYProgressVI.h"

@implementation KSYProgressVI

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //缓冲进度
        _kProgressView=[[UIProgressView alloc]initWithFrame:self.bounds];
        _kProgressView.progress=0;
        _kProgressView.trackTintColor=DEEPCOLOR;
        _kProgressView.progressTintColor=[UIColor whiteColor];
        [self addSubview:_kProgressView];
        //进度条
        UIImage *dotImg = [UIImage imageNamed:@"Oval"];
        _kPlaySlider=[[UISlider alloc]initWithFrame:self.bounds];
        [_kPlaySlider setMinimumTrackTintColor:THEMECOLOR];
        [_kPlaySlider setMaximumTrackTintColor:[UIColor clearColor]];
        [_kPlaySlider setThumbImage:dotImg forState:UIControlStateNormal];
        [_kPlaySlider addTarget:self action:@selector(progressDidBegin:) forControlEvents:UIControlEventTouchDown];
        [_kPlaySlider addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
        [_kPlaySlider addTarget:self action:@selector(progressChangeEnd:) forControlEvents:(UIControlEventTouchUpOutside | UIControlEventTouchCancel|UIControlEventTouchUpInside)];
        _kPlaySlider.value = 0.0;
        _kPlaySlider.tag =kProgressSliderTag;
        [self addSubview:_kPlaySlider];
        _kProgressView.center=_kPlaySlider.center;
    }
    return self;
}
- (void)progressDidBegin:(UISlider *)slider{
    if (self.progDidBegin) {
        self.progDidBegin(slider);
    }
}
- (void)progressChanged:(UISlider *)slider{
    if (self.progChanged) {
        self.progChanged(slider);
    }
}
- (void)progressChangeEnd:(UISlider *)slider{
    if (self.progChangeEnd) {
        self.progChangeEnd(slider);
    }
}
- (void)updateProgress:(NSInteger)duration Position:(NSInteger)currentPlaybackTime playAbleDuration:(NSInteger)playableDuration{
    _kPlaySlider.value = currentPlaybackTime;
    _kPlaySlider.maximumValue = duration;
    _kProgressView.progress=(CGFloat)playableDuration/duration;
}
- (void)setLength{
    _kPlaySlider.frame=self.bounds;
    _kProgressView.frame=self.bounds;
    _kProgressView.center=_kPlaySlider.center;
}
@end
