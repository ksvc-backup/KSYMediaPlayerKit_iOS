//
//  KSYCommentService.h
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/13.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class CoreDataModel;

@interface KSYCommentService : NSObject

singleton_interface(KSYCommentService)

@property (nonatomic, strong) NSManagedObjectContext *context;
//添加数据
- (void)addCoreDataModelWithImageName:(NSString *)imageName UserName:(NSString *)userName Time:(NSDate *)date Content:(NSString *)content;
//删除数据
- (void)removeCoreDateModel:(CoreDataModel *)coreDataModel;
//修改数据
- (void)modifyCoreDataModel:(CoreDataModel *)coreDataModel;
//根据名字得到数据
- (CoreDataModel *)getCoreDataModelByName:(NSString *)userName;
//得到所有的数据
- (NSArray *)getAllCoreDataModel;
@end
