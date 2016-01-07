//
//  KSYShortView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/6.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYShortView.h"
#import "KSYTopView.h"
#import "KSYBottomView.h"
@interface KSYShortView (){
    KSYTopView *_topView;
    KSYBottomView *_bottomView;
    CGPoint _startPoint;
    CGFloat _curPosition;
}
@end



@implementation KSYShortView

- (instancetype)initWithShortFrame:(CGRect)frame UrlFromShortString:(NSString *)urlString{
    self=[super initWithFrame:frame urlString:urlString];
    if (self) {
        KSYThemeManager *themeManager = [KSYThemeManager sharedInstance];
        //    [themeManager changeTheme:@"blue"];
        //    [themeManager changeTheme:@"green"];
        //    [themeManager changeTheme:@"orange"];
        //    [themeManager changeTheme:@"pink"];
        [themeManager changeTheme:@"red"];
        //添加topView
        [self addTopView];
    }
    return self;
}
- (void)updateCurrentTime{
    
    //添加bottomView
    if (!_bottomView) {
        if ((int)self.duration>60) {
            [self addBottomView];
            _bottomView.kFullBtn.hidden=YES;
        }
    }
    
    UILabel *kCurrentLabe = (UILabel *)[self viewWithTag:kProgressCurLabelTag];
    UILabel *kTotalLabel = (UILabel *)[self viewWithTag:kProgressMaxLabelTag];
    UISlider *kPlaySlider = (UISlider *)[self viewWithTag:kProgressSliderTag];
    NSInteger duration = self.duration;
    NSInteger position = self.currentPlaybackTime;
    
    int iMin  = (int)(position / 60);
    int iSec  = (int)(position % 60);
    
    kCurrentLabe.text = [NSString stringWithFormat:@"%02d:%02d", iMin, iSec];
    
    int iDuraMin  = (int)(duration / 60);
    int iDuraSec  = (int)(duration % 3600 % 60);
    kTotalLabel.text = [NSString stringWithFormat:@"%02d:%02d", iDuraMin, iDuraSec];
    kPlaySlider.value = position;
    kPlaySlider.maximumValue = duration;
    if ([self.player isPlaying]) {
        UIImage *playImg = [UIImage imageNamed:@"pause"];
        [_bottomView.kShortPlayBtn setImage:playImg forState:UIControlStateNormal];
    }
}
- (void)moviePlayerFinishState:(MPMoviePlaybackState)finishState
{
    [super moviePlayerFinishState:finishState];
    if (finishState == MPMoviePlaybackStateStopped) {
        UIImage *playImg = [UIImage imageNamed:@"play"];
        [_bottomView.kShortPlayBtn setImage:playImg forState:UIControlStateNormal];
    }
}
- (void)addTopView
{
    _topView=[[KSYTopView alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
    [self addSubview:_topView];
}

- (void)addBottomView
{
    WeakSelf(KSYShortView);
    _bottomView=[[KSYBottomView alloc]initWithFrame:CGRectMake(0, self.height-40, self.width, 40) PlayState:kSYShortVideoPlay];
    _bottomView.progressDidBegin=^(UISlider *slider){
        [weakSelf progDidBegin:slider];
    };
    _bottomView.progressChanged=^(UISlider *slider){
        [weakSelf progChanged:slider];
    };
    _bottomView.progressChangeEnd=^(UISlider *slider){
        [weakSelf progChangeEnd:slider];
    };
    _bottomView.BtnClick=^(UIButton *btn){
        [weakSelf BtnClick:btn];
    };
    [self addSubview: _bottomView];
}
- (void)BtnClick:(UIButton *)btn
{
    if (!self)
    {
        return;
    }
    if ([self.player isPlaying]==NO){
        [self play];
        UIImage *pauseImg_n = [UIImage imageNamed:@"pause"];
        [btn setImage:pauseImg_n forState:UIControlStateNormal];
    }
    else{
        [self pause];
        UIImage *playImg_n = [UIImage imageNamed:@"play"];
        [btn setImage:playImg_n forState:UIControlStateNormal];
    }
    
}

- (void)progDidBegin:(UISlider *)slider
{
    if ([self.player isPlaying]==YES) {
        UIImage *playImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_play_normal"];
        UIButton *btn = (UIButton *)[self viewWithTag:kBarPlayBtnTag];
        [btn setImage:playImg forState:UIControlStateNormal];
    }
    
}
-(void)progChanged:(UISlider *)slider
{
    if (![self.player isPreparedToPlay]) {
        slider.value = 0.0f;
        return;
    }
    UISlider *progressSlider = (UISlider *)[self viewWithTag:kProgressSliderTag];
    UILabel *startLabel = (UILabel *)[self viewWithTag:kProgressCurLabelTag];
    NSInteger position = progressSlider.value;
    int iMin  = (int)(position / 60);
    int iSec  = (int)(position % 60);
    NSString *strCurTime = [NSString stringWithFormat:@"%02d:%02d", iMin, iSec];
    startLabel.text = strCurTime;
    
}
- (void)progChangeEnd:(UISlider *)slider
{
    if (![self.player isPreparedToPlay]) {
        slider.value=0.0f;
        return;
    }
    if ([self.player isPlaying]==YES) {
        UIImage *playImg = [UIImage imageNamed:@"pause"];
        UIButton *btn = (UIButton *)[self viewWithTag:kBarPlayBtnTag];
        [btn setImage:playImg forState:UIControlStateNormal];
    }
    
    [self.player setCurrentPlaybackTime: slider.value];
}
#pragma mark - Touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UISlider *progressSlider = (UISlider *)[self viewWithTag:kProgressSliderTag];
    _startPoint = [[touches anyObject] locationInView:self];
    _curPosition = progressSlider.value;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 如果没有底部视图手势无用
    if (!_bottomView) {
        return;
    }
    CGPoint curPoint = [[touches anyObject] locationInView: self];
    CGFloat deltaX = curPoint.x -  _startPoint.x;
    CGFloat totalWidth =  self.width;
    
    NSInteger duration = (NSInteger)self.player.duration;
    
    [self performSelector:@selector(showORhideProgressView:) withObject:@NO];
    CGFloat deltaProgress = deltaX / totalWidth * duration;
    UISlider *progressSlider = (UISlider *)[self viewWithTag:kProgressSliderTag];
    UIView *progressView = [self viewWithTag:kProgressViewTag];
    UILabel *progressViewCurLabel = (UILabel *)[self viewWithTag:kCurProgressLabelTag];
    UIImageView *wardImageView = (UIImageView *)[self viewWithTag:kWardMarkImgViewTag];
    UILabel *startLabel = (UILabel *)[self viewWithTag:kProgressCurLabelTag];
    NSInteger position = _curPosition + deltaProgress;
    if (position < 0) {
        position = 0;
    }
    else if (position > duration) {
        position = duration;
    }
    progressSlider.value = position;
    
    int iMin1  = ((int)labs(position) / 60);
    int iSec1  = ((int)labs(position) % 60);
    int iMin2  = ((int)fabs(deltaProgress) / 60);
    int iSec2  = ((int)fabs(deltaProgress) % 60);
    NSString *strCurTime1 = [NSString stringWithFormat:@"%02d:%02d", iMin1, iSec1];
    NSString *strCurTime2 = [NSString stringWithFormat:@"%02d:%02d", iMin2, iSec2];
    startLabel.text = strCurTime1;
    if (deltaX > 0) {
        strCurTime2 = [@"+" stringByAppendingString:strCurTime2];
        UIImage *forwardImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_forward_normal"];
        wardImageView.frame = CGRectMake(progressView.frame.size.width - 30, 15, 20, 20);
        wardImageView.image = forwardImg;
    }
    else {
        strCurTime2 = [@"-" stringByAppendingString:strCurTime2];
        UIImage *backwardImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_backward_normal"];
        wardImageView.frame = CGRectMake(10, 15, 20, 20);
        wardImageView.image = backwardImg;
    }
    progressViewCurLabel.text = strCurTime2;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UISlider *progressSlider = (UISlider *)[self viewWithTag:kProgressSliderTag];

    [self  moviePlayerSeekTo: progressSlider.value];
}

- (void)showORhideProgressView:(NSNumber *)bShowORHide {
    UIView *progressView = [self viewWithTag:kProgressViewTag];
    progressView.hidden = bShowORHide.boolValue;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideProgressView) object:nil];
    if (!bShowORHide.boolValue) {
        [self performSelector:@selector(hideProgressView) withObject:nil afterDelay:1];
    }
}

- (void)hideProgressView {
    UIView *progressView = [self viewWithTag:kProgressViewTag];
    progressView.hidden = YES;
}



@end
