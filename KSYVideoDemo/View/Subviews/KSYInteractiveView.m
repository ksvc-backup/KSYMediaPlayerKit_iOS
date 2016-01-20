//
//  KSYInteractiveView.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/10.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  用户交互视图

#import "KSYInteractiveView.h"
#import "KSYCommentTableView.h"
#import "KSYSpectatorsTableView.h"
#import "KSYMessageToolBar.h"
#import "UIView+BFExtension.h"
#import "KSYProgressToolBar.h"
#define DeviceSizeBounds [UIScreen mainScreen].bounds
#define SCREENHEIGHT   200


@interface KSYInteractiveView ()<KSYMessageToolBarDelegate,UIGestureRecognizerDelegate>{
    NSInteger   _testNum;
    UITapGestureRecognizer *_gestureRecongizer;
    CGFloat     _lastHeight;
}
@property (nonatomic, strong)KSYCommentTableView    *commetnTableView;
@property (nonatomic, strong)KSYSpectatorsTableView *spectatorsTableViews;
@property (nonatomic, strong)UILabel                *spectatorsComeLabel;
@property (nonatomic, strong)KSYMessageToolBar      *messageToolBar;
@property (nonatomic, strong)UIImageView            *spectatorsNumberImv;
@property (nonatomic, strong)UILabel                *userNumLab;
@property (nonatomic, strong)UIButton               *praiseBtn;
@property (nonatomic, strong)KSYProgressToolBar     *progressToolBar;
@property (nonatomic, assign)BOOL                   isOff;
@end
@implementation KSYInteractiveView


- (instancetype)initWithFrame:(CGRect)frame playState:(KSYPhoneLivePlayState)state
{
    self = [super initWithFrame:frame];
    if (self) {
        _testNum = 200;
        _lastHeight = 0;
        self.backgroundColor = [UIColor clearColor];
        
        if (_gestureRecongizer == nil) {
            _gestureRecongizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageToolBarInputResignFirstResponder)];
            _gestureRecongizer.delegate = self;
        }
        if (state == KSYPhoneLivePlay) {
            [self addSubview:self.messageToolBar];
            
        }else {
            [self addSubview:self.progressToolBar];
        }

        [self addGestureRecognizer:_gestureRecongizer];
        [self addSubview:self.spectatorsTableViews];
        [self addSubview:self.spectatorsComeLabel];

        [self addSubview:self.commetnTableView];
        [self addSubview:self.praiseBtn];
        [self addSubview:self.spectatorsNumberImv];
        [self addSubview:self.userNumLab];

    }
    return self;
}

- (KSYCommentTableView *)commetnTableView
{
    if (!_commetnTableView) {
        _commetnTableView = [[KSYCommentTableView alloc] initWithFrame:CGRectMake(10, _spectatorsTableViews.top - 200 - 5, 200, 200)];
        _commetnTableView.backgroundColor = [UIColor clearColor];

    }
    return _commetnTableView;
}

- (UILabel *)spectatorsComeLabel
{
    if (!_spectatorsComeLabel) {
        _spectatorsComeLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, _spectatorsTableViews.top - 22, 150, 22)];
        _spectatorsComeLabel.backgroundColor = [UIColor blackColor];
        _spectatorsComeLabel.textAlignment = NSTextAlignmentCenter;
        _spectatorsComeLabel.textColor = [UIColor whiteColor];
        _spectatorsComeLabel.font = [UIFont systemFontOfSize:13.0];
        _spectatorsComeLabel.alpha = 0.5;
        _spectatorsComeLabel.layer.cornerRadius = 8;
        _spectatorsComeLabel.layer.masksToBounds = YES;
        _spectatorsComeLabel.hidden = YES;
    }
    return _spectatorsComeLabel;
}


- (KSYSpectatorsTableView *)spectatorsTableViews
{
    WeakSelf(KSYInteractiveView);
    if (!_spectatorsTableViews) {
        if (_messageToolBar) {
            _spectatorsTableViews = [[KSYSpectatorsTableView alloc] initWithFrame:CGRectMake(46, _messageToolBar.top - 45, self.bounds.size.width - 46 - 80, 40)];

        }else {
            _spectatorsTableViews = [[KSYSpectatorsTableView alloc] initWithFrame:CGRectMake(46, _progressToolBar.top - 40 - 5, self.bounds.size.width - 46 - 80, 40)];

        }
        _spectatorsTableViews.specTatorsInfoBlock = ^(id obj){
        
            if (weakSelf.alertViewBlock) {
                weakSelf.alertViewBlock(obj);
            }
        };

    }
    return _spectatorsTableViews;
}

- (KSYMessageToolBar *)messageToolBar
{
    if (!_messageToolBar) {
        WeakSelf(KSYInteractiveView);
        _messageToolBar = [[KSYMessageToolBar alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.bounds.size.width, 40)];
        _messageToolBar.delegate = self;
        _messageToolBar.userEventBlock = ^(NSInteger index){
            if (index == 1) {
                weakSelf.isOff = YES;

            }else if(index == 0){
                weakSelf.isOff = NO;


            }else if (index == 2){
                if (weakSelf.shareEventBlock) {
                    weakSelf.shareEventBlock();
                }
            }
            [weakSelf interactiveisOff:weakSelf.isOff];

        };

    }
    return _messageToolBar;
}

- (KSYProgressToolBar *)progressToolBar
{
    if (!_progressToolBar) {
        WeakSelf(KSYInteractiveView);

        _progressToolBar = [[KSYProgressToolBar alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.bounds.size.width, 40)];
        _progressToolBar.playControlEventBlock = ^(BOOL isStop){
            if (weakSelf.playEventBlock) {
                weakSelf.playEventBlock(isStop);
            }
        };
        _progressToolBar.seekToBlock = ^(double value){
            if (weakSelf.seekBlock) {
                weakSelf.seekBlock(value);
            }
        };
        _progressToolBar.userEventBlock = ^(NSInteger index){
            if (index == 1) {
                weakSelf.isOff = YES;
            }else if(index == 0){
                weakSelf.isOff = NO;
                
            }else if (index == 2){
                if (weakSelf.shareEventBlock) {
                    weakSelf.shareEventBlock();
                }
            }
            [weakSelf interactiveisOff:weakSelf.isOff];

        };

        

    }
    return _progressToolBar;
}

- (UIImageView *)spectatorsNumberImv
{
    if (!_spectatorsNumberImv) {
        _spectatorsNumberImv = [[UIImageView alloc] initWithFrame:CGRectMake(10, _spectatorsTableViews.top, 30, 30)];
        _spectatorsNumberImv.image = [UIImage imageNamed:@"spectatorsNumber"];
        
    }
    return _spectatorsNumberImv;
}
- (UILabel *)userNumLab
{
    if (!_userNumLab) {
        _userNumLab = [[UILabel alloc] initWithFrame:CGRectMake(10, _spectatorsNumberImv.bottom , 30, 14)];
        _userNumLab.backgroundColor = [UIColor clearColor];
        _userNumLab.text = [NSString stringWithFormat:@"%@",@(_testNum)];
        _userNumLab.font = [UIFont systemFontOfSize:12];
        _userNumLab.textAlignment = NSTextAlignmentCenter;
        _userNumLab.textColor = [UIColor whiteColor];
    }
    return _userNumLab;
}

- (UIButton *)praiseBtn
{
    if (!_praiseBtn) {
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _praiseBtn.backgroundColor = [UIColor redColor];
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
        _praiseBtn.frame = CGRectMake(_spectatorsTableViews.right + 24, _spectatorsTableViews.top - 7, 50, 50);
        [_praiseBtn addTarget:self action:@selector(praiseEvent) forControlEvents:UIControlEventTouchUpInside];

    }
    return _praiseBtn;
}

- (BOOL)isOff
{
    self.commetnTableView.hidden = _isOff;
    self.spectatorsTableViews.hidden = _isOff;
    self.spectatorsNumberImv.hidden = _isOff;
    self.userNumLab.hidden = _isOff;
    self.praiseBtn.hidden = _isOff;
    return _isOff;
}
- (void)interactiveisOff:(BOOL)isOn
{
    self.commetnTableView.hidden = isOn;
    self.spectatorsTableViews.hidden = isOn;
    self.spectatorsNumberImv.hidden = isOn;
    self.userNumLab.hidden = isOn;
    self.praiseBtn.hidden = isOn;
    self.spectatorsComeLabel.hidden = isOn;
}
- (void)didChangeFrameToHeight:(CGFloat)toHeight endHeight:(CGFloat)bottomHeight
{
    

    if (bottomHeight > 0) {
        
    }
    _lastHeight = bottomHeight;
    
    CGRect fromFrame = self.frame;
     toHeight = self.frame.size.height + bottomHeight;
    CGRect toFrame = CGRectMake(fromFrame.origin.x, fromFrame.origin.y + (fromFrame.size.height - toHeight), fromFrame.size.width, toHeight);
    NSLog(@"toFrame is %@",NSStringFromCGRect(toFrame));
    if((bottomHeight < 0 && self.frame.size.height == self.messageToolBar.frame.size.height) || toFrame.origin.y < -100)
    {
        return;
    }
    
    
    self.frame = toFrame;

}

- (void)setSpectatorsArray:(NSArray *)spectatorsArray
{
    _spectatorsArray = spectatorsArray;
    _spectatorsTableViews.spectatorsArray = self.spectatorsArray;

    
}
#pragma mark- 事件
- (void)addNewCommentWith:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        _testNum++;
        _userNumLab.text = [NSString stringWithFormat:@"%@",@(_testNum)];
        self.spectatorsComeLabel.text = [NSString stringWithFormat:@"%@     来了",object];

        if (!self.isOff) {
            self.spectatorsComeLabel.hidden = NO;
            self.commetnTableView.frame = CGRectMake(10, _spectatorsComeLabel.top - 200 - 5, 200, 200);

        }
    }else {
        [self.commetnTableView newUserAdd:object];

    }
}

- (void)updateProgressWithCurentTime:(NSTimeInterval)time duration:(NSTimeInterval)duration playabeDuration:(NSTimeInterval)playableduration
{
    [self.progressToolBar updataSliderWithPosition:time duration:duration playableDuration:playableduration ];
}

- (void)playerStop:(BOOL)isStop
{
    [self.progressToolBar playerIsStop:isStop];
}
#pragma mark- buttonEvent

- (void)praiseEvent
{
    [self onPraiseWithSpectatorsInteractiveType:SpectatorsInteractivePraise];
}

- (void)messageToolBarInputResignFirstResponder
{
    [self.messageToolBar.inputTexField resignFirstResponder];
}
#pragma 点赞

- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to

{
    
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
    
}
- (void)onPraiseWithSpectatorsInteractiveType:(SpectatorsInteractiveType)type
{
    if (self.isOff) {
        return;
    }
    NSString *imageName = [NSString stringWithFormat:@"heart%@",@([self getRandomNumber:1 to:7])];
    UIImageView* flakeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    if (type == SpectatorsInteractivePresent) {
        flakeView.backgroundColor = [UIColor clearColor];
    }else {
        flakeView.backgroundColor = [UIColor clearColor];
        
    }
    int startX = round(random() % 100);
    //    int endX = round(random() % 100);
    double scale = 1 / round(random() % 700) + 1.0;
    double speed = 1 / round(random() % 900) + 1.0;
    
    flakeView.frame = CGRectMake(_praiseBtn.frame.origin.x + 9, _praiseBtn.frame.origin.y + 7, 32, 32);
    
    flakeView.alpha = 1;
    
    [self addSubview:flakeView];
    
    [UIView beginAnimations:nil context:(__bridge void * _Nullable)(flakeView)];
    [UIView setAnimationDuration:7 * speed];
    flakeView.frame = CGRectMake(startX+300, -200, 20.0 * scale, 20.0 * scale);
    flakeView.alpha = 0.3;

    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    //
}
- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    UIImageView *flakeView = (__bridge UIImageView *)(context);
    [flakeView removeFromSuperview];
    
    
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if([touch.view isKindOfClass:[UIImageView class]]){
        return NO;
    }else
        return YES;
}
- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, self.width,100);
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0] CGColor] ,
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1] CGColor] ,
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor],
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3] CGColor],
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.4] CGColor],
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor],
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.6] CGColor],
                        nil];
    return newShadow;
}

@end
