//
//  KSYVideoPlayerView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYVideoPlayerView.h"
#import "KSYTopView.h"
#import "KSYBottomView.h"
#import "KSYBrightnessView.h"
#import "KSYVoiceView.h"
#import "KSYProgressView.h"
#import "KSYLockView.h"
#import "KSYToolView.h"
#import "KSYSetView.h"
#import "KSBarrageView.h"



@interface KSYVideoPlayerView ()
{
    KSYTopView *topView;
    KSYBottomView *bottomView;
    KSYBrightnessView *kBrightnessView;
    KSYVoiceView *kVoiceView;
    KSYProgressView *kProgressView;
    KSYLockView *kLockView;
    KSYToolView *kToolView;
    KSYSetView *kSetView;
    KSBarrageView *kDanmuView;
    BOOL isActive;
    BOOL isOpen;
}

@property (nonatomic, assign)  KSYGestureType gestureType;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat curPosition;
@property (nonatomic, assign) CGFloat curVoice;
@property (nonatomic, assign) CGFloat curBrightness;
@property (nonatomic, assign) CGRect kPreviousSelfFrame;
@property (nonatomic, assign) CGRect kPreviousPlayViewFrame;
@property (nonatomic, assign) BOOL isLocked;
@property (nonatomic, assign) BOOL fullScreenModeToggled;
@end




@implementation KSYVideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame UrlFromString:(NSString *)urlString playState:(KSYPopularLivePlayState)playState
{

    self=[super initWithFrame:frame urlString:urlString];//初始化父视图的(frame、url)
    if (self) {
        KSYThemeManager *themeManager = [KSYThemeManager sharedInstance];
        //    [themeManager changeTheme:@"blue"];
        //    [themeManager changeTheme:@"green"];
        //    [themeManager changeTheme:@"orange"];
        //    [themeManager changeTheme:@"pink"];
        [themeManager changeTheme:@"red"];
        _isLock=NO;
        self.playState=playState;
        [self addBottomView];
        [self addTopView];
        [self addBrightnessVIew];
        [self addVoiceView];
        [self addProgressView];
        [self addLockBtn];
        [self performSelector:@selector(hiddenAllControls) withObject:nil afterDelay:3.0];
    }
    return self;
}

- (void)addSetView
{
    if (!kSetView) {
        kSetView=[[KSYSetView alloc]initWithFrame:CGRectMake(self.width/2, 0, self.width/2, self.height)];
        kSetView.hidden=YES;
    }
    [self addSubview:kSetView];
}

- (KSYToolView *)kToolView
{
    WeakSelf(KSYVideoPlayerView);
    if (!kToolView)
    {
        kToolView=[[KSYToolView alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
        kToolView.hidden=YES;
        kToolView.showSetView=^(UIButton *btn){
            [weakSelf showSetView:(btn)];
        };
        kToolView.backEventBlock = ^(){
            [weakSelf unFullclick];

        };
    }
    return kToolView;
}

- (void)addLockBtn
{
    WeakSelf(KSYVideoPlayerView);
    kLockView=[[KSYLockView alloc]initWithFrame:CGRectMake(kCoverLockViewLeftMargin, (self.width - self.width / 6) / 2, self.width / 6, self.width / 6)];
    kLockView.kLockViewBtn=^(UIButton *btn){
        [weakSelf lockBtn:btn];
    };
    kLockView.hidden=YES;
    [self addSubview:kLockView];
}

- (void)addProgressView
{
    kProgressView=[[KSYProgressView alloc]initWithFrame:CGRectMake((self.width - kProgressViewWidth) / 2, (self.height - 50) / 4, kProgressViewWidth, 50)];
    kProgressView.hidden=YES;
    [self addSubview:kProgressView];
}

- (void)addTopView
{
    topView=[[KSYTopView alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
    if (_playState==KSYPopularLivePlay) {
        topView.hidden=YES;
    }
    [self addSubview:topView];
}

- (void)addBottomView
{
        
    WeakSelf(KSYVideoPlayerView);
    bottomView=[[KSYBottomView alloc]initWithFrame:CGRectMake(0, self.height-40, self.width, 40) PlayState:_playState];
    if (_playState==KSYPopularLivePlay) {
        bottomView.hidden=YES;
    }
    bottomView.progressDidBegin=^(UISlider *slider){
        [weakSelf progDidBegin:slider];
    };
    bottomView.progressChanged=^(UISlider *slider){
        [weakSelf progChanged:slider];
    };
    bottomView.progressChangeEnd=^(UISlider *slider){
        [weakSelf progChangeEnd:slider];
    };
    bottomView.BtnClick=^(UIButton *btn){
        [weakSelf BtnClick:btn];
    };
    bottomView.FullBtnClick=^(UIButton *btn){
        [weakSelf Fullclick:btn];
    };
    bottomView.changeBottomFrame=^(UITextField *textField){
        [weakSelf changeBottom:textField];
    };
    bottomView.rechangeBottom=^(){
        [weakSelf rechangeBottom];
    };
    bottomView.addDanmu=^(UIButton *btn){
        [weakSelf addDanmuView:(btn)];
    };
    [self addSubview: bottomView];
}

- (void)addDanmuView:(UIButton *)btn
{
    isOpen=!isOpen;
    if (isOpen==YES) {
        kDanmuView = [[KSBarrageView alloc] initWithFrame:CGRectMake(0, 0,self.width, self.height-60)];
        [self addSubview:kDanmuView];
        NSDictionary *dict1=[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"Logo2"],@"avatar",@"djsflkjoiwene",@"content", nil];
        NSDictionary *dict2=[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"Logo2"],@"avatar",@"1212341",@"content", nil];
        NSDictionary *dict3=[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"Logo2"],@"avatar",@"大家好啊啊啊啊啊啊啊啊啊啊啊啊啊",@"content", nil];
        NSDictionary *dict4=[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"Logo2"],@"avatar",@"1212341",@"content", nil];
        NSDictionary *dict5=[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"Logo2"],@"avatar",@"2342sdfsjhd束带结发哈斯",@"content", nil];
        kDanmuView.dataArray=[NSArray arrayWithObjects:dict1,dict2,dict3,dict4,dict5, nil];
        [kDanmuView setDanmuFont:10];
        [kDanmuView setDanmuAlpha:0.5];
        [kDanmuView start];
    }else{
        [kDanmuView stop];
        [kDanmuView removeFromSuperview];
    }
}

- (void)changeBottom:(UITextField *)textField
{
    bottomView.alpha=1.0;
    bottomView.frame=CGRectMake(0, self.height/2-40, self.width, 40);
    
}
- (void)rechangeBottom
{
    if (_playState==KSYPopularLivePlay) {
        [bottomView.commentText resignFirstResponder];
        bottomView.frame=CGRectMake(0, self.height-40, self.width, 40);
        bottomView.alpha=0.6;
    }
}

- (void)addBrightnessVIew
{
    WeakSelf(KSYVideoPlayerView);
    kBrightnessView=[[KSYBrightnessView alloc]initWithFrame:CGRectMake(kCoverBarLeftMargin, THESCREENWIDTH / 4, kCoverBarWidth, THESCREENWIDTH / 2)];
    kBrightnessView.brightDidBegin=^(UISlider *slider){
        [weakSelf brightnessDidBegin:slider];
    };
    kBrightnessView.brightChanged=^(UISlider *slider){
        [weakSelf brightnessChanged:slider];
    };
    kBrightnessView.brightChangeEnd=^(UISlider *slider){
        [weakSelf brightnessChangeEnd:slider];
    };
    kBrightnessView.hidden=YES;
    [self addSubview:kBrightnessView];
}

- (void)addVoiceView
{
    kVoiceView=[[KSYVoiceView alloc]initWithFrame:CGRectMake(THESCREENHEIGHT - kCoverBarWidth - kCoverBarRightMargin, THESCREENWIDTH / 4, kCoverBarWidth, THESCREENWIDTH / 2)];
    kVoiceView.hidden=YES;
    [self addSubview:kVoiceView];
}

- (void)brightnessDidBegin:(UISlider *)slider {
    UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot"];
    [slider setThumbImage:dotImg forState:UIControlStateNormal];
}
- (void)brightnessChanged:(UISlider *)slider {
    [[UIScreen mainScreen] setBrightness:slider.value];
}
- (void)brightnessChangeEnd:(UISlider *)slider {
    UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot_normal"];
    [slider setThumbImage:dotImg forState:UIControlStateNormal];
}


- (void)progDidBegin:(UISlider *)slider
{
    UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot"];
    [slider setThumbImage:dotImg forState:UIControlStateNormal];
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
    UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot_normal"];
    [slider setThumbImage:dotImg forState:UIControlStateNormal];
    if ([self.player isPlaying]==YES) {
        UIImage *playImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_pause_normal"];
        UIButton *btn = (UIButton *)[self viewWithTag:kBarPlayBtnTag];
        [btn setImage:playImg forState:UIControlStateNormal];
    }

    [self.player setCurrentPlaybackTime: slider.value];
}
- (void)BtnClick:(UIButton *)btn
{
    if (!self)
    {
        return;
    }
    if ([self.player isPlaying]==NO){
        [self play];
        UIImage *pauseImg_n = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_pause_normal"];
        [btn setImage:pauseImg_n forState:UIControlStateNormal];
    }
    else{
        [self pause];
        UIImage *playImg_n = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_play_normal"];
       [btn setImage:playImg_n forState:UIControlStateNormal];
    }

}
-(void)unFullclick
{
   
    if (self.clicUnkFullBtn) {
        self.clicUnkFullBtn();
    };
    [self minFullScreen];
}
-(void)Fullclick:(UIButton *)btn
{
    
    if (self.clickFullBtn) {
        self.clickFullBtn();
    };
    [self lunchFullScreen];
}

- (void)updateCurrentTime{
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
        UIImage *playImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_pause_normal"];
        [bottomView.kShortPlayBtn setImage:playImg forState:UIControlStateNormal];
    }
}
- (void)moviePlayerFinishState:(MPMoviePlaybackState)finishState
{
    [super moviePlayerFinishState:finishState];
    if (finishState == MPMoviePlaybackStateStopped) {
        UIImage *playImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_play_normal"];
        [bottomView.kShortPlayBtn setImage:playImg forState:UIControlStateNormal];
    }
}

- (void)lockBtn:(UIButton *)btn
{
    _isLock=!_isLock;
    if (_isLock==YES) {
        kBrightnessView.hidden=YES;
        kVoiceView.hidden=YES;
        bottomView.hidden=YES;
        kToolView.hidden=YES;
        bottomView.kFullBtn.hidden = NO;

        UIImage *lockCloseImg_n = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_lock_close_normal"];
        UIImage *lockCloseImg_h = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_lock_close_hl"];
        [btn setImage:lockCloseImg_n forState:UIControlStateNormal];
        [btn setImage:lockCloseImg_h forState:UIControlStateHighlighted];
        if (self.lockScreen) {
            self.lockScreen(_isLock);
        }
    }
    else{
        kBrightnessView.hidden=NO;
        kVoiceView.hidden=NO;
        bottomView.hidden=NO;
        kToolView.hidden=NO;
        bottomView.kFullBtn.hidden = YES;
        UIImage *lockOpenImg_n = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_lock_open_normal"];
        UIImage *lockOpenImg_h = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_lock_open_hl"];
        [btn setImage:lockOpenImg_n forState:UIControlStateNormal];
        [btn setImage:lockOpenImg_h forState:UIControlStateHighlighted];
        if (self.lockScreen) {
            self.lockScreen(_isLock);
        }

    }
}
- (void)showSetView:(UIButton *)btn
{
    [self addSetView];
    kSetView.hidden=NO;
    [self hiddenAllControls];
    
}

- (void)lunchFullScreen
{
    topView.hidden=YES;
    bottomView.hidden=YES;
    bottomView.frame=CGRectMake(0, self.height-40, self.width, 40);
    [bottomView setSubviews];
    kProgressView.frame=CGRectMake((self.width - kProgressViewWidth) / 2, (self.height - 50) / 2, kProgressViewWidth, 50);
    kLockView.frame=CGRectMake(kCoverLockViewLeftMargin, (self.height - self.height / 6) / 2, self.height / 6, self.height / 6);
    [self addSubview:self.kToolView];
    UIButton *fullBtn=(UIButton *)[self viewWithTag:kFullScreenBtnTag];
    UIImage *fullImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_exit_fullscreen_normal"];
    [fullBtn setImage:fullImg forState:UIControlStateNormal];
    self.indicator.center=self.center;
}

- (void)minFullScreen
{
    kBrightnessView.hidden=YES;
    kVoiceView.hidden=YES;
    kLockView.hidden=YES;
    bottomView.frame=CGRectMake(0, self.height-40, self.width, 40);
    [bottomView resetSubviews];
    bottomView.hidden=YES;
    kProgressView.frame=CGRectMake((self.width - kProgressViewWidth) / 2, (self.height - 50) / 4, kProgressViewWidth, 50);
    kToolView.hidden=YES;
    UIButton *unFullBtn=(UIButton *)[self viewWithTag:kFullScreenBtnTag];
    UIImage *unFullImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_fullscreen_normal"];
    [unFullBtn setImage:unFullImg forState:UIControlStateNormal];
    self.indicator.center=self.center;
}


#pragma mark - Touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UISlider *progressSlider = (UISlider *)[self viewWithTag:kProgressSliderTag];
    _startPoint = [[touches anyObject] locationInView:self];
    _curPosition = progressSlider.value;
    _curBrightness = [[UIScreen mainScreen] brightness];
    _curVoice = [MPMusicPlayerController applicationMusicPlayer].volume;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // **** 锁屏状态下，屏幕禁用
    if (_isLock == YES) {
        return;
    }
    CGPoint curPoint = [[touches anyObject] locationInView: self];
    CGFloat deltaX = curPoint.x -  self.startPoint.x;
    CGFloat deltaY = curPoint.y -  self.startPoint.y;
    CGFloat totalWidth =  self.width;
    CGFloat totalHeight =  self.height;

    NSInteger duration = (NSInteger)self.player.duration;
    
    if (fabs(deltaX) < fabs(deltaY)) {
        // **** 亮度
        if ((curPoint.x < totalWidth/2 ) && ( self.gestureType == kKSYUnknown ||  self.gestureType == kKSYBrightness)) {
            CGFloat deltaBright = deltaY / totalHeight * 1.0;
            [[UIScreen mainScreen] setBrightness: _curBrightness - deltaBright];
            UISlider *brightnessSlider = (UISlider *)[self viewWithTag:kBrightnessSliderTag];
            [brightnessSlider setValue: _curBrightness - deltaBright animated:NO];
            UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot"];
            [brightnessSlider setThumbImage:dotImg forState:UIControlStateNormal];
            UIView *brightnessView = [self viewWithTag:kBrightnessViewTag];
            brightnessView.alpha = 1.0;
            self.gestureType = kKSYBrightness;
        }
        // **** 声音
        else if ((curPoint.x > totalWidth/2 ) && ( self.gestureType == kKSYUnknown ||  self.gestureType == kKSYVoice)) {
            CGFloat deltaVoice = deltaY / totalHeight * 1.0;
            MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
            CGFloat voiceValue =  _curVoice - deltaVoice;
            if (voiceValue < 0) {
                voiceValue = 0;
            }
            else if (voiceValue > 1) {
                voiceValue = 1;
            }
            [musicPlayer setVolume:voiceValue];
            KSYMediaVoiceView *mediaVoiceView = (KSYMediaVoiceView *)[self viewWithTag:kMediaVoiceViewTag];
            [mediaVoiceView setIVoice:voiceValue];
            self.gestureType = kKSYVoice;
        }
        return ;
    }
    else if ( self.gestureType == kKSYUnknown ||  self.gestureType == kKSYProgress) {
        
        if (fabs(deltaX) > fabs(deltaY)) {
            if(_playState==KSYPopularLivePlay){
                return;
            }
            self.gestureType = kKSYProgress;
            
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
            UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot"];
            [progressSlider setThumbImage:dotImg forState:UIControlStateNormal];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.gestureType == kKSYUnknown) { // **** tap 动作
        if (isActive == YES) {
            [self hiddenAllControls];
            kSetView.hidden=YES;
            [self rechangeBottom];
            
        }
        else {
            [self showAllControls];
            kSetView.hidden=YES;
        }
    }
    else if (self.gestureType == kKSYProgress) {
        
        UISlider *progressSlider = (UISlider *)[self viewWithTag:kProgressSliderTag];
        
        [self.player setCurrentPlaybackTime: progressSlider.value];
        
        UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot_normal"];
        [progressSlider setThumbImage:dotImg forState:UIControlStateNormal];
    }
    else if (self.gestureType == kKSYBrightness) {
        UISlider *brightnessSlider = (UISlider *)[self viewWithTag:kBrightnessSliderTag];
        UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot_normal"];
        [brightnessSlider setThumbImage:dotImg forState:UIControlStateNormal];
        if (isActive == NO) {
            UIView *brightnessView = [self viewWithTag:kBrightnessViewTag];
            [UIView animateWithDuration:0.3 animations:^{
                brightnessView.alpha = 0.0f;
            }];
        }
    }
    self.gestureType = kKSYUnknown;
}


- (void) showAllControls
{
    [UIView animateWithDuration:0.3 animations:^{

            if (self.width<THESCREENHEIGHT) {//证明是竖直方向
                topView.hidden=NO;
                bottomView.hidden=NO;
                kBrightnessView.hidden=YES;
                kVoiceView.hidden=YES;
                kLockView.hidden=YES;
                kToolView.hidden=YES;
                bottomView.kFullBtn.hidden = NO;

                
            }else{
                if (_isLock==NO) {
                    bottomView.hidden=NO;
                    kBrightnessView.hidden=NO;
                    kVoiceView.hidden=NO;
                    kToolView.hidden=NO;
                    bottomView.kFullBtn.hidden = YES;
                }
                kLockView.hidden=NO;
            }
    } completion:^(BOOL finished) {
        isActive = YES;
    }];
}


- (void) hiddenAllControls
{
    [UIView animateWithDuration:0.3 animations:^{
        if (_isLock==NO) {
            topView.hidden=YES;
            bottomView.hidden=YES;
            kBrightnessView.hidden=YES;
            kVoiceView.hidden=YES;
            kToolView.hidden=YES;
            bottomView.kFullBtn.hidden = NO;

        }
        kLockView.hidden=YES;
    } completion:^(BOOL finished) {
        isActive = NO;
    }];
    
    
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
