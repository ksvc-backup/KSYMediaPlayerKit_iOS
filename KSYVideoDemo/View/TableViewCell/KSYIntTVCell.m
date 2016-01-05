//
//  KSYIntTVCell.m
//  AMZVideoDemo
//
//  Created by 孙健 on 15/12/14.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYIntTVCell.h"
#define SPACING 10
#define BIGFONT 22
#define SMALLFONT 20
@interface KSYIntTVCell ()
{
    UIImageView *imageView;
    UILabel *videoName;
    UILabel *time;
    UILabel *customerCount;
    UILabel *content;
}

@end



@implementation KSYIntTVCell

#pragma mark 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}

#pragma mark 初始化视图
- (void)initSubviews
{
    //图片
    imageView=[[UIImageView alloc]init];
    [self addSubview:imageView];
    //直播名称
    videoName=[[UILabel alloc]init];
    [self addSubview:videoName];
    videoName.font=[UIFont systemFontOfSize:BIGFONT];
    //时间
    time=[[UILabel alloc]init];
    [self addSubview:time];
    time.font=[UIFont systemFontOfSize:SMALLFONT];
    //正在观看人数
    customerCount=[[UILabel alloc]init];
    [self addSubview:customerCount];
    customerCount.font=[UIFont systemFontOfSize:SMALLFONT];
    //内容
    content=[[UILabel alloc]init];
    [self addSubview:content];
    content.font=[UIFont systemFontOfSize:SMALLFONT];
    content.numberOfLines=0;
}

#pragma mark 设置模型 set方法 get方法
- (void)setModel3:(KSYIntroduceModel *)model3
{
    //重置图片视图的大小
    CGFloat imageViewX=15,imageViewY=15;
    CGFloat imageViewWidth=100;
    CGFloat imageViewHeight=80;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    UIImage *image=[UIImage imageNamed:model3.imageName];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.image=image;
    //设置直播名称
    CGFloat videoNameX=CGRectGetMaxX(imageView.frame)+SPACING;
    CGFloat videoNameY=imageViewY;
    CGSize videoSize=[model3.videoName sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:BIGFONT]}];
    videoName.frame=CGRectMake(videoNameX, videoNameY, videoSize.width, videoSize.height);
    videoName.text=model3.videoName;
    //设置时间
    CGFloat timeX=videoNameX;
    CGFloat timeY=CGRectGetMaxY(videoName.frame)+SPACING;
    CGSize timeSize=[model3.time sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SMALLFONT]}];
    time.frame=CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    time.text=model3.time;
    //设置在观看人数
    CGFloat customerCountX=timeX;
    CGFloat customerCountY=CGRectGetMaxY(time.frame)+SPACING;
    CGSize customerCountSize=[model3.customerCount sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SMALLFONT]}];
    customerCount.frame=CGRectMake(customerCountX, customerCountY, customerCountSize.width, customerCountSize.height);
    customerCount.text=model3.customerCount;
    
    //内容简介
    CGFloat contentX=timeX;
    CGFloat contentY=CGRectGetMaxY(customerCount.frame)+SPACING;
    CGFloat contentWidth=CGRectGetWidth(self.frame)-timeX-SPACING;
    CGSize contentSize=[model3.content boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SMALLFONT]} context:nil].size;
    content.frame=CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    content.text=model3.content;
    
    
    
    self.height=CGRectGetMaxY(content.frame)+SPACING;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
