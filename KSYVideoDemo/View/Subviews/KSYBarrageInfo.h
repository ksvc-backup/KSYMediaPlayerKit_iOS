//
//  KSYBarrageInfo.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/12.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KSYBarrage;
@interface KSYBarrageInfo : NSObject
@property (nonatomic, weak) UILabel *playLabel;
@property (nonatomic, assign) NSTimeInterval leftTime;
@property (nonatomic, strong) KSYBarrage *barrage;
@property (nonatomic, assign) NSInteger lineCount;
@end
