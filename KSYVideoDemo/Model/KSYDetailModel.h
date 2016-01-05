//
//  KSYDetailModel.h
//  KSYVideoDemo
//
//  Created by KSC on 15/12/30.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSYDetailModel : NSObject


@property (nonatomic, copy) NSString *hostImageProf;
@property (nonatomic, copy) NSString *hostName;
@property (nonatomic, copy) NSString *hostLevel;
@property (nonatomic, copy) NSString *fansCount;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *studioName;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *playtimes;
@property (nonatomic, copy) NSString *content;


- (KSYDetailModel *)initWithDictionary:(NSDictionary *)dict;

+ (KSYDetailModel *)modelWithDictionary:(NSDictionary *)dict;

@end
