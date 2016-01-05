//
//  KSYSpectatorsCell.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/9.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYSpectatorsCell.h"
#import "SpectatorModel.h"

@interface KSYSpectatorsCell ()
{
    UIImageView *_headImageViwe;
}

@end

@implementation KSYSpectatorsCell

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
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _headImageViwe = [[UIImageView alloc] init];
        _headImageViwe.userInteractionEnabled = YES;
        _headImageViwe.layer.cornerRadius = 17.5;
        _headImageViwe.layer.masksToBounds = YES;
        
        [self addSubview:_headImageViwe];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _headImageViwe.frame = CGRectMake(3, 5, 35, 35);
}

- (void)setSpectatorModel:(id)spectatorModel
{
    SpectatorModel *model = (SpectatorModel *)spectatorModel;
//    SpectatorModel *model = spectatorModel;
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
//    _headImageViwe.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
//    _headImageViwe.backgroundColor = model.headColor;

    _headImageViwe.backgroundColor = model.headColor;
}
@end
