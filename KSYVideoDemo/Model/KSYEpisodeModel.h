//
//  SKYEpisodeModel.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/13.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSYEpisodeModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;

+(KSYEpisodeModel *)initWithDictionary:(NSDictionary *)dict;
-(KSYEpisodeModel *)initWithDictionary:(NSDictionary *)dict;

@end
