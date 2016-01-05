//
//  KSYCommentModel.h
//  KSYVideoDemo
//
//  Created by KSC on 15/12/30.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSYCommentModel : NSObject

@property (nonatomic, copy) NSString *imageName;   //图片名称
@property (nonatomic, copy) NSString *userName;    //用户名
@property (nonatomic, copy) NSString *time;        //发布时间
@property (nonatomic, copy) NSString *content;     //评论

-(KSYCommentModel *)initWithDictionary:(NSDictionary *)dict;

+(KSYCommentModel *)modelWithDictionary:(NSDictionary *)dict;

@end
