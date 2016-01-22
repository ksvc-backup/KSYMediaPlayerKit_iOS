//
//  KSBarrageItemView.h
//  KwSing
//
//  Created by yuchenghai on 14/12/24.
//  Copyright (c) 2014年 kuwo.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSBarrageItemView : UIView

@property (strong, nonatomic) UIImageView *avatarView;

@property (assign, nonatomic) NSInteger itemIndex;

@property (nonatomic, strong) UILabel *contentLabel;


//- (void)setAvatarUrl:(NSString *)imageUrl withContent:(NSString *)content;
- (void)KSBarrageItemViewsetDanmuFont:(CGFloat)font;
- (void)KSBarrageItemViewsetDanmuAlpha:(CGFloat)alpha;
- (void)setAvatarWithImage:(UIImage *)image withContent:(NSString *)content;
- (void)setAvatarWithImageString:(NSString *)imageStr withContent:(NSString *)content;

@end
