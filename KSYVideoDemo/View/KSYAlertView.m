//
//  KSYAlertView.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/16.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYAlertView.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"
#import "SpectatorModel.h"

#define KTEXTSIZE       17
#define KNAMETEXTSIZE   20
#define KLABELWIDTH     50
#define KLABELHEIGHT    25
#define KBUTTONTITLE_COLOR  [UIColor greenColor]
@interface KSYAlertView ()

@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel     *userNameLabel;
@property (nonatomic,strong)UILabel     *praiseNumberLabel;
@property (nonatomic,strong)UILabel     *signLabel;
@property (nonatomic,strong)UILabel     *frequencyLabel;
@property (nonatomic,strong)UILabel     *fansNumberLabl;
@property (nonatomic,strong)UILabel     *followNumberLabel;
@property (nonatomic,strong)UILabel     *liveLabel;
@property (nonatomic,strong)UILabel     *fansLabel;
@property (nonatomic,strong)UILabel     *followLabel;
@property (nonatomic,strong)UIButton    *followButton;
@property (nonatomic,strong)UIButton    *closeButton;
@end
@implementation KSYAlertView
static CGFloat kTransitionDuration = 0.3;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        [self addSubview:self.headImageView];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.praiseNumberLabel];
        [self addSubview:self.signLabel];
        [self addSubview:self.frequencyLabel];
        [self addSubview:self.fansNumberLabl];
        [self addSubview:self.followNumberLabel];
        [self addSubview:self.liveLabel];
        [self addSubview:self.fansLabel];
        [self addSubview:self.followLabel];
        [self addSubview:self.followButton];
        [self addSubview:self.closeButton];

    }
    return self;
}

- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImageView.frame = CGRectMake((self.frame.size.width - 60) / 2.0, 30, 60, 60);
    self.userNameLabel.frame = CGRectMake(10, self.headImageView.bottom + 20, self.frame.size.width - 20, 40);
    self.praiseNumberLabel.frame = CGRectMake((self.frame.size.width - 100) / 2.0, self.userNameLabel.bottom , 100, KLABELWIDTH);
    self.signLabel.frame = CGRectMake(20, self.praiseNumberLabel.bottom , self.frame.size.width - 40, 70);
    self.frequencyLabel.frame = CGRectMake(20, self.signLabel.bottom + 10, KLABELWIDTH, KLABELHEIGHT);
    self.fansNumberLabl.frame = CGRectMake(self.frequencyLabel.right + ((self.frame.size.width - self.frequencyLabel.right * 2 - KLABELWIDTH) / 2.0), self.self.signLabel.bottom + 10, KLABELWIDTH, KLABELHEIGHT);
    self.followNumberLabel.frame = CGRectMake(self.fansNumberLabl.right + ((self.frame.size.width - self.frequencyLabel.right * 2 - KLABELWIDTH) / 2.0), self.self.signLabel.bottom + 10, KLABELWIDTH, KLABELHEIGHT);
    self.liveLabel.frame = CGRectMake(20, self.frequencyLabel.bottom , KLABELWIDTH, KLABELHEIGHT);
    self.fansLabel.frame = CGRectMake(self.liveLabel.right +  ((self.frame.size.width - self.liveLabel.right * 2 - KLABELWIDTH) / 2.0), self.frequencyLabel.bottom, KLABELWIDTH, KLABELHEIGHT);
    self.followLabel.frame = CGRectMake(self.fansLabel.right +  ((self.frame.size.width - self.liveLabel.right * 2 - KLABELWIDTH) / 2.0), self.frequencyLabel.bottom, KLABELWIDTH, KLABELHEIGHT);
    self.followButton.frame = CGRectMake((self.frame.size.width - 150) / 2, self.frame.size.height - 30 - 15, 150, 30);
    self.closeButton.frame = CGRectMake(self.frame.size.width - 70, 20, 40, 40);
}
- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.layer.cornerRadius = 17.5;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.backgroundColor = [UIColor purpleColor];
    }
    return _headImageView;
}

- (UILabel *)praiseNumberLabel
{
    if (!_praiseNumberLabel) {
        _praiseNumberLabel = [UILabel new];
        _praiseNumberLabel.textAlignment = NSTextAlignmentCenter;
        _praiseNumberLabel.textColor = [UIColor whiteColor];
        _praiseNumberLabel.font = [UIFont systemFontOfSize:KTEXTSIZE];
    }
    return _praiseNumberLabel;
}
- (UILabel *)signLabel
{
    if (!_signLabel) {
        _signLabel = [UILabel new];
        _signLabel.numberOfLines = 0;
        _signLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _signLabel.textColor = [UIColor whiteColor];
        _signLabel.font = [UIFont systemFontOfSize:KTEXTSIZE];
        _signLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _signLabel;
}
- (UILabel *)frequencyLabel
{
    if (!_frequencyLabel) {
        _frequencyLabel = [UILabel new];
        _frequencyLabel.textColor = [UIColor whiteColor];
        _frequencyLabel.font = [UIFont systemFontOfSize:KTEXTSIZE];
        _frequencyLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _frequencyLabel;
}
- (UILabel *)fansNumberLabl
{
    if (!_fansNumberLabl) {
        _fansNumberLabl = [UILabel new];
        _fansNumberLabl.textColor = [UIColor whiteColor];
        _fansNumberLabl.font = [UIFont systemFontOfSize:KTEXTSIZE];
        _fansNumberLabl.textAlignment = NSTextAlignmentCenter;

    }
    return _fansNumberLabl;
}
- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [UILabel new];
        _userNameLabel.textColor = [UIColor whiteColor];
        _userNameLabel.font = [UIFont boldSystemFontOfSize:KNAMETEXTSIZE];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _userNameLabel;
}
- (UILabel *)followNumberLabel
{
    if (!_followNumberLabel) {
        _followNumberLabel = [UILabel new];
        _followNumberLabel.textColor = [UIColor whiteColor];
        _followNumberLabel.font = [UIFont systemFontOfSize:KTEXTSIZE];
        _followNumberLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _followNumberLabel;
}
- (UILabel *)liveLabel
{
    if (!_liveLabel) {
        _liveLabel = [UILabel new];
        _liveLabel.text = @"直播";
        _liveLabel.textColor = [UIColor whiteColor];
        _liveLabel.font = [UIFont systemFontOfSize:KTEXTSIZE];
        _liveLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _liveLabel;
}
- (UILabel *)fansLabel
{
    if (!_fansLabel) {
        _fansLabel = [UILabel new];
        _fansLabel.text = @"粉丝";
        _fansLabel.textColor = [UIColor whiteColor];
        _fansLabel.font = [UIFont systemFontOfSize:KTEXTSIZE];
        _fansLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _fansLabel;
}

- (UILabel *)followLabel
{
    if (!_followLabel) {
        _followLabel = [UILabel new];
        _followLabel.text = @"关注";
        _followLabel.textColor = [UIColor whiteColor];
        _followLabel.font = [UIFont systemFontOfSize:KTEXTSIZE];
        _followLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _followLabel;
}

- (UIButton *)followButton
{
    if (!_followButton) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followButton setTitle:@"+    关注" forState:UIControlStateNormal];
        _followButton.layer.borderColor =  [UIColor colorWithHEX:0x20c6c6].CGColor;
        _followButton.layer.borderWidth = 1;
        [_followButton setTitleColor: [UIColor colorWithHEX:0x20c6c6] forState:UIControlStateNormal];

    }
    return _followButton;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"X" forState:UIControlStateNormal];
        [_closeButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(alertViewDisAppere) forControlEvents:UIControlEventTouchUpInside];

    }
    return _closeButton;
}

- (void)setContentModel:(id)contentModel
{
    SpectatorModel *model = (SpectatorModel *)contentModel;
    _signLabel.text = model.signConent;
    _praiseNumberLabel.text = [NSString stringWithFormat:@"%@   赞",model.praiseNumber];
    _frequencyLabel.text = model.liveNumber;
    _fansNumberLabl.text = model.fansNumber;
    _userNameLabel.text = model.name;
    _followNumberLabel.text = model.followNumber;
}
- (void)alertViewDisAppere
{
    self.hidden = YES;
}


@end
