//
//  KSYCommentCell.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/8.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYCommentCell.h"
#import "UIView+BFExtension.h"
@interface KSYCommentCell ()
{
    UIView  *_backGroundView;
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
        [self.contentView addSubview:_backGroundView];
        
        _headImv = [[UIImageView alloc] init];
        _headImv.layer.cornerRadius = 17.5;
        _headImv.layer.masksToBounds = YES;
        [_backGroundView addSubview:_headImv];
        
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
            _backGroundView.frame = CGRectMake(5, 5, 150, 39);

            _contentLab.frame = CGRectMake(_headImv.right+5, 0, 90, 39);

            _headImv.frame = CGRectMake(3, 2, 35, 35);

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

        _backGroundView.backgroundColor = model.backColor;
        _headImv.backgroundColor = model.headColor;
        if (model.userComment) {
            _contentLab.text = model.userComment;

        }else {
            _contentLab.text = [NSString stringWithFormat:@"%@  来了",model.userName];
        }

    }else {
        _backGroundView.backgroundColor = [UIColor clearColor];
        _headImv.backgroundColor = [UIColor clearColor];
        _contentLab.text = @"";
    }
}

@end
