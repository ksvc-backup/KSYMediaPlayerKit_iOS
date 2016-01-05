//
//  KSYIntroduceModel.m
//  KSYVideoDemo
//
//  Created by KSC on 15/12/30.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYIntroduceModel.h"

@implementation KSYIntroduceModel
- (KSYIntroduceModel *)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        self.imageName=dict[@"imageName"];
        self.videoName=dict[@"videoName"];
        self.time=dict[@"time"];
        self.customerCount=dict[@"customerCount"];
        self.content=dict[@"content"];
    }
    return self;
}
+ (KSYIntroduceModel *)modelWithDictionary:(NSDictionary *)dict
{
    KSYIntroduceModel *model3=[[KSYIntroduceModel alloc]initWithDictionary:dict];
    return model3;
}
@end
