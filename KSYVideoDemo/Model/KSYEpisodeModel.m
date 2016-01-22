//
//  SKYEpisodeModel.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/13.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYEpisodeModel.h"

@implementation KSYEpisodeModel 
+(KSYEpisodeModel *)initWithDictionary:(NSDictionary *)dict{
    KSYEpisodeModel *episodeModel=[[KSYEpisodeModel alloc]initWithDictionary:dict];
    return episodeModel;
}
-(KSYEpisodeModel *)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.url=dict[@"url"];
    }
    return self;
}
@end
