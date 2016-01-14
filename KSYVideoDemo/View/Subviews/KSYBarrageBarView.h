//
//  KSYBarrageBarView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/12.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KSYBarrageView.h"
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]
#define font [UIFont systemFontOfSize:15]
@interface KSYBarrageBarView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

- (void)start;
- (void)stop;
@end
