//
//  KSYInteractiveView.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/10.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  用户交互视图

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    SpectatorsInteractivePraise = 0,    //点赞
    SpectatorsInteractivePresent = 1,   //礼物
} SpectatorsInteractiveType;            //用户互动类型

typedef enum : NSUInteger {
    KSYPhoneLivePlay,       //手机直播播放
    KSYPhoneLivePlayBack,  //手机直播回放
} KSYPhoneLivePlayState;

@interface KSYInteractiveView : UIView

@property (nonatomic ,strong)   NSArray     *spectatorsArray;
@property (nonatomic, copy)void (^alertViewBlock)(id obj);
@property (nonatomic, copy)void (^shareEventBlock)();
@property (nonatomic, copy)void (^playEventBlock)(BOOL isStop);
@property (nonatomic, copy)void (^seekBlock)(double position);
- (instancetype)initWithFrame:(CGRect)frame playState:(KSYPhoneLivePlayState)state;
//添加一条新评论
- (void)addNewCommentWith:(id)object;
- (void)onPraiseWithSpectatorsInteractiveType:(SpectatorsInteractiveType)type;
- (void)messageToolBarInputResignFirstResponder;

- (void)updateProgressWithCurentTime:(NSTimeInterval)time duration:(NSTimeInterval)duration;
- (void)playerStop:(BOOL)isStop;
@end
