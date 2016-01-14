//
//  KSYCommentService.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/13.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYCommentService.h"
#import "KSYDBManager.h"
#import "CoreDataModel.h"

@implementation KSYCommentService
singleton_implementation(KSYCommentService)

- (NSManagedObjectContext *)context{
    return [KSYDBManager sharedKSYDBManager].context;
}
- (void)addCoreDataModelWithImageName:(NSString *)imageName UserName:(NSString *)userName Time:(NSDate *)date Content:(NSString *)content{
    CoreDataModel *coreDate=[NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.context];
    coreDate.imageName=imageName;
    coreDate.userName=userName;
//    coreDate.time=date;
    coreDate.content=content;
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误，错误原因%@!",error.localizedDescription);
    }
}
-(NSArray *)getAllCoreDataModel{
    NSError *error;
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Comment"];
    NSArray *array=[self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"查询过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
    return  array;
}
@end
