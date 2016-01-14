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
// imageName;
// userName;
// time;
// content;

- (void)addCoreDataModelWithImageName:(NSString *)imageName UserName:(NSString *)userName  Time:(NSDate *)date Content:(NSString *)content;
- (NSArray *)getAllCoreDataModel;
@end
