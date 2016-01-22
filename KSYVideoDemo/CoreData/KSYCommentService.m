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
//得到上下文
- (NSManagedObjectContext *)context{
    return [KSYDBManager sharedKSYDBManager].context;
}
//添加数据
- (void)addCoreDataModelWithImageName:(NSString *)imageName UserName:(NSString *)userName Time:(NSDate *)date Content:(NSString *)content{
    CoreDataModel *coreDate=[NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.context];
    coreDate.imageName=imageName;
    coreDate.userName=userName;
    coreDate.time=date;
    coreDate.content=content;
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误，错误原因%@!",error.localizedDescription);
    }
}
- (void)addCoreDataModel:(CoreDataModel *)model{
    [self addCoreDataModelWithImageName:model.imageName UserName:model.userName Time:model.time Content:model.content];
}
//删除数据
- (void)removeCoreDateModel:(CoreDataModel *)coreDataModel{
    [self.context deleteObject:coreDataModel];
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"删除过程中发生错误，错误信息：%@!",error.localizedDescription);
    }
}
//根据用户名删除用户
- (void)removeCoreDateModelByName:(NSString *)userName{
    CoreDataModel *model=[self getCoreDataModelByName:userName];
    [self removeCoreDateModel:model];
}
//修改数据 想要修改先查询到
-(void)modifycoreDatamodelWithImageName:(NSString *)imageName UserName:(NSString *)userName Time:(NSString *)time Content:(NSString *)content{
    CoreDataModel *model=[self getCoreDataModelByName:userName];
    model.imageName = imageName;
    model.userName = userName;
    model.time = time;
    model.content = content;
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误，错误信息：%@!",error.localizedDescription);
    }
}
- (void)modifyCoreDataModel:(CoreDataModel *)coreDataModel{
    [self modifycoreDatamodelWithImageName:coreDataModel.imageName UserName:coreDataModel.userName Time:coreDataModel.time Content:coreDataModel.content];
}
//查询数据
- (CoreDataModel *)getCoreDataModelByName:(NSString *)userName{
   //实例化查询
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Comment"];
    //使用谓词查询是基于KeyPath查询的，如果健是一个变量，格式化字符串时需要使用%K而不是%@
    request.predicate = [NSPredicate predicateWithFormat:@"%K=%@",@"name",userName];
    NSError *error;
    CoreDataModel *model;
    //进行查询
    NSArray *result=[self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"查询过程中发生错误，错误信息：%@",error.localizedDescription);
    }else{
        model=[result firstObject];
    }
    return model;
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
