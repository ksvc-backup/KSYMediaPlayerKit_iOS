//
//  KSYDetalTVCell.m
//  AMZVideoDemo
//
//  Created by 孙健 on 15/12/15.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYDetalTVCell.h"
#define HOSTNAMEFONT 18
#define HOSTLEVELFONT 16
#define SIGNATUREFONT 17
#define SPACING 10
#define KSYCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
@interface KSYDetalTVCell ()
{
    UIImageView *_hostImageView;
    UILabel *_hostName;
    UILabel *_hostLevel;
    UILabel *_fansCount;
    UILabel *_signature;
    UIButton *_focusBtn;
    UILabel *_underLine;
    UILabel *_studioName;
    UILabel *_time;
    UILabel *_playtimes;
    UILabel *_content;
}

@end



@implementation KSYDetalTVCell


#pragma mark 初始化视图方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}

#pragma mark 初始化布局
- (void)initSubviews
{
    //头像控件
    _hostImageView=[[UIImageView alloc]init];
    [self addSubview:_hostImageView];
    //主播名字
    _hostName=[[UILabel alloc]init];
    [self addSubview:_hostName];
    //级别
    _hostLevel=[[UILabel alloc]init];
    [self addSubview:_hostLevel];
    //粉丝数量
    _fansCount=[[UILabel alloc]init];
    [self addSubview:_fansCount];
    //个人签名
    _signature=[[UILabel alloc]init];
    [self addSubview:_signature];
    _signature.numberOfLines=0;
    //关注按钮
    _focusBtn=[[UIButton alloc]init];
    [self addSubview:_focusBtn];
    //下划线
    _underLine=[[UILabel alloc]init];
    [self addSubview:_underLine];
    //直播间名称
    _studioName=[[UILabel alloc]init];
    [self addSubview:_studioName];
    //时间
    _time=[[UILabel alloc]init];
    [self addSubview:_time];
    _time.numberOfLines=0;
    //播放次数
    _playtimes=[[UILabel alloc]init];
    [self addSubview:_playtimes];
    //内容简介
    _content=[[UILabel alloc]init];
    [self addSubview:_content];
    _content.numberOfLines=0;
}
#pragma mark 设置模型
- (void)setModel2:(KSYDetailModel *)model2
{
    //主播头像图片
    CGFloat hostImageViewX=10,hostImageViewY=10;
    CGRect hostImageViewRect=CGRectMake(hostImageViewX, hostImageViewY, 80, 80);
    _hostImageView.image=[UIImage imageNamed:model2.hostImageProf];
    //设置圆角
    _hostImageView.layer.masksToBounds=YES;
    _hostImageView.layer.cornerRadius=40;
    _hostImageView.frame=hostImageViewRect;

    
    //主播名称
    CGFloat hostNameX=CGRectGetMaxX(_hostImageView.frame)+10;
    CGFloat hostNameY=CGRectGetMinY(_hostImageView.frame);
    CGSize hostNameSize=[model2.hostName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:HOSTNAMEFONT]}];
    CGRect hostNameRect=CGRectMake(hostNameX, hostNameY, hostNameSize.width, hostNameSize.height);
    _hostName.text=model2.hostName;
    _hostName.frame=hostNameRect;
    
    //级别
    CGFloat hostLevelX=hostNameX;
    CGFloat hostLevelY=CGRectGetMaxY(_hostName.frame)+SPACING;
    CGSize hostLevelSize=[model2.hostLevel sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:HOSTLEVELFONT]}];
    CGRect hostLevelRect=CGRectMake(hostLevelX, hostLevelY, hostLevelSize.width, hostLevelSize.height);
    _hostLevel.text=model2.hostLevel;
    _hostLevel.frame=hostLevelRect;
    
    //粉丝数量
    CGFloat fansCountX=CGRectGetMaxX(_hostLevel.frame)+SPACING;
    CGFloat fansCountY=hostLevelY;
    CGSize fansCountSize=[model2.fansCount sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:HOSTLEVELFONT]}];
    CGRect fansCountRect=CGRectMake(fansCountX, fansCountY, fansCountSize.width, fansCountSize.height);
    _hostLevel.text=model2.fansCount;
    _hostLevel.frame=fansCountRect;
    
    //关注按钮
    CGFloat fouceBtnX=hostImageViewX;
    CGFloat fouctBtnY=CGRectGetMaxY(_hostImageView.frame)+SPACING;
    _focusBtn.frame=CGRectMake(fouceBtnX, fouctBtnY, 80, 20);
    [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    _focusBtn.layer.masksToBounds=YES;
    _focusBtn.layer.cornerRadius=2;
    [_focusBtn setTitleColor:KSYCOLOR(92, 222, 231) forState:UIControlStateNormal];
    _focusBtn.layer.borderColor=[KSYCOLOR(92, 222, 231)CGColor];
    _focusBtn.layer.borderWidth = 0.5;

    
    //个人签名
    CGFloat signatureX=hostNameX;
    CGFloat signatureY=CGRectGetMaxY(_hostLevel.frame)+SPACING;
    CGFloat signatureWidth=self.frame.size.width-CGRectGetMaxY(_hostLevel.frame)-2*SPACING;
    CGSize signatureSize=[model2.signature boundingRectWithSize:CGSizeMake(signatureWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SIGNATUREFONT]} context:nil].size;
    CGRect signatureRect=CGRectMake(signatureX, signatureY, signatureSize.width, signatureSize.height);
    _signature.text=model2.signature;
    _signature.frame=signatureRect;
                         
    
    //添加下划线
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_focusBtn.frame)+SPACING, self.frame.size.width, 1)];
    label.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:label];
    
    
    
    //添加直播名称
    CGFloat studioNameX=hostImageViewX;
    CGFloat studioNameY=CGRectGetMaxY(label.frame)+SPACING;
    CGRect studioNameRect=CGRectMake(studioNameX, studioNameY, 100, 30);
    _studioName.frame=studioNameRect;
    _studioName.text=@"直播名称";
    
    //创建时间
    CGFloat createtimeX=studioNameX;
    CGFloat createtimeY=CGRectGetMaxY(_studioName.frame)+SPACING;
    CGRect createtimeRect=CGRectMake(createtimeX, createtimeY, 80, 30);
    UILabel *createTime=[[UILabel alloc]initWithFrame:createtimeRect];
    createTime.text=@"创建时间";
    [self addSubview:createTime];
    
    //时间
    CGFloat timeX=CGRectGetMaxX(createTime.frame)+SPACING;
    CGFloat timeY=createtimeY;
    CGRect timeRect=CGRectMake(timeX, timeY, self.frame.size.width-timeX-10, 30);
    _time.frame=timeRect;
    _time.text=model2.time;
    
    //直播次数
    CGFloat timesX=studioNameX;
    CGFloat timesY=CGRectGetMaxY(createTime.frame)+SPACING;
    CGRect timesRect=CGRectMake(timesX, timesY, 80, 30);
    UILabel *Times=[[UILabel alloc]initWithFrame:timesRect];
    [self addSubview:Times];
    Times.text=@"直播次数";
    
    //时间
    CGFloat playtimesX=timeX;
    CGFloat playtimesY=timesY;
    CGRect playtimesRec=CGRectMake(playtimesX, playtimesY, 100, 30);
    _playtimes.frame=playtimesRec;
    _playtimes.text=model2.playtimes;
    
    
    //内容简介
    CGFloat ctentX=studioNameX;
    CGFloat ctentY=CGRectGetMaxY(Times.frame)+SPACING;
    CGRect ctentRect=CGRectMake(ctentX, ctentY, 80, 30);
    UILabel *ctent=[[UILabel alloc]initWithFrame:ctentRect];
    [self addSubview:ctent];
    ctent.text=@"内容简介";
    
    //时间
    CGFloat contentX=timeX;
    CGFloat contentY=ctentY-5;
    CGFloat contentWidth=self.frame.size.width-contentX-20;
    CGSize contentSize=[model2.content boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:HOSTLEVELFONT]} context:nil].size;
    CGRect contentRec=CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    _content.frame=contentRec;
    _content.text=model2.content;

    _height=CGRectGetMaxY(_content.frame)+SPACING;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
