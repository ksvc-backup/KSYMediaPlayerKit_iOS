//
//  KSYDetailModel.m
//  KSYVideoDemo
//
//  Created by KSC on 15/12/30.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYDetailModel.h"

@implementation KSYDetailModel

- (KSYDetailModel *)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        self.hostImageProf=dict[@"hostImageProf"];
        self.hostName=dict[@"hostName"];
        self.hostLevel=dict[@"hostLevel"];
        self.fansCount=dict[@"fansCount"];
        self.signature=dict[@"signature"];
        self.studioName=dict[@"studioName"];
        self.time=dict[@"time"];
        self.playtimes=dict[@"playtimes"];
        self.content=dict[@"content"];
    }
    return self;
}

+ (KSYDetailModel *)modelWithDictionary:(NSDictionary *)dict
{
    KSYDetailModel *model2=[[KSYDetailModel alloc]initWithDictionary:dict];
    return model2;
}
@end
