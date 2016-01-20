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
#import "KSYEpisodeView.h"
#import "KSYBarrageBarView.h"
#import "KSYProgressVI.h"
@interface KSYVideoPlayerView ()<KSYProgressDelegate>
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
    KSYEpisodeView *episodeView;
    KSYBarrageBarView *kBarrageView;
    BOOL isActive;
    BOOL isOpen;
    CGFloat _HEIGHT;
    CGRect _keyboardRect;
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
        [self bringSubviewToFront:bottomView];
        [self addTopView];
        _HEIGHT=THESCREENWIDTH;
    }
    return self;
}
#pragma mark 添加视图
//添加TopView
- (void)addTopView
{
    topView=[[KSYTopView alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
    [self addSubview:topView];
}
//添加bottomView
- (void)addBottomView
{
    
    WeakSelf(KSYVideoPlayerView);
    bottomView=[[KSYBottomView alloc]initWithFrame:CGRectMake(0, self.height-40, self.width, 40) PlayState:_playState];
    bottomView.kprogress.delegate=self;
    bottomView.BtnClick=^(UIButton *btn){
        [weakSelf BtnClick:btn];
    };
    bottomView.FullBtnClick=^(UIButton *btn){
        [weakSelf Fullclick:btn];
    };
    bottomView.unFullBtnClick=^(UIButton *btn){
        [weakSelf unFullclick];
    };
    bottomView.changeBottomFrame=^(CGFloat keyBoaradHeight){
        [weakSelf changeBottom:keyBoaradHeight];
    };
    bottomView.rechangeBottom=^(){
        [weakSelf rechangeBottom];
    };
    bottomView.addDanmu=^(BOOL isOpen){
        [weakSelf addDanmuView:(isOpen)];
    };
    bottomView.addEpisodeView=^(UIButton *btn){
        [weakSelf addEpisode:(btn)];
    };
    [self addSubview: bottomView];
}
//添加亮度调节视图
- (void)addBrightnessVIew
{
    if (!kBrightnessView) {
        WeakSelf(KSYVideoPlayerView);
        kBrightnessView=[[KSYBrightnessView alloc]initWithFrame:CGRectMake(kCoverBarLeftMargin, self.height/ 4, kCoverBarWidth, self.height / 2)];
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
}
//添加声音调节视图
- (void)addVoiceView
{
    if (!kVoiceView) {
        kVoiceView=[[KSYVoiceView alloc]initWithFrame:CGRectMake(self.width - kCoverBarWidth - kCoverBarRightMargin, self.height / 4, kCoverBarWidth, self.height / 2)];
        kVoiceView.hidden=YES;
        [self addSubview:kVoiceView];
    }
}
//添加选集视图
- (void)addEpisodeView{
    if (!episodeView) {
        WeakSelf(KSYVideoPlayerView);
        episodeView=[[KSYEpisodeView alloc]initWithFrame:CGRectMake(self.width-200,kToolView.height,200,self.height-kToolView.height-bottomView.height)];
        episodeView.changeVidoe=^(NSString *str){
            [weakSelf nextVideo:(str)];
        };
        episodeView.hidden=YES;
        [self addSubview:episodeView];
    }
}
//添加设置视图
- (void)addSetView
{
    if (!kSetView) {
        kSetView=[[KSYSetView alloc]initWithFrame:CGRectMake(self.width/2, 0, self.width/2, self.height)];
        kSetView.hidden=YES;
        [self addSubview:kSetView];
    }
}
//添加工具视图
- (KSYToolView *)kToolView
{
    WeakSelf(KSYVideoPlayerView);
    if (!kToolView)
    {
        kToolView=[[KSYToolView alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
        kToolView.showSetView=^(UIButton *btn){
            [weakSelf showSetView:(btn)];
        };
        kToolView.backEventBlock = ^(){
            [weakSelf unFullclick];
            
        };
        kToolView.reportBtn=^(UIButton *btn){
            [weakSelf reportBtnClick:btn];
        };
        kToolView.subscribeBtn=^(UIButton *btn){
            [weakSelf subscribeBtnClick:btn];
        };
    }
    return kToolView;
}
//添加锁定视图
- (void)addLockBtn
{
    if (!kLockView) {
        WeakSelf(KSYVideoPlayerView);
        kLockView=[[KSYLockView alloc]initWithFrame:CGRectMake(kCoverLockViewLeftMargin, (self.width - self.width / 6) / 2, self.height / 6, self.height / 6)];
        kLockView.kLockViewBtn=^(UIButton *btn){
            [weakSelf lockBtn:btn];
        };
        kLockView.hidden=YES;
        [self addSubview:kLockView];
    }
}
//添加seekView
- (void)addProgressView
{
    if (!kProgressView) {
        kProgressView=[[KSYProgressView alloc]initWithFrame:CGRectMake((self.width - kProgressViewWidth) / 2, (self.height - 50) / 4, kProgressViewWidth, 50)];
        kProgressView.hidden=YES;
        [self addSubview:kProgressView];
    }
}
//添加弹幕
- (void)addDanmuView:(BOOL)isOpen
{
    if (isOpen) {
        kBarrageView = [[KSYBarrageBarView alloc]initWithFrame:CGRectMake(0, kToolView.bottom,self.width, self.height-120)];
        [self addSubview:kBarrageView];
        [kBarrageView start];
        [self bringSubviewToFront:kBrightnessView];
        [self bringSubviewToFront:kVoiceView];
        [self bringSubviewToFront:kLockView];
    }else{
        [kBarrageView stop];
        [kBarrageView removeFromSuperview];
    }
}
#pragma mark 视频操作
- (void)addEpisode:(UIButton *)btn{
    [self addEpisodeView];
    episodeView.hidden=NO;
}
- (void)nextVideo:(NSString *)videoStr{
    if (self.showNextVideo) {
        self.showNextVideo(videoStr);
    }
}
- (void)reportBtnClick:(UIButton *)btn{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"接口已提供" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (void)subscribeBtnClick:(UIButton *)btn{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"接口已提供" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (void)hiddenBrigthnessView{
    kBrightnessView.hidden=YES;
}
- (void)hiddenLockView{
    kLockView.hidden=YES;
}
- (void)hiddenVoiceView{
    kVoiceView.hidden=YES;
}
- (void)hiddenToolView{
    kToolView.hidden=YES;
}
- (void)changeBottom:(CGFloat)height{
    [self hiddenBrigthnessView];
    [self hiddenVoiceView];
    [self hiddenLockView];
    [self hiddenToolView];
    CGRect newFrame = CGRectMake(0, self.height-height-40, self.width, 40);
    [UIView animateWithDuration:0.25 animations:^{
        bottomView.frame = newFrame;
    }];
}
- (void)rechangeBottom{
    if (_playState==KSYPopularLivePlay) {
        [bottomView.commentText resignFirstResponder];
        bottomView.frame=CGRectMake(0, self.height-40, self.width, 40);
        bottomView.alpha=0.6;
    }
}
- (void)brightnessDidBegin:(UISlider *)slider {
}
- (void)brightnessChanged:(UISlider *)slider {
    [[UIScreen mainScreen] setBrightness:slider.value];
}
- (void)brightnessChangeEnd:(UISlider *)slider {
}
- (void)progDidBegin{
    if ([self.player isPlaying]==YES) {
        UIImage *playImg = [UIImage imageNamed:@"pause"];
        UIButton *btn = (UIButton *)[self viewWithTag:kBarPlayBtnTag];
        [btn setImage:playImg forState:UIControlStateNormal];
    }
}
- (void)progChanged{
    UISlider *slider=(UISlider *)[self viewWithTag:kProgressSliderTag];
    if (![self.player isPreparedToPlay]) {
        slider.value = 0.0f;
        return;
    }
    UILabel *startLabel = (UILabel *)[self viewWithTag:kProgressCurLabelTag];
    NSInteger position = slider.value;
    int iMin  = (int)(position / 60);
    int iSec  = (int)(position % 60);
    NSString *strCurTime = [NSString stringWithFormat:@"%02d:%02d", iMin, iSec];
    startLabel.text = strCurTime;
    
}
- (void)progChangeEnd{
    UISlider *slider=(UISlider *)[self viewWithTag:kProgressSliderTag];
    if (![self.player isPreparedToPlay]) {
        slider.value=0.0f;
        return;
    }
    if ([self.player isPlaying]==YES) {
        UIImage *playImg = [UIImage imageNamed:@"pause"];
        UIButton *btn = (UIButton *)[self viewWithTag:kBarPlayBtnTag];
        [btn setImage:playImg forState:UIControlStateNormal];
    }
    
    [self moviePlayerSeekTo: slider.value];
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
    [super updateCurrentTime];
    if ([self.player isPlaying]) {
        UIImage *playImg = [UIImage imageNamed:@"pause"];
        [bottomView.kShortPlayBtn setImage:playImg forState:UIControlStateNormal];
    }
    [bottomView updateCurrentDuration:self.duration Position:self.currentPlaybackTime playAbleDuration:self.player.playableDuration];
}
- (void)moviePlayerFinishState:(MPMoviePlaybackState)finishState
{
    [super moviePlayerFinishState:finishState];
    if (finishState == MPMoviePlaybackStateStopped) {
        UIImage *playImg = [UIImage imageNamed: @"play"];
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

        UIImage *lockCloseImg_n = [UIImage imageNamed:@"screenLock_on"];
        [btn setImage:lockCloseImg_n forState:UIControlStateNormal];
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
        UIImage *lockOpenImg_n = [UIImage imageNamed:@"screenLock_off"];
        [btn setImage:lockOpenImg_n forState:UIControlStateNormal];
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
    [self addBrightnessVIew];
    [self addVoiceView];
    [self addProgressView];
    [self addLockBtn];
    bottomView.frame=CGRectMake(0, self.height-40, self.width, 40);
    [bottomView setSubviews];
    kProgressView.frame=CGRectMake((self.width - kProgressViewWidth) / 2, (self.height - 50) / 2, kProgressViewWidth, 50);
    kLockView.frame=CGRectMake(kCoverLockViewLeftMargin, (self.height - self.height / 6) / 2, self.height / 6, self.height / 6);
    [self addSubview:self.kToolView];
    self.indicator.center=self.center;
    bottomView.hidden=YES;
    topView.hidden=YES;
    kToolView.hidden=YES;
}

- (void)minFullScreen
{
    kBrightnessView.hidden=YES;
    kVoiceView.hidden=YES;
    kLockView.hidden=YES;
    kSetView.hidden=YES;
    kToolView.hidden=YES;
    [kBarrageView removeFromSuperview];
    bottomView.frame=CGRectMake(0, self.height-40, self.width, 40);
    [bottomView resetSubviews];
    kProgressView.frame=CGRectMake((self.width - kProgressViewWidth) / 2, (self.height - 50) / 4, kProgressViewWidth, 50);
    topView.hidden=NO;
    bottomView.hidden=NO;
    self.indicator.center=self.center;
    if ((self.hiddenNavigation)) {
        self.hiddenNavigation(NO);
    }
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
    if (_isLock == YES||self.height<_HEIGHT) {
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
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.gestureType == kKSYUnknown) { // **** tap 动作
        if (isActive == YES) {
            [self hiddenAllControls];
            kSetView.hidden=YES;
            [self rechangeBottom];
            episodeView.hidden=YES;
        }
        else {
            [self showAllControls];
            kSetView.hidden=YES;
        }
    }
    else if (self.gestureType == kKSYProgress) {
        
        UISlider *progressSlider = (UISlider *)[self viewWithTag:kProgressSliderTag];
        [self moviePlayerSeekTo : progressSlider.value];
        
    }
    else if (self.gestureType == kKSYBrightness) {
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
                    if (_playState==KSYVideoOnlinePlay) {
                        bottomView.kFullBtn.hidden = YES;
                    }
                    //隐藏状态栏
                    [[UIApplication sharedApplication]setStatusBarHidden:NO];
                    if ((self.hiddenNavigation)) {
                        self.hiddenNavigation(YES);
                    }
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
            if (self.height==_HEIGHT){
                [[UIApplication sharedApplication]setStatusBarHidden:YES];
                if ((self.hiddenNavigation)) {
                    self.hiddenNavigation(YES);
                }
            }
            
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
