//
//  KSBarrageView.h
//  KwSing
//
//  Created by yuchenghai on 14/12/22.
//  Copyright (c) 2014年 kuwo.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSBarrageView : UIView

/**
 *  dataArray's object is NSDictionary
 *  key "avatar" is NSString or UIImage or ImageUrl
 *  key "content" is NSString
 */
@property (strong, nonatomic)NSArray *dataArray;//静态数组

- (void)start;//开始
- (void)stop;//结束
- (void)setDanmuFont:(CGFloat)font;//设置弹幕字体的大小
- (void)setDanmuAlpha:(CGFloat)alpha;//设置弹幕透明度


@end
