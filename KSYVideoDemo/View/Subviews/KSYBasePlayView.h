//
//  KSYBasePlayView.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/18.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KSYMediaPlayer/KSYMediaPlayer.h>
#import "Reachability.h"


@interface KSYBasePlayView : UIView

@property (nonatomic, strong)   KSYMoviePlayerController    *player;
/**
 *	@brief	视频播放当前时间
 */
@property (nonatomic, readonly) NSTimeInterval              currentPlaybackTime;
/**
 *	@brief	视频总时长
 */
@property (nonatomic, readonly) NSTimeInterval              duration;
/**
 *	@brief	加载等待视图
 */
@property (nonatomic, strong)   UIActivityIndicatorView     *indicator;
/**
 *	@brief	app退到后台是否释放播放器，默认是 NO
 */
@property (nonatomic, assign) BOOL                          isBackGroundReleasePlayer;

@property (nonatomic, assign) BOOL                          isPlaying;
/**
 *	@brief	初始化播放器视图
 *
 *	@param 	frame 	播放器视图frame
 *	@param 	urlString 	播放地址
 *
 *	@return	播放视图对象
 */
- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;
/**
 *	@brief	播放
 */
- (void)play;
/**
 *	@brief	暂停
 */
- (void)pause;
/**
 *	@brief	停止
 */
- (void)stop;
/**
 *	@brief	关闭播放器
 */
- (void)shutDown;
/**
 *	@brief	重新播放
 */
- (void)replay;
/**
 *	@brief	seek
 *
 *	@param 	position 	seek的时间点
 */
- (void)moviePlayerSeekTo:(NSTimeInterval)position;
/**
 *	@brief	更新当前时间
 */
- (void)updateCurrentTime;
/**
 *	@brief	当前播放器的状态
 *
 *	@param 	playbackState 	播放器状态
 */
- (void)moviePlayerPlaybackState:(MPMoviePlaybackState)playbackState;
/**
 *	@brief	当前网络加载情况
 *
 *	@param 	loadState 	播放状态
 */
- (void)moviePlayerLoadState:(MPMovieLoadState)loadState;

/**
 *	@brief	播放器完成状态
 *
 *	@param 	finishState 	完成状态
 */
- (void)moviePlayerFinishState:(MPMoviePlaybackState)finishState;



@end
