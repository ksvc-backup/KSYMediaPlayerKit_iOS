//
//  KSYBottomView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  

#import "KSYBottomView.h"


@implementation KSYBottomView
@synthesize kCurrentLabel;
@synthesize kPlaySlider;
@synthesize kShortPlayBtn;
@synthesize kTotalLabel;
@synthesize kFullBtn;
@synthesize qualityBtn;
@synthesize danmuBtn;
@synthesize imageView;
@synthesize fansCount;
@synthesize commentText;

- (instancetype)initWithFrame:(CGRect)frame PlayState:(KSYPopularLivePlayState)playstate
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.6;
        _playstate=playstate;
        //播放按钮 播放时间 进度条 总时间
        kShortPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        kShortPlayBtn.alpha = 0.6;
        UIImage *pauseImg_n = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_pause_normal"];
        UIImage *pauseImg_h = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_pause_hl"];
        [kShortPlayBtn setImage:pauseImg_n forState:UIControlStateNormal];
        [kShortPlayBtn setImage:pauseImg_h forState:UIControlStateHighlighted];
        kShortPlayBtn.frame = CGRectMake(5, 5, 30, 30);
        [kShortPlayBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:kShortPlayBtn];
        kShortPlayBtn.tag=kBarPlayBtnTag;
        
        if (playstate==KSYPopularLivePlay) {
            _playstate=YES;
            //添加用户头像
            imageView=[[UIImageView alloc]initWithFrame:CGRectMake(kShortPlayBtn.right+5, 5, 30, 30)];
            [self addSubview:imageView];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            imageView.image=[UIImage imageNamed:@"userName.png"];
            
            //添加标签
            fansCount=[[UILabel alloc]initWithFrame:CGRectMake(imageView.right+5, 5, 45, 30)];
            fansCount.textColor=[UIColor whiteColor];
            fansCount.font=[UIFont systemFontOfSize:WORDFONT16];
            fansCount.text=@"2000";
            [self addSubview:fansCount];
            
            //添加文本框
            CGRect commentTextRect=CGRectMake(fansCount.right+5, 5, self.width-fansCount.right-10-45, 30);
            commentText=[[UITextField alloc]initWithFrame:commentTextRect];
            [self addSubview:commentText];
            commentText.placeholder=@"填写评论内容";
            [commentText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
            [commentText setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
            commentText.borderStyle=UITextBorderStyleRoundedRect;
            commentText.delegate=self;
            commentText.hidden=YES;
            
            
            //全屏按钮
            kFullBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            CGRect kFullBtnRect = CGRectMake(self.width-40, 5, 30, 30);
            kFullBtn.alpha = 0.6;
            UIImage *fullImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_fullscreen_normal"];
            [kFullBtn setImage:fullImg forState:UIControlStateNormal];
            kFullBtn.frame = kFullBtnRect;
            kFullBtn.tag = kFullScreenBtnTag;
            [kFullBtn addTarget:self action:@selector(clickFullBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:kFullBtn];
            
        }else {
            _playstate=NO;
            //播放时间
            kCurrentLabel=[[UILabel alloc]initWithFrame:CGRectMake(kShortPlayBtn.right+10, kShortPlayBtn.center.y-15, 60, 30)];
            [self addSubview:kCurrentLabel];
            kCurrentLabel.textColor=[UIColor whiteColor];
            kCurrentLabel.text=@"00:00";
            kCurrentLabel.textColor=[UIColor whiteColor];
            kCurrentLabel.textAlignment = NSTextAlignmentRight;
            kCurrentLabel.tag= kProgressCurLabelTag;
            kCurrentLabel.font = [UIFont boldSystemFontOfSize:13];
            UIColor *tintColor = [[KSYThemeManager sharedInstance] themeColor];
            kCurrentLabel.textColor = tintColor;
            
            
            //进度条
            UIImage *dotImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"img_dot_normal"];
            UIImage *minImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"slider_color"];
            kPlaySlider=[[UISlider alloc]initWithFrame:CGRectMake(kCurrentLabel.right+10, kCurrentLabel.center.y-5, self.width-kCurrentLabel.right-10-90, 10)];
            [kPlaySlider setMinimumTrackImage:minImg forState:UIControlStateNormal];
            kPlaySlider.maximumTrackTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
            [kPlaySlider setThumbImage:dotImg forState:UIControlStateNormal];
            [kPlaySlider addTarget:self action:@selector(progressDidBegin:) forControlEvents:UIControlEventTouchDown];
            [kPlaySlider addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
            [kPlaySlider addTarget:self action:@selector(progressChangeEnd:) forControlEvents:(UIControlEventTouchUpOutside | UIControlEventTouchCancel|UIControlEventTouchUpInside)];
            kPlaySlider.value = 0.0;
            kPlaySlider.tag =kProgressSliderTag;
            [self addSubview:kPlaySlider];
            
            //总时间
            kTotalLabel=[[UILabel alloc]initWithFrame:CGRectMake(kPlaySlider.right+5, kShortPlayBtn.center.y-15, 40, 30)];
            kTotalLabel.tag=kProgressMaxLabelTag;
            [self addSubview:kTotalLabel];
            kTotalLabel.text=@"00:00";
            kTotalLabel.textColor=[UIColor whiteColor];
            kTotalLabel.alpha = 0.6;
            kTotalLabel.font = [UIFont boldSystemFontOfSize:13];
            
            
            //全屏按钮
            kFullBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            CGRect kFullBtnRect = CGRectMake(kTotalLabel.right, 5, 30, 30);
            kFullBtn.alpha = 0.6;
            UIImage *fullImg = [[KSYThemeManager sharedInstance] imageInCurThemeWithName:@"bt_fullscreen_normal"];
            [kFullBtn setImage:fullImg forState:UIControlStateNormal];
            kFullBtn.frame = kFullBtnRect;
            kFullBtn.tag = kFullScreenBtnTag;
            [kFullBtn addTarget:self action:@selector(clickFullBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:kFullBtn];
        }
        //添加流畅度按钮面向对象的语言 特性 继承 封装 多态 今天晚上先实现了 明天再优化
        //视频清晰度选择按钮
        qualityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        qualityBtn.alpha = 0.6f;
        qualityBtn.hidden=YES;
        qualityBtn.frame = CGRectMake(self.width-155, 10, 50, 30);
        qualityBtn.tag = kQualityBtnTag;
        qualityBtn.layer.masksToBounds = YES;
        qualityBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        qualityBtn.layer.borderWidth = 0.5;
        qualityBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [qualityBtn setTitle:@"流畅" forState:UIControlStateNormal];
        [qualityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [qualityBtn setTitleColor:KSYCOLER(92, 232, 223) forState:UIControlStateHighlighted];
        [qualityBtn addTarget:self action:@selector(clickQualityBtn) forControlEvents:UIControlEventTouchUpInside];
        //    [qualityBtn addTarget:self action:@selector(clickNormalBtn:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
        //    [qualityBtn addTarget:self action:@selector(clickHighlightBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:qualityBtn];
        
        //添加弹幕按钮
        
        //添加弹幕按钮
        danmuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        danmuBtn.alpha = 0.6f;
        danmuBtn.hidden = YES;
        danmuBtn.frame = CGRectMake(self.width-95, 10, 50, 30);
        danmuBtn.tag = kDanmuBtnTag;
        danmuBtn.layer.masksToBounds = YES;
        danmuBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        danmuBtn.layer.borderWidth = 0.5;
        danmuBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [danmuBtn setTitle:@"弹幕" forState:UIControlStateNormal];
        [danmuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [danmuBtn setTitleColor:KSYCOLER(92, 232, 223) forState:UIControlStateHighlighted];
        [danmuBtn addTarget:self action:@selector(clickDanmuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:danmuBtn];
        
       
    }
    return self;
}


- (void)progressDidBegin:(UISlider *)slider
{
    if (self.progressDidBegin)
    {
        self.progressDidBegin(slider);
    }
}

- (void)progressChanged:(UISlider *)slider {
    
    if (self.progressChanged)
    {
        self.progressChanged(slider);
    }
    
}

- (void)progressChangeEnd:(UISlider *)slider {
    if(self.progressChangeEnd)
    {
        self.progressChangeEnd(slider);
    }
}
- (void)playBtnClick:(UIButton *)btn
{
    if (self.BtnClick) {
        self.BtnClick(btn);
    }
}
- (void)setSubviews
{
    if (_playstate==YES) {
        kShortPlayBtn.frame=CGRectMake(5, 5, 30, 30);
        imageView.frame= CGRectMake(kShortPlayBtn.right+5, 5, 30, 30);
        fansCount.frame= CGRectMake(imageView.right+5, 5, 45, 30);
        commentText.frame=CGRectMake(fansCount.right+5, 5, self.width-commentText.left-125, 30);
        commentText.hidden=NO;
        qualityBtn.hidden=NO;
        qualityBtn.frame= CGRectMake(commentText.right+5, 5, 40, 30);
        danmuBtn.hidden=NO;
        danmuBtn.frame=CGRectMake(qualityBtn.right+5, 5, 40, 30);
        kFullBtn.frame=CGRectMake(danmuBtn.right+5, 5, 30, 30);
    }else{
        kShortPlayBtn.frame=CGRectMake(5, 5, 30, 30);
        kCurrentLabel.frame= CGRectMake(kShortPlayBtn.right+5, kShortPlayBtn.center.y-15, 60, 30);
        kPlaySlider.frame= CGRectMake(kCurrentLabel.right+5, kCurrentLabel.center.y-5, self.width-kCurrentLabel.right-195, 10);
        kTotalLabel.frame=CGRectMake(self.right-190, kShortPlayBtn.center.y-15, 60, 30);
        qualityBtn.hidden=NO;
        qualityBtn.frame= CGRectMake(kTotalLabel.right+5, 5, 40, 30);
        danmuBtn.hidden=NO;
        danmuBtn.frame=CGRectMake(qualityBtn.right+5, 5, 40, 30);
        kFullBtn.frame=CGRectMake(danmuBtn.right+5, 5, 30, 30);
    }
}
- (void)resetSubviews
{
    if (_playstate==YES) {
        kShortPlayBtn.frame=CGRectMake(5, 5, 30, 30);
        imageView.frame= CGRectMake(kShortPlayBtn.right+5, 5, 30, 30);
        fansCount.frame= CGRectMake(imageView.right+5, 5, 45, 30);
        commentText.frame=CGRectMake(fansCount.right+5, 5, self.width-commentText.left-40, 30);
        commentText.hidden=YES;
        qualityBtn.hidden=YES;
        danmuBtn.hidden=YES;
        kFullBtn.frame=CGRectMake(commentText.right+5, 5, 30, 30);
    }else{
        kShortPlayBtn.frame=CGRectMake(5, 5, 30, 30);
        kCurrentLabel.frame= CGRectMake(kShortPlayBtn.right+5, kShortPlayBtn.center.y-15, 60, 30);
        kPlaySlider.frame= CGRectMake(kCurrentLabel.right+5, kCurrentLabel.center.y-5, self.width-kCurrentLabel.right-100, 10);
        kTotalLabel.frame=CGRectMake(self.right-95, kShortPlayBtn.center.y-15, 60, 30);
        qualityBtn.hidden=YES;
        danmuBtn.hidden=YES;
        kFullBtn.frame=CGRectMake(kTotalLabel.right+5, 5, 30, 30);
    }
}
- (void)clickFullBtn:(UIButton *)btn
{
    if (self.FullBtnClick) {
        self.FullBtnClick(btn);
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //通过代码块改变bottom的位置
    if (self.changeBottomFrame) {
        self.changeBottomFrame(textField);
    }
}
- (void)clickQualityBtn
{
    if (self.rechangeBottom) {
        self.rechangeBottom();
    }
}
- (void)clickDanmuBtn:(UIButton *)btn
{
    if (self.addDanmu) {
        self.addDanmu(btn);
    }
}
@end
