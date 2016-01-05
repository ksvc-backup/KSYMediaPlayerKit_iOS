//
//  KSYHead.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/21.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#ifndef KSYHead_h
#define KSYHead_h

#import "UIView+BFExtension.h"
#import <KSYMediaPlayer/KSYMediaPlayer.h>
#import "KSYBasePlayView.h"
#import "KSYThemeManager.h"
#import "KSYMediaVoiceView.h"
#import "KSYComTvCell.h"
#import "KSYCommentModel.h"
#import "KSYDetalTVCell.h"
#import "KSYDetailModel.h"
#import "KSYIntTVCell.h"
#import "KSYIntroduceModel.h"



typedef enum : NSUInteger {
    KSYPopularLivePlay,
    KSYPopularPlayBack,
    kSYShortVideoPlay,
    KSYVideoOnlinePlay,
} KSYPopularLivePlayState;

enum KSYVideoQuality {
    kKSYVideoNormal = 0, // **** default
    kKSYVideoHight,
    kKSYVideoSuper,
};

enum KSYVideoScale {
    kKSYVideo16W9H = 0, // **** default
    kKSYVideo4W3H,
};

enum KSYGestureType {
    kKSYUnknown = 0,
    kKSYBrightness,
    kKSYVoice,
    kKSYProgress,
};


typedef enum KSYVideoQuality KSYVideoQuality;
typedef enum KSYVideoScale KSYVideoScale;
typedef enum KSYGestureType KSYGestureType;

#define KSYSYS_OS_IOS8  ([[[[UIDevice currentDevice]systemVersion]substringToIndex:1] doubleValue]>=8)
#define W16H9Scale ((float)16 / 9)
#define DeviceSizeBounds [UIScreen mainScreen].bounds

//  弱引用宏
#define WeakSelf(VC) __weak VC *weakSelf = self

//屏幕的宽高
#define THESCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define THESCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define TEXTCOLOR1 ([UIColor colorWithRed:207.0/255.0 green:206.0/255.0 blue:203.0/255.0 alpha:1.0])
#define TEXTCOLOR2 ([UIColor colorWithRed:237.0/255.0 green:236.0/255.0 blue:234.0/255.0 alpha:1.0])
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define kTopBarHeight 40
#define kBottomBarHeight 58
#define kCoverBarHeight 140
#define kCoverBarLeftMargin 20
#define kCoverBarRightMargin 20
#define kCoverBarTopMargin 48
#define kCoverBarBottomMargin 42
#define kCoverLockViewLeftMargin 68
#define kCoverLockViewBgWidth 40
#define kCoverLockWidth 30
#define kCoverBarWidth 25
#define kProgressViewWidth 150
#define kLandscapeSpacing 10
#define kVertialSpacing 20
#define kBigFont 18
#define kSmallFont 16
#define kBarViewtag             100
#define kQualityViewTag         101
#define kVoiceViewTag           102
//#define kVoiceLabelTag          103
#define kVoiceSliderTag         104
#define kProgressSliderTag      105
#define kProgressMaxLabelTag    106
#define kProgressCurLabelTag    107
#define kProgressViewTag        108
#define kCurProgressLabelTag    109
//#define kTotalProgressLabelTag  110
#define kWardMarkImgViewTag     111
#define kFullScreenBtnTag       112
//#define kScale50BtnTag          113
//#define kScale75BtnTag          114
//#define kScale100BtnTag         115
#define kToolViewTag            116
#define kToolBgViewTag          117
#define kQualityBtnTag          118
#define kSnapBtnTag             119
#define kBarBgViewTag           120
#define kBarPlayBtnTag          121
#define kLoadIndicatorViewTag   122
#define kLoadIndicatorLabelTag  123
#define kLockViewTag            124
#define kScaleBtnTag            125
#define kEpisodeBtnTag          126
#define kScaleViewTag           127
#define kBrightnessViewTag      128
#define kBrightnessSliderTag    129
#define kMediaVoiceViewTag      130
#define kErrorLabelTag          131

#define kCPULabel               132
#define kMemLabel               133
#define kDanmuBtnTag            134
#define kSetBtnTag              135
#define kSetViewTag             136
#define kTitleLabelTag          137
#define kFontLabelTag           138
#define kFontSizeSCTag          139
#define kSpeedLabelTag          140
#define kSpeedSCTag             141
#define kAlphaLabelTag          142
#define kAlphaSCTag             143
#define kPlaySetLabelTag        144
#define kUnderLineTag           145
#define kVoiceSetLabelTag       146
#define kEpisodeTableViewTag    147
#define kCommentBtnTag          148
#define kCommentFieldTag        149
#define kCommentViewTag         150
#define kSendBtnTag             151
#define kTableViewTag           152
#define kBackgroundViewTag      153

//颜色
#define KSYCOLER(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
//字体大小
#define WORDFONT16 16
#define WORDFONT18 18


#endif /* KSYHead_h */
