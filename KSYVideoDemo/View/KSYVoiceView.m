//
//  KSYVoiceView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/25.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYVoiceView.h"
#import "KSYMediaVoiceView.h"


@interface KSYVoiceView ()

@property (nonatomic, strong) KSYMediaVoiceView *mediaVoiceView;

@end


@implementation KSYVoiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self addsubviews];
    }
    return self;
}
#pragma mark 添加子视图
- (void)addsubviews
{
    // **** voice view
    // 声音视图
//    CGRect voiceRect = CGRectMake(size.width - kCoverBarWidth - kCoverBarRightMargin, size.height / 4, kCoverBarWidth, size.height / 2);
//    UIView *voiceView = [[UIView alloc] initWithFrame:voiceRect];
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
//    self.tag = kVoiceViewTag;
    
    //声音背景视图
    UIView *voiceBgView = [[UIView alloc] initWithFrame:self.bounds];
    voiceBgView.backgroundColor = [UIColor blackColor];
    voiceBgView.alpha = 0.6f;
    [self addSubview:voiceBgView];
    
    //静音按钮
    CGFloat voiceImgWidth = kCoverBarWidth - 8;
    UIImage *voiceMinImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"voice_min"];
    CGRect voiceImgViewRect1 = CGRectMake(4, self.height - voiceImgWidth - 4, voiceImgWidth, voiceImgWidth);
    UIButton *voiceMinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceMinBtn setImage:voiceMinImg forState:UIControlStateNormal];
    voiceMinBtn.frame = voiceImgViewRect1;
    [voiceMinBtn addTarget:self action:@selector(clickSoundOff:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:voiceMinBtn];
    
    //声音条
    CGRect mediaVoiceRect = CGRectMake(4, 25, kCoverBarWidth - 10, self.height - 25 * 2);
    _mediaVoiceView = [[KSYMediaVoiceView alloc] initWithFrame:mediaVoiceRect];
    _mediaVoiceView.tag = kMediaVoiceViewTag;
    [_mediaVoiceView setFillColor:[[KSYThemeManager sharedInstance] themeColor]];
    [_mediaVoiceView setIVoice:[MPMusicPlayerController applicationMusicPlayer].volume];
    [self addSubview:_mediaVoiceView];
    
    //最大声音视图
    CGRect voiceImgViewRect2 = voiceImgViewRect1;//CGRectMake(2, 0, 20, 20);
    voiceImgViewRect2.origin.y = 4;
    UIImageView *voiceImgView2 = [[UIImageView alloc] initWithFrame:voiceImgViewRect2];
    UIImage *voiceMaxImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"voice_max"];
    voiceImgView2.image = voiceMaxImg;
    [self addSubview:voiceImgView2];
}
#pragma mark 静音按钮
- (void)clickSoundOff:(UITapGestureRecognizer *)tapGesture {
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    [musicPlayer setVolume:0];
    [_mediaVoiceView setIVoice:0];
}
@end
