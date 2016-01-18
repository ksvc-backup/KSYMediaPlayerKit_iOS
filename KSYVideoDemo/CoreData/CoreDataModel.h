//
//  CoreData.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/13.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataModel : NSManagedObject

@property (nonatomic, copy) NSString *imageName;   //图片名称
@property (nonatomic, copy) NSString *userName;    //用户名
@property (nonatomic, copy) NSDate *time;        //发布时间
@property (nonatomic, copy) NSString *content;     //评论

@end
