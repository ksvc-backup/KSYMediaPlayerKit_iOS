//
//  KSYBarrage.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/12.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSYBarrage : NSObject
//对应视屏时间的时间戳
@property (nonatomic, assign) NSTimeInterval timePoint;
//弹幕内容
@property (nonatomic, copy) NSAttributedString *contentStr;
//弹幕类型
@property (nonatomic, assign) NSInteger position;
@end
