//
//  KSYCommentCell.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/8.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYCommentCell.h"

@interface KSYCommentCell ()
{
    UIView  *_backGroundView;
    UIView  *_leftView;
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
        [self.contentView addSubview:_backGroundView];
        
        _leftView = [[UIView alloc] init];
        _leftView.alpha = 0.5;

        [self.contentView addSubview:_leftView];

        _headImv = [[UIImageView alloc] init];
        _headImv.layer.cornerRadius = 17.5;
        _headImv.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImv];
        
        _contentLab = [[UILabel alloc ] init];
        _contentLab.backgroundColor = [UIColor clearColor];
        _contentLab.textColor = [UIColor whiteColor];
        _contentLab.font = [UIFont systemFontOfSize:13.0];
        [_backGroundView addSubview:_contentLab];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.userModel isKindOfClass:[CommentModel class]]) {
        if (self.userModel.userName != nil) {
            _headImv.frame = CGRectZero;
            _contentLab.frame = CGRectMake(_headImv.right+5, 0, 90, 25);
            _backGroundView.frame = CGRectMake(5, 5, 150, 25);

            
        }else {
            _leftView.frame = CGRectMake(5, 5, 39, 39);
            _leftView.layer.cornerRadius = _leftView.frame.size.width / 2;
            _leftView.clipsToBounds = YES;

            _backGroundView.frame = CGRectMake(5+22, 5, 150, 39);

            _contentLab.frame = CGRectMake(_headImv.right+5, 0, 90, 39);

            _headImv.frame = CGRectMake(8, 7, 35, 35);

        }
    }else {
        _backGroundView.frame = CGRectMake(5, 5, 150, 39);

        _contentLab.frame = CGRectMake(_headImv.right+5, 0, 90, 39);

        _headImv.frame = CGRectMake(3, 2, 35, 35);

    }

    
}

- (void)setUserModel:(id)userModel
{
    _userModel = userModel;
    if ([userModel isKindOfClass:[CommentModel class]]) {
        CommentModel *model = userModel;

        _backGroundView.backgroundColor = [UIColor blackColor];
//        _leftView.backgroundColor = [UIColor blackColor];
        
         CAGradientLayer *_gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
        _gradientLayer.bounds = _leftView.bounds;
        _gradientLayer.borderWidth = 0;
        
        _gradientLayer.frame = _leftView.bounds;
        _gradientLayer.colors = [NSArray arrayWithObjects:
                                 (id)[[UIColor clearColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor], nil, nil];
        _gradientLayer.startPoint = CGPointMake(0.6, 0.5);
        _gradientLayer.endPoint = CGPointMake(0.2, 0.5);
        
        [_leftView.layer insertSublayer:_gradientLayer atIndex:0];

        
        
        [_headImv sd_setImageWithURL:[NSURL URLWithString:_userModel.userHead] placeholderImage:[UIImage imageNamed:@"live_head"]];
        if (model.userComment) {
            _contentLab.text = model.userComment;

        }else {
            _contentLab.text = [NSString stringWithFormat:@"%@  来了",model.userName];
        }

    }else {
        _backGroundView.backgroundColor = [UIColor clearColor];
        _leftView.backgroundColor = [UIColor clearColor];
        _headImv.backgroundColor = [UIColor clearColor];
        _contentLab.text = @"";
    }
}

@end
