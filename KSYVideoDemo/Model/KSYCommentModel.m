//
//  KSYCommentModel.m
//  KSYVideoDemo
//
//  Created by KSC on 15/12/30.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYCommentModel.h"

@implementation KSYCommentModel

- (KSYCommentModel *)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        self.imageName=dict[@"imageName"];
        self.userName=dict[@"userName"];
        self.time=dict[@"time"];
        self.content=dict[@"content"];
    }
    return self;
}

+ (KSYCommentModel *)modelWithDictionary:(NSDictionary *)dict
{
    KSYCommentModel *model=[[KSYCommentModel alloc]initWithDictionary:dict];
    return model;
}

@end
