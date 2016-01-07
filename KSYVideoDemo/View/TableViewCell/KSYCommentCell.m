//
//  KSYCommentCell.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/8.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYCommentCell.h"
#import "UIBezierPath+BasicShapes.h"
@interface KSYCommentCell ()
{
    UIView  *_backGroundView;
    UILabel *_userLab;
    UILabel *_contentLab;
    UIImageView *_headImv;
}
@end

@implementation KSYCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _backGroundView = [[UIView alloc] init];
        _backGroundView.alpha = 0.5;
        _backGroundView.layer.cornerRadius = 8;

        [self.contentView addSubview:_backGroundView];

        
        
        
        _headImv = [[UIImageView alloc] init];
        _headImv.layer.cornerRadius = 17.5;
        _headImv.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImv];
        
        _contentLab = [[UILabel alloc ] init];
        _contentLab.backgroundColor = [UIColor clearColor];
        _contentLab.textColor = [UIColor whiteColor];
        _contentLab.font = [UIFont systemFontOfSize:13.0];
        [_backGroundView addSubview:_contentLab];
        
        _userLab = [[UILabel alloc ] init];
        _userLab.backgroundColor = [UIColor clearColor];
        _userLab.textColor = [UIColor whiteColor];
        _userLab.font = [UIFont systemFontOfSize:13.0];
        [_backGroundView addSubview:_userLab];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.userModel isKindOfClass:[CommentModel class]]) {
//        if (self.userModel.userName != nil) {
//            _headImv.frame = CGRectZero;
//            _contentLab.frame = CGRectMake(_headImv.right+5, 0, 90, 25);
//            _backGroundView.frame = CGRectMake(5, 5, 150, 25);
//            
//            _backGroundView.layer.mask = [self getCAShapeLayerWithSize:CGSizeMake(8, 8)];
//
//            
//        }else {

            _backGroundView.frame = CGRectMake(5, 5, 150, 39);

            _userLab.frame = CGRectMake(_headImv.right+5, 4, 90, 15);
            _contentLab.frame = CGRectMake(_headImv.right+5, _userLab.bottom, 90, 20);

            _headImv.frame = CGRectMake(8, 7, 35, 35);
            
            _backGroundView.layer.mask = [self getCAShapeLayerWithSize:CGSizeMake(39, 39)];


//        }
    }else {
        _backGroundView.frame = CGRectMake(5, 5, 150, 39);

        _contentLab.frame = CGRectMake(_headImv.right+5, 0, 90, 39);

        _headImv.frame = CGRectMake(3, 2, 35, 35);


    }
    
    
}

//设置View的圆角弧度
- (CAShapeLayer *)getCAShapeLayerWithSize:(CGSize)size
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_backGroundView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    maskLayer.frame = _backGroundView.bounds;
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;

}
- (void)setUserModel:(id)userModel
{
    _userModel = userModel;
    if ([userModel isKindOfClass:[CommentModel class]]) {
        CommentModel *model = userModel;

        _backGroundView.backgroundColor = [UIColor blackColor];
        
        
        [_headImv sd_setImageWithURL:[NSURL URLWithString:_userModel.userHead] placeholderImage:[UIImage imageNamed:@"live_head"]];
        _contentLab.text = model.userComment;
        _userLab.text = model.userName;

    }else {
        _backGroundView.backgroundColor = [UIColor clearColor];
        _headImv.backgroundColor = [UIColor clearColor];
        _contentLab.text = @"";
    }
}

@end
