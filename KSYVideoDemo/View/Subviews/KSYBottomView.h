//
//  KSYBottomView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSYProgressVI.h"
@interface KSYBottomView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *kShortPlayBtn;
@property (nonatomic, strong) UILabel *kCurrentLabel;
@property (nonatomic, strong) UILabel *kTotalLabel;
@property (nonatomic, strong) UIButton *kFullBtn;
@property (nonatomic, strong) UIButton *danmuBtn;
@property (nonatomic, strong) UIButton *qualityBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *fansCount;
@property (nonatomic, strong) UITextField *commentText;
@property (nonatomic, strong) KSYProgressVI *kprogress;
@property (nonatomic, strong) UIButton *episodeBtn;

@property (nonatomic, copy) void (^changBegin)(UISlider *slider);
@property (nonatomic, copy) void (^changIng)(UISlider *slider);
@property (nonatomic, copy) void (^ChangeEnd)(UISlider *slider);
@property (nonatomic, copy) void (^BtnClick)(UIButton *btn);
@property (nonatomic, copy) void (^FullBtnClick)(UIButton *btn);
@property (nonatomic, copy) void (^unFullBtnClick)(UIButton *btn);
@property (nonatomic, copy) void (^changeBottomFrame)(CGFloat keyBoardHeight);
@property (nonatomic, copy) void (^rechangeBottom)();
@property (nonatomic, copy) void (^addDanmu)(BOOL isOpen);
@property (nonatomic, copy) void (^addEpisodeView)(UIButton *btn);
- (instancetype)initWithFrame:(CGRect)frame PlayState:(KSYPopularLivePlayState)playstate;

- (void)updateCurrentDuration:(NSInteger)duration Position:(NSInteger)currentPlaybackTime playAbleDuration:(NSInteger)playableDuration;
- (void)setSubviews;
- (void)resetSubviews;
@end
