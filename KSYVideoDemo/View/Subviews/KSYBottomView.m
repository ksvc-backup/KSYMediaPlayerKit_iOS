//
//  KSYBottomView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/24.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  

#import "KSYBottomView.h"


@interface KSYBottomView (){
    BOOL isFull;
}

@end

@implementation KSYBottomView
@synthesize kCurrentLabel;
@synthesize kShortPlayBtn;
@synthesize kTotalLabel;
@synthesize kFullBtn;
@synthesize qualityBtn;
@synthesize danmuBtn;
@synthesize imageView;
@synthesize fansCount;
@synthesize commentText;
@synthesize kprogress;
@synthesize episodeBtn;
- (instancetype)initWithFrame:(CGRect)frame PlayState:(KSYPopularLivePlayState)playstate
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.7;
        _playstate=playstate;
        //播放按钮 播放时间 进度条 总时间
        kShortPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *pauseImg_n = [UIImage imageNamed:@"play"];
        [kShortPlayBtn setImage:pauseImg_n forState:UIControlStateNormal];
        kShortPlayBtn.frame = CGRectMake(5, 5, 30, 30);
        [kShortPlayBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:kShortPlayBtn];
        kShortPlayBtn.tag=kBarPlayBtnTag;
        
        if (_playstate==KSYPopularLivePlay) {
            //添加用户头像
            imageView=[[UIImageView alloc]initWithFrame:CGRectMake(kShortPlayBtn.right+5, 5, 30, 30)];
            [self addSubview:imageView];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            imageView.image=[UIImage imageNamed:@"custome"];
            
            //添加标签
            fansCount=[[UILabel alloc]initWithFrame:CGRectMake(imageView.right+5, 5, 45, 30)];
            fansCount.textColor=[UIColor whiteColor];
            fansCount.font=[UIFont systemFontOfSize:WORDFONT16];
            fansCount.text=@"2000";
            [self addSubview:fansCount];
            
            //添加文本框
            CGRect commentTextRect=CGRectMake(fansCount.right+5, 5, self.width-fansCount.right-10-45, 30);
            commentText=[[UITextField alloc]initWithFrame:commentTextRect];
            commentText.backgroundColor=[UIColor lightGrayColor];
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
            UIImage *fullImg = [UIImage imageNamed:@"full"];
            [kFullBtn setImage:fullImg forState:UIControlStateNormal];
            kFullBtn.frame = kFullBtnRect;
            kFullBtn.tag = kFullScreenBtnTag;
            [kFullBtn addTarget:self action:@selector(clickFullBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:kFullBtn];
            
        }else {
           
            //播放时间
            kCurrentLabel=[[UILabel alloc]initWithFrame:CGRectMake(kShortPlayBtn.right, kShortPlayBtn.center.y-15, 50, 30)];
            [self addSubview:kCurrentLabel];
            kCurrentLabel.text=@"00:00";
            kCurrentLabel.textColor=[UIColor whiteColor];
            kCurrentLabel.textAlignment = NSTextAlignmentCenter;
            kCurrentLabel.tag= kProgressCurLabelTag;
            kCurrentLabel.font = [UIFont boldSystemFontOfSize:WORDFONT16];
            
            if (_playstate==kSYShortVideoPlay) {
               kprogress=[[KSYProgressVI alloc]initWithFrame:CGRectMake(kCurrentLabel.right+5, kCurrentLabel.center.y-5, self.width-kCurrentLabel.right-70, 10)];
                //总时间
                kTotalLabel=[[UILabel alloc]initWithFrame:CGRectMake(kprogress.right+5, kprogress.center.y-15, 50, 30)];
                //全屏按钮
                kFullBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                CGRect kFullBtnRect = CGRectMake(kTotalLabel.right, 5, 30, 30);
                kFullBtn.frame = kFullBtnRect;
                kFullBtn.hidden=YES;
            }else{
                kprogress=[[KSYProgressVI alloc]initWithFrame:CGRectMake(kCurrentLabel.right+5, kCurrentLabel.center.y-5, self.width-kCurrentLabel.right-10-85, 10)];
                //总时间
                kTotalLabel=[[UILabel alloc]initWithFrame:CGRectMake(kprogress.right+5, kprogress.center.y-15, 50, 30)];
                //全屏按钮
                kFullBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                CGRect kFullBtnRect = CGRectMake(kTotalLabel.right, 5, 30, 30);
                kFullBtn.frame = kFullBtnRect;
            }
            
            [self addSubview:kprogress];
            
            
            
            kTotalLabel.tag=kProgressMaxLabelTag;
            [self addSubview:kTotalLabel];
            kTotalLabel.textAlignment = NSTextAlignmentCenter;
            kTotalLabel.text=@"00:00";
            kTotalLabel.textColor=[UIColor whiteColor];
            kTotalLabel.font = [UIFont boldSystemFontOfSize:WORDFONT16];
            
            
           
            UIImage *fullImg = [UIImage imageNamed:@"full"];
            [kFullBtn setImage:fullImg forState:UIControlStateNormal];
            kFullBtn.tag = kFullScreenBtnTag;
            [kFullBtn addTarget:self action:@selector(clickFullBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:kFullBtn];
            
        }
        //视频清晰度选择按钮
        qualityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        qualityBtn.hidden=YES;
        qualityBtn.frame = CGRectMake(self.width-155, 10, 50, 30);
        qualityBtn.tag = kQualityBtnTag;
        UIImage *qualityImage=[UIImage imageNamed:@"quality"];
        [qualityBtn setImage:qualityImage forState:UIControlStateNormal];
        [qualityBtn addTarget:self action:@selector(clickQualityBtn) forControlEvents:UIControlEventTouchUpInside];
        //    [qualityBtn addTarget:self action:@selector(clickNormalBtn:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchDragOutside];
        //    [qualityBtn addTarget:self action:@selector(clickHighlightBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:qualityBtn];
        

        //添加弹幕按钮
        danmuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        danmuBtn.hidden = YES;
        danmuBtn.frame = CGRectMake(self.width-95, 10, 50, 30);
        danmuBtn.tag = kDanmuBtnTag;
        UIImage *danmuImage=[UIImage imageNamed:@"danMuClose"];
        [danmuBtn setImage:danmuImage forState:UIControlStateNormal];
        [danmuBtn addTarget:self action:@selector(clickDanmuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:danmuBtn];
    }
    return self;
}
- (void)clickEpisodeBtn:(UIButton *)btn{
    if (self.addEpisodeView) {
        self.addEpisodeView(btn);
    }
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
    UIImage *fullImage=[UIImage imageNamed:@"unfull"];
    if (_playstate==KSYPopularLivePlay) {
        kShortPlayBtn.frame=CGRectMake(5, 5, 30, 30);
        imageView.frame= CGRectMake(kShortPlayBtn.right+5, 5, 30, 30);
        fansCount.frame= CGRectMake(imageView.right+5, 5, 45, 30);
        commentText.frame=CGRectMake(fansCount.right+5, 5, self.width-commentText.left-130, 30);
        commentText.hidden=NO;
        qualityBtn.hidden=NO;
        qualityBtn.frame= CGRectMake(commentText.right+5, 5, 40, 30);
        danmuBtn.hidden=NO;
        danmuBtn.frame=CGRectMake(qualityBtn.right+5, 5, 40, 30);
        kFullBtn.frame=CGRectMake(danmuBtn.right+5, 5, 30, 30);
        [kFullBtn setImage:fullImage forState:UIControlStateNormal];
    }else  {
        kShortPlayBtn.frame=CGRectMake(5, 5, 30, 30);
        kCurrentLabel.frame= CGRectMake(kShortPlayBtn.right+5, kShortPlayBtn.center.y-15, 55, 30);
        kprogress.frame=CGRectMake(kCurrentLabel.right+5, kCurrentLabel.center.y-5, self.width-kCurrentLabel.right-185, 10);
        [kprogress setLength];
        kTotalLabel.frame=CGRectMake(kprogress.right+5, kShortPlayBtn.center.y-15, 55, 30);
        qualityBtn.hidden=NO;
        qualityBtn.frame= CGRectMake(kTotalLabel.right+5, 5, 40, 30);
        danmuBtn.hidden=NO;
        danmuBtn.frame=CGRectMake(qualityBtn.right+5, 5, 40, 30);
        if (_playstate==KSYVideoOnlinePlay) {

            if (!episodeBtn) {
                //选集
                episodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                CGRect episodeBtnRect = CGRectMake(danmuBtn.right+5, 5, 40, 30);
                UIImage *episodeBtnImage = [UIImage imageNamed:@"episode"];
                [episodeBtn setImage:episodeBtnImage forState:UIControlStateNormal];
                episodeBtn.frame = episodeBtnRect;
                [episodeBtn addTarget:self action:@selector(clickEpisodeBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:episodeBtn];
            }
            episodeBtn.hidden=NO;
            kFullBtn.hidden=YES; 
        }else if (_playstate==KSYPopularPlayBack){
            kFullBtn.frame=CGRectMake(danmuBtn.right+5, 5, 30, 30);
            [kFullBtn setImage:fullImage forState:UIControlStateNormal];
        }
    }
}
- (void)resetSubviews
{
    UIImage *unFullImage=[UIImage imageNamed:@"full"];
    if (_playstate==KSYPopularLivePlay) {
        kShortPlayBtn.frame=CGRectMake(5, 5, 30, 30);
        imageView.frame= CGRectMake(kShortPlayBtn.right+5, 5, 30, 30);
        fansCount.frame= CGRectMake(imageView.right+5, 5, 45, 30);
        [commentText resignFirstResponder];
        commentText.frame=CGRectMake(fansCount.right+5, 5, self.width-commentText.left-40, 30);
        commentText.hidden=YES;
        qualityBtn.hidden=YES;
        danmuBtn.hidden=YES;
        kFullBtn.frame=CGRectMake(commentText.right+5, 5, 30, 30);
        [kFullBtn setImage:unFullImage forState:UIControlStateNormal];
    }else {
        kShortPlayBtn.frame=CGRectMake(5, 5, 30, 30);
        kCurrentLabel.frame= CGRectMake(kShortPlayBtn.right, kShortPlayBtn.center.y-15, 50, 30);
        kprogress.frame=CGRectMake(kCurrentLabel.right+5, kCurrentLabel.center.y-5, self.width-kCurrentLabel.right-10-85 ,10);
        [kprogress setLength];
        kTotalLabel.frame=CGRectMake(kprogress.right+5, kprogress.center.y-15, 50, 30);
        qualityBtn.hidden=YES;
        danmuBtn.hidden=YES;
        kFullBtn.frame=CGRectMake(kTotalLabel.right, 5, 30, 30);
        [kFullBtn setImage:unFullImage forState:UIControlStateNormal];
        episodeBtn.hidden=YES;
    }
}
- (void)clickFullBtn:(UIButton *)btn
{
    isFull=!isFull;
    if (isFull) {
        if (self.FullBtnClick) {
            self.FullBtnClick(btn);
        }
    }else{
        if (self.unFullBtnClick) {
            self.unFullBtnClick(btn);
        }
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self regNotification];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self unregNotification];
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
- (void)updateCurrentDuration:(NSInteger)duration Position:(NSInteger)currentPlaybackTime playAbleDuration:(NSInteger)playableDuration{
    
    int iMin  = (int)(currentPlaybackTime / 60);
    int iSec  = (int)(currentPlaybackTime % 60);
    kCurrentLabel.text = [NSString stringWithFormat:@"%02d:%02d", iMin, iSec];
    int iDuraMin  = (int)(duration / 60);
    int iDuraSec  = (int)(duration % 3600 % 60);
    kTotalLabel.text = [NSString stringWithFormat:@"%02d:%02d", iDuraMin, iDuraSec];
    [kprogress updateProgress:duration Position:currentPlaybackTime playAbleDuration:playableDuration];
}
- (void)regNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)unregNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyboardWillChangeFrame:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGFloat height = endKeyboardRect.size.height;
    
    //通过代码块改变bottom的位置
    if (self.changeBottomFrame) {
        self.changeBottomFrame(height);
    }
}


@end
