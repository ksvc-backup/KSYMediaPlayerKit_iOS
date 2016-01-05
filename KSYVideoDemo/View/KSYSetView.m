//
//  KSYSetView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/27.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYSetView.h"

@implementation KSYSetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}
#pragma mark 添加子视图
- (void)addSubviews
{
    self.backgroundColor=[UIColor blackColor];
    self.alpha=0.8;
    
    //添加标签
    UILabel *titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    titleLabel.tag=kTitleLabelTag;
    titleLabel.text=@"字幕设置";
    titleLabel.textColor=TEXTCOLOR2;
    titleLabel.font=[UIFont systemFontOfSize:kBigFont];
    [self addSubview:titleLabel];
    
    //添加字号大小标签
    UILabel *fontLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+kVertialSpacing-5, 80, 20)];
    fontLabel.tag=kFontLabelTag;
    [self addSubview:fontLabel];
    fontLabel.text=@"字号大小";
    fontLabel.textColor =TEXTCOLOR1;
    
    //添加分段控制器
    CGFloat fontSizeSCX=CGRectGetMaxX(fontLabel.frame)+kLandscapeSpacing;
    CGFloat fontSizeSCY=CGRectGetMidY(fontLabel.frame)-15;
    NSArray *array=[NSArray arrayWithObjects:@"小",@"中",@"大", nil];
    UISegmentedControl *fontSizeSC=[[UISegmentedControl alloc]initWithItems:array];
    fontSizeSC.frame=CGRectMake(fontSizeSCX, fontSizeSCY, CGRectGetWidth(self.frame)-fontSizeSCX-kLandscapeSpacing, 30);
    fontSizeSC.tag=kFontSizeSCTag;
    [self addSubview:fontSizeSC];
    fontSizeSC.selectedSegmentIndex=0;
    
    //添加字号大小标签
    UILabel *speedLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(fontLabel.frame)+kVertialSpacing, 80, 20)];
    speedLabel.tag=kSpeedLabelTag;
    [self addSubview:speedLabel];
    speedLabel.text=@"移动速度";
    speedLabel.textColor=TEXTCOLOR1;
    
    //添加分段控制器
    CGFloat speedSCX=CGRectGetMaxX(speedLabel.frame)+kLandscapeSpacing;
    CGFloat speedSCY=CGRectGetMidY(speedLabel.frame)-15;
    UISegmentedControl *speedSC=[[UISegmentedControl alloc]initWithItems:array];
    speedSC.tag=kSpeedSCTag;
    speedSC.frame=CGRectMake(speedSCX, speedSCY, CGRectGetWidth(self.frame)-fontSizeSCX-kLandscapeSpacing, 30);
    [self addSubview:speedSC];
    speedSC.selectedSegmentIndex=0;
    
    //添加字号大小标签
    UILabel *alphaLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(speedLabel.frame)+kVertialSpacing, 80, 20)];
    alphaLabel.tag=kAlphaLabelTag;
    [self addSubview:alphaLabel];
    alphaLabel.text=@"透明度";
    alphaLabel.textColor=TEXTCOLOR1;
    
    //添加分段控制器
    CGFloat alphaSCX=CGRectGetMaxX(alphaLabel.frame)+kLandscapeSpacing;
    CGFloat alphaSCY=CGRectGetMidY(alphaLabel.frame)-15;
    UISegmentedControl *alphaSC=[[UISegmentedControl alloc]initWithItems:array];
    alphaSC.tag=kAlphaSCTag;
    alphaSC.frame=CGRectMake(alphaSCX, alphaSCY, CGRectGetWidth(self.frame)-fontSizeSCX-kLandscapeSpacing, 30);
    [self addSubview:alphaSC];
    alphaSC.selectedSegmentIndex=0;
    
    
    //添加分割线
    UILabel *underLine=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(alphaLabel.frame)+kVertialSpacing, CGRectGetWidth(self.frame)-20, 1)];
    underLine.tag=kUnderLineTag;
    [self addSubview:underLine];
    underLine.backgroundColor=TEXTCOLOR1;
    
    //添加播放设置标签
    UILabel *playSetLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(underLine.frame)+kVertialSpacing-2, 80, 20)];
    [self addSubview:playSetLabel];
    playSetLabel.tag=kPlaySetLabelTag;
    playSetLabel.text=@"播放设置";
    playSetLabel.font=[UIFont systemFontOfSize:kBigFont];
    playSetLabel.textColor=TEXTCOLOR2;
    
    //添加音量设置标签
    UILabel *voiceSetLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(playSetLabel.frame)+kVertialSpacing-10, 80, 20)];
    voiceSetLabel.tag=kVoiceSetLabelTag;
    [self addSubview:voiceSetLabel];
    voiceSetLabel.text=@"音量设置";
    voiceSetLabel.textColor=TEXTCOLOR1;
    
    //静音
    CGFloat lowVoiceImgWidth = kCoverBarWidth - 8;
    UIImage *lowVoiceImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"voice_min"];
    CGRect lowVoiceImgViewRect = CGRectMake(10, CGRectGetMaxY(voiceSetLabel.frame)+kVertialSpacing-10, lowVoiceImgWidth, lowVoiceImgWidth);
    UIImageView *lowVoiceImageView = [[UIImageView alloc]initWithImage:lowVoiceImg];
    lowVoiceImageView.frame=lowVoiceImgViewRect;
    lowVoiceImageView.contentMode=UIViewContentModeScaleAspectFit;
    //        lowVoiceLabel.tag
    [self addSubview:lowVoiceImageView];
    
    
    //高音
    CGFloat highVoiceImgWidth = kCoverBarWidth - 8;
    UIImage *highVoiceImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"voice_max"];
    CGRect highVoiceImgViewRect = CGRectMake(CGRectGetWidth(self.frame)-10-highVoiceImgWidth, CGRectGetMinY(lowVoiceImageView.frame), highVoiceImgWidth, highVoiceImgWidth);
    UIImageView *highVoiceImageView = [[UIImageView alloc]initWithImage:highVoiceImg];
    highVoiceImageView.contentMode=UIViewContentModeScaleAspectFit;
    highVoiceImageView.frame=highVoiceImgViewRect;
    highVoiceImageView.contentMode=UIViewContentModeScaleAspectFit;
    //        lowVoiceLabel.tag
    [self addSubview:highVoiceImageView];
    
    //添加音量进度条
    //        CGFloat brightnessX=CGRectGetMaxX(lowBrightnessImgView.frame)+10;
    //        CGFloat brightnessY=CGRectGetMidY(lowBrightnessImgView.frame)-5;
    //        CGFloat brightnessHeight=10;
    //        CGFloat brightnessWidth=CGRectGetWidth(setView.frame)-brightnessX-(CGRectGetWidth(setView.frame)-CGRectGetMinX(highBrightnessImgView.frame));
    //        CGRect brightnessRect1=CGRectMake(brightnessX, brightnessY, brightnessWidth, brightnessHeight);
    //        UISlider *brightnessSilder1=[[UISlider alloc]initWithFrame:brightnessRect1];
    //        [setView addSubview:brightnessSilder1];
    CGFloat voiceSliderX = CGRectGetMaxX(lowVoiceImageView.frame)+10;
    CGFloat voiceSliderY =CGRectGetMidY(lowVoiceImageView.frame)-5;
    CGFloat voiceSliderWidth =CGRectGetWidth(self.frame)-voiceSliderX-(CGRectGetWidth(self.frame)-CGRectGetMinX(highVoiceImageView.frame));
    CGFloat voiceSliderHeight = 10;
    
    
    UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot_normal"];
    UIImage *minImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"slider_color"];
    CGRect voiceSliderRect = CGRectMake(voiceSliderX, voiceSliderY, voiceSliderWidth, voiceSliderHeight);
    UISlider *voiceSlider = [[UISlider alloc] initWithFrame:voiceSliderRect];
    [self addSubview:voiceSlider];
    [voiceSlider setMinimumTrackImage:minImg forState:UIControlStateNormal];
    voiceSlider.maximumTrackTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    [voiceSlider setThumbImage:dotImg forState:UIControlStateNormal];
    voiceSlider.value = [MPMusicPlayerController applicationMusicPlayer].volume;
    voiceSlider.tag = kVoiceSliderTag;
    //        [voiceSlider addTarget:_controller action:@selector(voiceChanged:) forControlEvents:UIControlEventValueChanged];
    //        [voiceSlider addTarget:_controller action:@selector(voiceDidBegin:) forControlEvents:UIControlEventTouchDown];
    //        [voiceSlider addTarget:_controller action:@selector(voiceChangeEnd:) forControlEvents:(UIControlEventTouchUpOutside | UIControlEventTouchCancel|UIControlEventTouchUpInside)];
    
    
    
    //添加亮度设置
    UILabel *brightnessLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lowVoiceImageView.frame)+kLandscapeSpacing-10, 80, 20)];
    [self addSubview:brightnessLabel];
    brightnessLabel.text=@"亮度设置";
    brightnessLabel.textColor=TEXTCOLOR1;
    brightnessLabel.font=[UIFont systemFontOfSize:kSmallFont];
    
    
    //低亮模式
    CGFloat lowbrightnessWidth = kCoverBarWidth - 10;
    CGRect lowBrightnessImgViewRect = CGRectMake(10, CGRectGetMaxY(brightnessLabel.frame)+kVertialSpacing-10, lowbrightnessWidth, lowbrightnessWidth);
    UIImageView *lowBrightnessImgView = [[UIImageView alloc] initWithFrame:lowBrightnessImgViewRect];
    lowBrightnessImgView.contentMode=UIViewContentModeScaleAspectFit;
    UIImage *brightnessImage = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"brightness"];
    lowBrightnessImgView.image=brightnessImage;
    [self addSubview:lowBrightnessImgView];
    
    
    //高亮模式
    CGRect highbrightnessImgViewRect = CGRectMake(CGRectGetWidth(self.frame)-6-kCoverBarWidth , CGRectGetMidY(lowBrightnessImgView.frame)-((kCoverBarWidth - 6)/2), kCoverBarWidth - 6, kCoverBarWidth - 6);
    UIImageView *highBrightnessImgView = [[UIImageView alloc] initWithFrame:highbrightnessImgViewRect];
    highBrightnessImgView.contentMode=UIViewContentModeScaleAspectFit;
    highBrightnessImgView.image = brightnessImage;
    [self addSubview:highBrightnessImgView];
    
    //添加亮度条
    CGFloat brightnessX=CGRectGetMaxX(lowBrightnessImgView.frame)+10;
    CGFloat brightnessY=CGRectGetMidY(lowBrightnessImgView.frame)-5;
    CGFloat brightnessHeight=10;
    CGFloat brightnessWidth=CGRectGetWidth(self.frame)-brightnessX-(CGRectGetWidth(self.frame)-CGRectGetMinX(highBrightnessImgView.frame));
    CGRect brightnessRect1=CGRectMake(brightnessX, brightnessY, brightnessWidth, brightnessHeight);
    UISlider *brightnessSilder1=[[UISlider alloc]initWithFrame:brightnessRect1];
    [self addSubview:brightnessSilder1];
    
    [brightnessSilder1 setMinimumTrackImage:minImg forState:UIControlStateNormal];
    brightnessSilder1.maximumTrackTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    [brightnessSilder1 setThumbImage:dotImg forState:UIControlStateNormal];
    brightnessSilder1.value = [UIScreen mainScreen].brightness;
    brightnessSilder1.tag = kVoiceSliderTag;
    [brightnessSilder1 addTarget:self action:@selector(brightnessChanged:) forControlEvents:UIControlEventValueChanged];
    [brightnessSilder1 addTarget:self action:@selector(brightnessDidBegin:) forControlEvents:UIControlEventTouchDown];
    [brightnessSilder1 addTarget:self action:@selector(brightnessChangeEnd:) forControlEvents:(UIControlEventTouchUpOutside | UIControlEventTouchCancel|UIControlEventTouchUpInside)];
    
    
}
-(void)brightnessChanged:(UISlider *)slider
{
    
}
-(void) brightnessDidBegin:(UISlider *)slider
{
    
}
- (void)brightnessChangeEnd:(UISlider *)slider
{
    
}
@end
