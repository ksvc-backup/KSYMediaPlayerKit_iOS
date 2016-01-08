//
//  KSYShortView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/7.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYShortView.h"
#import "KSYTopView.h"
#import "KSYBottomView.h"

@interface KSYShortView (){
    KSYTopView *_topView;
    KSYBottomView *_bottomView;
    BOOL _showORhidden;
    UISlider *_slider;
}
@end

@implementation KSYShortView

- (instancetype)initWithFrame:(CGRect)frame urlShortString:(NSString *)urlString{
    self=[super initWithFrame:frame urlString:urlString];
    if (self) {
        //添加顶部视图
        [self addTopView];
        //添加底部slider
        [self addBottomPro];
        
    }
    return self;
}
//添加顶部视图
- (void)addTopView
{
    if (!_topView) {
        WeakSelf(KSYShortView);
        _topView=[[KSYTopView alloc]initWithFrame:CGRectMake(0, 0, self.width, 40)];
        _topView.forceBtn=^(UIButton *btn){
            [weakSelf forceBtnClick:(btn)];
        };
        _topView.backgroundColor=[UIColor blackColor];
        _topView.alpha=0.5;
        [self addSubview:_topView];
    }
}
- (void)forceBtnClick:(UIButton *)btn{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"已为你提供接口" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
//更新当前状态
-(void)updateCurrentTime{
    if (!_bottomView) {
        if (self.duration>60) {
            [self addSubview:self.bottomView];
            _bottomView.backgroundColor=[UIColor blackColor];
            _bottomView.alpha=0.5;
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
    
    _bottomView.kPlayabelSlider.value=self.player.playableDuration;
    _bottomView.kPlayabelSlider.maximumValue=self.player.duration;
    
    _slider.value=position;
    _slider.maximumValue=duration;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        WeakSelf(KSYShortView);
        _bottomView=[[KSYBottomView alloc]initWithFrame:CGRectMake(0, self.height-40, self.width, 40) PlayState:kSYShortVideoPlay];
        _bottomView.kTotalLabel.frame=CGRectMake(self.right-60, 5, 50, 30);
        _bottomView.kPlaySlider.width=self.width-_bottomView.kCurrentLabel.right-10-70;
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
    }
    return _bottomView;
}
- (void)progDidBegin:(UISlider *)slider
{
    if ([self.player isPlaying]==YES) {
        UIImage *playImg = [UIImage imageNamed:@"pause"];
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
        [btn setSelected:YES];
    }
    else{
        [self pause];
        UIImage *playImg_n = [UIImage imageNamed:@"play"];
        [btn setImage:playImg_n forState:UIControlStateNormal];
        [btn setSelected:NO];
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
#pragma mark - Touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _showORhidden=!_showORhidden;
    if (_showORhidden) {
        //oc中函数的调用是通过消息的传递
        _topView.hidden=YES;
        _bottomView.hidden=YES;
        _slider.hidden=NO;
    }else{
        _topView.hidden=NO;
        _bottomView.hidden=NO;
        _slider.hidden=YES;
    }
    
}

- (void)addBottomPro{
    _slider=[[UISlider alloc]initWithFrame:CGRectMake(0, self.height-2, self.width, 2)];
    [self addSubview:_slider];
    _slider.hidden=YES;
    //设置slider的相关属性
    [_slider setMinimumTrackTintColor:THEMECOLOR];
    _slider.thumbTintColor=[UIColor clearColor];
}
@end
