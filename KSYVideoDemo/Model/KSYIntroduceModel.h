//
//  KSYIntroduceModel.h
//  KSYVideoDemo
//
//  Created by KSC on 15/12/30.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSYIntroduceModel : NSObject


@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *videoName;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *customerCount;
@property (nonatomic, copy) NSString *content;


-(KSYIntroduceModel *)initWithDictionary:(NSDictionary *)dict;

+(KSYIntroduceModel *)modelWithDictionary:(NSDictionary *)dict;
@end
