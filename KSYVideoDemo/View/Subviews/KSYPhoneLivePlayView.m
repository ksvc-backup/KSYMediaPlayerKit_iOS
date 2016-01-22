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

@property (nonatomic, strong)UIView             *topBackView;
@property (nonatomic, strong)UIView                 *bottomBackView;

@property (nonatomic, strong)KSYInteractiveView *interactiveView;
@property (nonatomic, strong)UIButton           *closeButton;
@property (nonatomic, strong)UIButton           *reportButton;
@property (nonatomic, strong)UIImageView        *playStateImageV;
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
//        self.backgroundColor = [UIColor cyanColor];
        self.playState = playState;
        [self addSubview:self.topBackView];
        [self addSubview:self.headButton];
        [self addSubview:self.playStateImageV];
        [self addSubview:self.curentTimeLab];
        [self addSubview:self.closeButton];
        [self addSubview:self.reportButton];
        [self addSubview:self.bottomBackView];

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

- (UIView *)topBackView
{
    if (!_topBackView) {
        _topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        _topBackView.alpha = 0.6;
        [_topBackView.layer addSublayer:[self shadowAsInverse:YES]];

    }
    return _topBackView;
}

- (UIView *)bottomBackView
{
    if (!_bottomBackView) {
        _bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 100, self.frame.size.width, 100)];
        _bottomBackView.alpha = 0.6;
        _bottomBackView.userInteractionEnabled = YES;
        [_bottomBackView.layer addSublayer:[self shadowAsInverse:NO]];
        
    }
    return _bottomBackView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setFrame:CGRectMake(DeviceSizeBounds.size.width - 45, _headButton.top + 7, 16, 16)];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_closeButton addTarget:self action:@selector(liveBroadcastWillClose) forControlEvents:UIControlEventTouchUpInside];

    }
    return _closeButton;
}

- (UIButton *)reportButton
{
    if (!_reportButton) {
        UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reportBtn setFrame:CGRectMake(DeviceSizeBounds.size.width - 115, _headButton.top, 30, 30)];
        [reportBtn setBackgroundImage:[UIImage imageNamed:@"report"] forState:UIControlStateNormal];
        reportBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [reportBtn addTarget:self action:@selector(liveBroadcastWillBeReport) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reportBtn];

    }
    return _reportButton;
}

- (UIImageView *)playStateImageV
{
    if (!_playStateImageV) {
        
        _playStateImageV = [[UIImageView alloc] initWithFrame:CGRectMake(_headButton.right + 7, 23, 40, 17)];
        if (self.playState == KSYPhoneLivePlayBack) {
            
            _playStateImageV.image = [UIImage imageNamed:@"replay"];
            
        }else {
            _playStateImageV.image = [UIImage imageNamed:@"live"];
            
        }


    }
    return _playStateImageV;
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
        _curentTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(_headButton.right + 7, _playStateImageV.bottom , 70, 20)];
        _curentTimeLab.textColor = [UIColor whiteColor];
        _curentTimeLab.font = [UIFont systemFontOfSize:12.0];
        _curentTimeLab.backgroundColor = [UIColor clearColor];
        _curentTimeLab.text = @"连线中...";

    }
    return _curentTimeLab;
}

- (UIButton *)headButton
{
    if (!_headButton) {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headButton setFrame:CGRectMake(15, 20, 36, 36)];
        [_headButton setBackgroundImage:[UIImage imageNamed:@"live_head"] forState:UIControlStateNormal];
        [_headButton addTarget:self action:@selector(headEvent:) forControlEvents:UIControlEventTouchUpInside];

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
    NSInteger position = (NSInteger)self.currentPlaybackTime;
    int iMin  = (int)(position / 60);
    int iSec  = (int)(position % 60);
    _curentTimeLab.text = [NSString stringWithFormat:@"%02d:%02d", iMin, iSec];
    if (self.playState == KSYPhoneLivePlayBack) {
        [self.interactiveView updateProgressWithCurentTime:self.currentPlaybackTime duration:self.duration  playabeDuration:self.player.playableDuration];
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
    self.alertView.contentModel = self.userModel;
    [self setInfoViewFrame:YES];

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

- (CAGradientLayer *)shadowAsInverse:(BOOL)isTop;
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, self.width,100);
    newShadow.frame = newShadowFrame;
    if (isTop) {
        newShadow.colors = [NSArray arrayWithObjects:
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.6] CGColor] ,
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor] ,
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.4] CGColor],
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3] CGColor],
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor],
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1] CGColor],
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0] CGColor],
                            nil];

    }else {
        newShadow.colors = [NSArray arrayWithObjects:
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0] CGColor] ,
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1] CGColor] ,
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor],
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3] CGColor],
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.4] CGColor],
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor],
                            (id)[[[UIColor grayColor] colorWithAlphaComponent:0.6] CGColor],
                            nil];

    }
    return newShadow;
}

@end
