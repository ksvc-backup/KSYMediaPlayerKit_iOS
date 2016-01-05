//
//  SpectatorModel.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/9.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  观众

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SpectatorModel : NSObject
/**
 *	@brief	用户名
 */
@property (nonatomic, copy)NSString *name;
/**
 *	@brief	头像地址
 */
@property (nonatomic, copy)NSString *headUrl;
/**
 *	@brief	观众签名内容
 */
@property (nonatomic, copy)NSString *signConent;
/**
 *	@brief	直播次数
 */
@property (nonatomic, copy)NSString *liveNumber;
/**
 *	@brief	粉丝数
 */
@property (nonatomic, copy)NSString *fansNumber;
/**
 *	@brief	关注数
 */
@property (nonatomic, copy)NSString *followNumber;
/**
 *	@brief	点赞数
 */
@property (nonatomic, copy)NSString *praiseNumber;

//临时成员，测试效果用
@property (nonatomic, strong)UIColor *headColor;
@end
