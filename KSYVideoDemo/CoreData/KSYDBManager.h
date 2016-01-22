//
//  KSYDBManager.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/13.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KSYDBManager : NSObject

singleton_interface(KSYDBManager);

#pragma mark - 属性
#pragma mark 数据库引用，使用它进行数据库操作
@property (nonatomic) NSManagedObjectContext *context;

#pragma mark - 共有方法
/**
 *  打开数据库
 *
 *  @param dbname 数据库名称
 */
- (NSManagedObjectContext *)createDbContext;

@end
