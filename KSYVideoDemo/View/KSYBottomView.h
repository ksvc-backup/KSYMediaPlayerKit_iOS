//
//  KSYBottomView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSYBottomView : UIView<UITextFieldDelegate>
{
    BOOL _playstate;
}
@property (nonatomic, strong) UIButton *kShortPlayBtn;
@property (nonatomic, strong) UILabel *kCurrentLabel;
@property (nonatomic, strong) UISlider *kPlaySlider;
@property (nonatomic, strong) UILabel *kTotalLabel;
@property (nonatomic, strong) UIButton *kFullBtn;
@property (nonatomic, strong) UIButton *danmuBtn;
@property (nonatomic, strong) UIButton *qualityBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *fansCount;
@property (nonatomic, strong) UITextField *commentText;



@property (nonatomic, copy) void (^progressDidBegin)(UISlider *slider);
@property (nonatomic, copy) void (^progressChanged)(UISlider *slider);
@property (nonatomic, copy) void (^progressChangeEnd)(UISlider *slider);
@property (nonatomic, copy) void (^BtnClick)(UIButton *btn);
@property (nonatomic, copy) void (^FullBtnClick)(UIButton *btn);
@property (nonatomic, copy) void (^changeBottomFrame)(UITextField *textField);
@property (nonatomic, copy) void (^rechangeBottom)();
@property (nonatomic, copy) void (^addDanmu)(UIButton *btn);




- (instancetype)initWithFrame:(CGRect)frame PlayState:(KSYPopularLivePlayState)playstate;
- (void)setSubviews;
- (void)resetSubviews;
@end
