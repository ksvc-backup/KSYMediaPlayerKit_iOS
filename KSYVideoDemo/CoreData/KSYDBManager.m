//
//  KSYDBManager.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/13.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYDBManager.h"



@implementation KSYDBManager

singleton_implementation(KSYDBManager)

-(instancetype)init{
    KSYDBManager *manager;
    if ((manager=[super init])) {
        _context=[manager createDbContext];
    }
    return manager;
}
-(NSManagedObjectContext *)createDbContext{
    NSManagedObjectContext *context;
    //打开模型文件，参数为nil则打开包中所有文件并合并成一个
    NSManagedObjectModel *model=[NSManagedObjectModel mergedModelFromBundles:nil];
    //创建解析器
    NSPersistentStoreCoordinator *storeCoordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //创建数据库保存路径
    NSString *dir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path=[dir stringByAppendingPathComponent:@"myDatabase.db"];
    NSURL *url=[NSURL fileURLWithPath:path];
    
    //添加SQLite持久存储到解析器
    NSError *error;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (error) {
        NSLog(@"数据打开失败，错误原因%@",error.localizedDescription);
    }else{
        context=[[NSManagedObjectContext alloc]init];
        context.persistentStoreCoordinator=storeCoordinator;
        NSLog(@"数据打开成功");
    }
    return context;
}
@end
