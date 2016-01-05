//
//  KSYComTvCell.m
//  AMZVideoDemo
//
//  Created by 孙健 on 15/12/8.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYComTvCell.h"
#define KSYCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define USERNAMEFONT 22
#define TIMEFONT 21
#define CONTENTFONT 20
#define SJColor(r,g,b) [UIColor colorWithHue:r/255.0 saturation:g/255.0 brightness:b/255.0 alpha:1] //颜色宏定义
#define KSYMODEL1Color [UIColor whiteColor]
#define SPACING 10


@interface KSYComTvCell()
{
    UIImageView *_imageView;
    UILabel *_userName;
    UILabel *_time;
    UILabel *_content;
    
}

@end



@implementation KSYComTvCell

#pragma mark 初始化单元格
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubViews];
    }
    return self;
}

#pragma mark 初始化视图(想要成功就是控制自己的身体)
- (void)initSubViews
{
    //这先初始化，不设置大小
    //添加头像视图
    _imageView=[[UIImageView alloc]init];
    [self addSubview:_imageView];
    //添加用户名
    _userName=[[UILabel alloc]init];
    _userName.textColor=KSYMODEL1Color;
    [self addSubview:_userName];
    _userName.font=[UIFont systemFontOfSize:USERNAMEFONT];
    //添加时间
    _time=[[UILabel alloc]init];
    _time.textColor=KSYMODEL1Color;
    [self addSubview:_time];
    _time.font=[UIFont systemFontOfSize:TIMEFONT];
    //添加评论
    _content=[[UILabel alloc]init];
    [self addSubview:_content];
    _content.font=[UIFont systemFontOfSize:CONTENTFONT];
    _content.textColor=KSYMODEL1Color;
    //因为评论可能有很多需要多行显示
    _content.numberOfLines=0;
}

#pragma mark 设置单元格内容
- (void)setModel1:(KSYCommentModel *)model1
{
    //设置用户名的位置
    //设置头像的位置
    CGFloat imageViewX=15,imageViewY=15;
    CGFloat imageViewWidth=80;
    CGFloat imageViewHeight=80;
    CGRect imageViewRect=CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    _imageView.frame=imageViewRect;
    _imageView.layer.masksToBounds=YES;
    _imageView.layer.cornerRadius=40;
    UIImage *image=[UIImage imageNamed:model1.imageName];
    _imageView.image=image;
    //设置起始位置
    CGFloat userNameX=CGRectGetMaxX(_imageView.frame)+SPACING;
    CGFloat userNameY=imageViewY;
    CGSize userNamesize=[model1.userName sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:USERNAMEFONT]}];
    CGRect userNamerect=CGRectMake(userNameX, userNameY, userNamesize.width, userNamesize.height);
    _userName.text=model1.userName;
    _userName.frame=userNamerect;
    //设置时间的位置
    CGFloat timeX=CGRectGetMaxX(_userName.frame)+SPACING;
    CGFloat timeY=userNameY;
    CGSize timeSize=[model1.time sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TIMEFONT]}];
    CGRect timeRect=CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    _time.text=model1.time;
    _time.frame=timeRect;
    //设置评论的位置
    CGFloat contextX=userNameX;
    CGFloat contentY=CGRectGetMaxY(_userName.frame)+10;
    CGFloat contentWidth=self.frame.size.width-10-CGRectGetMaxX(_imageView.frame);
    CGSize contentSize=[model1.content boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:CONTENTFONT]} context:nil].size;
    CGRect contenRect=CGRectMake(contextX, contentY, contentSize.width, contentSize.height);
    _content.text=model1.content;
    _content.frame=contenRect;
    
    _height=CGRectGetMaxY(_content.frame)+5;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
