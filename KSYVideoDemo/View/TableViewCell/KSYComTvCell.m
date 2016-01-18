//
//  KSYComTvCell.m
//  AMZVideoDemo
//
//  Created by 孙健 on 15/12/8.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYComTvCell.h"
#define USERNAMEFONT 18
#define TIMEFONT 16
#define CONTENTFONT 16
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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
    _time.textColor=[UIColor lightGrayColor];;
    _time.textAlignment=NSTextAlignmentRight;
    [self addSubview:_time];
    _time.font=[UIFont systemFontOfSize:TIMEFONT];
    //添加评论
    _content=[[UILabel alloc]init];
    [self addSubview:_content];
    _content.font=[UIFont systemFontOfSize:CONTENTFONT];
    _content.textColor=[UIColor lightGrayColor];
    //因为评论可能有很多需要多行显示
    _content.numberOfLines=0;
}
#pragma mark 设置单元格内容
- (void)setCommentModel:(CoreDataModel *)model
{
    //设置用户名的位置
    //设置头像的位置
    CGFloat imageViewX=15,imageViewY=15;
    CGFloat imageViewWidth=60;
    CGFloat imageViewHeight=60;
    CGRect imageViewRect=CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    _imageView.frame=imageViewRect;
    _imageView.layer.masksToBounds=YES;
    _imageView.layer.cornerRadius=30;
    UIImage *image=[UIImage imageNamed:model.imageName];
    _imageView.image=image;
    //设置起始位置
    CGFloat userNameX=CGRectGetMaxX(_imageView.frame)+SPACING;
    CGFloat userNameY=imageViewY-10;
    CGSize userNamesize=[model.userName sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:USERNAMEFONT]}];
    CGRect userNamerect=CGRectMake(userNameX, userNameY, userNamesize.width, userNamesize.height);
    _userName.text=model.userName;
    _userName.frame=userNamerect;
    //设置时间的位置
    CGFloat timeX=THESCREENWIDTH-100;
    CGFloat timeY=userNameY;
    CGRect timeRect=CGRectMake(timeX, timeY+5, 85, 20);
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"HH:mm";
    NSString *datestr=[dateFormatter stringFromDate:model.time];
    _time.text=datestr;
    _time.frame=timeRect;
    //设置评论的位置
    CGFloat contextX=userNameX;
    CGFloat contentY=CGRectGetMaxY(_userName.frame)+5;
    CGFloat contentWidth=THESCREENWIDTH-20-_imageView.right;
    CGSize contentSize=[model.content boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:CONTENTFONT]} context:nil].size;
    CGRect contenRect=CGRectMake(contextX, contentY, contentSize.width, contentSize.height);
    _content.text=model.content;
    _content.frame=contenRect;
    
    
    if ((int)_imageView.bottom>(int)_content.bottom) {
        _height=_imageView.bottom+10;
    }else{
        _height=_content.bottom+5;
    }
}

#pragma mark 设置单元格内容
- (void)setModel1:(KSYCommentModel *)model1
{
    //设置用户名的位置
    //设置头像的位置
    CGFloat imageViewX=15,imageViewY=15;
    CGFloat imageViewWidth=60;
    CGFloat imageViewHeight=60;
    CGRect imageViewRect=CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    _imageView.frame=imageViewRect;
    _imageView.layer.masksToBounds=YES;
    _imageView.layer.cornerRadius=30;
    UIImage *image=[UIImage imageNamed:model1.imageName];
    _imageView.image=image;
    //设置起始位置
    CGFloat userNameX=CGRectGetMaxX(_imageView.frame)+SPACING;
    CGFloat userNameY=imageViewY-10;
    CGSize userNamesize=[model1.userName sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:USERNAMEFONT]}];
    CGRect userNamerect=CGRectMake(userNameX, userNameY, userNamesize.width, userNamesize.height);
    _userName.text=model1.userName;
    _userName.frame=userNamerect;
    //设置时间的位置
    CGFloat timeX=THESCREENWIDTH-100;
    CGFloat timeY=userNameY;
    CGRect timeRect=CGRectMake(timeX, timeY+5, 85, 20);
    _time.text=model1.time;
    _time.frame=timeRect;
    //设置评论的位置
    CGFloat contextX=userNameX;
    CGFloat contentY=CGRectGetMaxY(_userName.frame)+5;
    CGFloat contentWidth=THESCREENWIDTH-10-CGRectGetMaxX(_imageView.frame);
    CGSize contentSize=[model1.content boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:CONTENTFONT]} context:nil].size;
    CGRect contenRect=CGRectMake(contextX, contentY, contentSize.width, contentSize.height);
    _content.text=model1.content;
    _content.frame=contenRect;
    
    
    //判断一下
    if (_imageView.bottom>_content.bottom) {
        _height = _imageView.bottom+5;
    }else{
        _height=_content.bottom+5;
    }
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
