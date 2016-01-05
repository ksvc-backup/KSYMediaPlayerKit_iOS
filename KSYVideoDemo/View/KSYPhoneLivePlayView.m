//
//  KSYPhoneLivePlayView.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/7.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYPhoneLivePlayView.h"
#import "UIView+BFExtension.h"
#import "CommentModel.h"
#import "KSYCommentTableView.h"
#import "KSYSpectatorsTableView.h"
#import "KSYMessageToolBar.h"
#import "KSYAlertView.h"


@interface KSYPhoneLivePlayView ()<UIAlertViewDelegate>


@property (nonatomic, strong)KSYInteractiveView *interactiveView;
@property (nonatomic, strong)UIButton           *closeButton;
@property (nonatomic, strong)UIButton           *reportButton;
@property (nonatomic, strong)UILabel            *playStateLab;
@property (nonatomic, strong)UILabel            *curentTimeLab;
@property (nonatomic, strong)UIButton           *headButton;
@property (nonatomic, strong)UIImageView        *headImageView;
@property (nonatomic, strong)KSYAlertView        *alertView;
//播放类型
@property (nonatomic, assign) KSYPhoneLivePlayState playState;

@end


@implementation KSYPhoneLivePlayView

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString playState:(KSYPhoneLivePlayState)playState
{
    self = [super initWithFrame:frame urlString:urlString];
    if (self) {
        
        self.playState = playState;
        [self addSubview:self.closeButton];
        [self addSubview:self.reportButton];
        [self addSubview:self.playStateLab];
        [self addSubview:self.curentTimeLab];
        [self addSubview:self.headButton];
        [self addSubview:self.headImageView];
        [self addSubview:self.interactiveView];
        [self addSubview:self.alertView];
        
        [self bringSubviewToFront:self.closeButton];

    }
    return self;
}

- (KSYInteractiveView *)interactiveView
{
    WeakSelf(KSYPhoneLivePlayView);
    if (!_interactiveView) {
        _interactiveView = [[KSYInteractiveView alloc] initWithFrame:CGRectMake(0, 270, self.frame.size.width, self.frame.size.height - 270) playState:self.playState];
        _interactiveView.alertViewBlock = ^(id obj){
            weakSelf.alertView.contentModel = obj;
            [weakSelf setInfoViewFrame:YES];
            
        };
        _interactiveView.shareEventBlock = ^{
            if (weakSelf.shareBlock) {
                weakSelf.shareBlock();
            }
        };
        _interactiveView.playEventBlock = ^(BOOL isStop){

            if (isStop) {
                [weakSelf pause];
            }else {
                [weakSelf play];
            }
        };
        
        _interactiveView.seekBlock = ^(double value){
            [weakSelf moviePlayerSeekTo:value];
            if ([weakSelf isPlaying]) {
                [weakSelf play];

            }
        };
        
        
    }
    return _interactiveView;
}

- (void)setSpectatorsArray:(NSArray *)spectatorsArray
{
    _spectatorsArray = spectatorsArray;
    _interactiveView.spectatorsArray = self.spectatorsArray;

}
- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setFrame:CGRectMake(DeviceSizeBounds.size.width - 60, 10, 40, 30)];
        [_closeButton setTitle:@"X" forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_closeButton addTarget:self action:@selector(liveBroadcastWillClose) forControlEvents:UIControlEventTouchUpInside];

    }
    return _closeButton;
}

- (UIButton *)reportButton
{
    if (!_reportButton) {
        UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reportBtn setFrame:CGRectMake(DeviceSizeBounds.size.width - 115, 10, 40, 30)];
        [reportBtn setTitle:@"举报" forState:UIControlStateNormal];
        reportBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [reportBtn addTarget:self action:@selector(liveBroadcastWillBeReport) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reportBtn];

    }
    return _reportButton;
}

- (UILabel *)playStateLab
{
    if (!_playStateLab) {
        _playStateLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 75, 20)];
        if (self.playState == KSYPhoneLivePlayBack) {
            _playStateLab.text = @"直播回放";

        }else {
            _playStateLab.text = @"直播连线中...";

        }
        _playStateLab.textColor = [UIColor whiteColor];
        _playStateLab.font = [UIFont systemFontOfSize:12.0];
        _playStateLab.backgroundColor = [UIColor clearColor];

    }
    return _playStateLab;
}

- (UILabel *)curentTimeLab
{
    if (!_curentTimeLab) {
        _curentTimeLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _curentTimeLab.textColor = [UIColor whiteColor];
        _curentTimeLab.font = [UIFont systemFontOfSize:12.0];
        _curentTimeLab.backgroundColor = [UIColor clearColor];

    }
    return _curentTimeLab;
}

- (UIButton *)headButton
{
    if (!_headButton) {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headButton setFrame:CGRectMake(15, 15, 35, 35)];
        //    [_headBtn setTitle:@"头像" forState:UIControlStateNormal];
        _headButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_headButton addTarget:self action:@selector(headEvent:) forControlEvents:UIControlEventTouchUpInside];
        _headButton.hidden = YES;

    }
    return _headButton;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 35, 35)];
        _headImageView.backgroundColor = [UIColor cyanColor];
        _headImageView.layer.cornerRadius = 17.5;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.hidden = YES;

    }
    return _headImageView;
}

- (KSYAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[KSYAlertView alloc] initWithFrame:CGRectMake(70, 150 ,DeviceSizeBounds.size.width - 140, 430)];
        _alertView.backgroundColor = [UIColor blackColor];
        _alertView.alpha = 0.8;
        _alertView.hidden = YES;
    }
    return _alertView;
}

- (void)addNewCommentWith:(id)object
{
    
    [self.interactiveView addNewCommentWith:object];

}
#pragma mark- KSYMediaPlayerState

- (void)moviePlayerPlaybackState:(MPMoviePlaybackState)playbackState
{
    if (playbackState == MPMoviePlaybackStatePlaying) {
        _headButton.hidden = NO;
        _playStateLab.frame = CGRectMake(_headButton.right + 5, 15, 75, 20);
        if (self.playState == KSYPhoneLivePlay) {
            _playStateLab.text = @"直播中";

        }
        _headImageView.hidden = NO;
    }
}

- (void)moviePlayerFinishState:(MPMoviePlaybackState)finishState
{
    [super moviePlayerFinishState:finishState];
    if (finishState == MPMoviePlaybackStateStopped) {
        [self.interactiveView playerStop:YES];
    }
}
- (void)updateCurrentTime
{
    [super updateCurrentTime];
    _curentTimeLab.frame = CGRectMake(_headButton.right  +5, _playStateLab.bottom , 70, 20);
    NSInteger position = (NSInteger)self.currentPlaybackTime;
    int iMin  = (int)(position / 60);
    int iSec  = (int)(position % 60);
    _curentTimeLab.text = [NSString stringWithFormat:@"%02d:%02d", iMin, iSec];
    if (self.playState == KSYPhoneLivePlayBack) {
        [self.interactiveView updateProgressWithCurentTime:self.currentPlaybackTime duration:self.duration];
    }

}

//调用父类方法，播放按钮状态重置
- (void)replay
{
    [super replay];
    [self.interactiveView playerStop:NO];
}

#pragma mark- buttonEvent

- (void)liveBroadcastWillClose
{
    
    [self.interactiveView messageToolBarInputResignFirstResponder];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if (self.liveBroadcastCloseBlock) {
        self.liveBroadcastCloseBlock();//这是实现方法
    }
    
} 

- (void)liveBroadcastWillBeReport
{
    if (self.liveBroadcastReporteBlock) {
        self.liveBroadcastReporteBlock();
    }
}

- (void)headEvent:(UIButton *)button
{

}

- (void)onPraiseWithSpectatorsInteractiveType:(SpectatorsInteractiveType)type
{
    [self.interactiveView onPraiseWithSpectatorsInteractiveType:type];
}

#pragma aletView

- (void)setInfoViewFrame:(BOOL)isDown{
    if(isDown == NO)
    {
        [UIView animateWithDuration:0.1
                              delay:0.0
                            options:0
                         animations:^{
                             [self.alertView setFrame:CGRectMake(100, 0+60, 320, 90)];
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationCurveEaseIn
                                              animations:^{
//                                                  [self.alertView setFrame:CGRectMake(0, SCREENHEIGHT, 320, 90)];
                                              }
                                              completion:^(BOOL finished) {
                                              }];
                         }];
        
    }else
    {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:0
                         animations:^{
                             [self.alertView setFrame:CGRectMake(70, 250, 0, 0)];
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationCurveEaseInOut
                                              animations:^{
                                                  self.alertView.hidden = NO;
                                                  [self.alertView setFrame:CGRectMake(70, (self.frame.size.height - 430)/2.0 ,DeviceSizeBounds.size.width - 140, 430)];
                                              }
                                              completion:^(BOOL finished) {
                                              }];
                         }];
    }
}

@end
