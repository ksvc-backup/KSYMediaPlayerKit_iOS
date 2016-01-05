//
//  KSYSpectatorsTableView.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/9.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  观众列表

#import <UIKit/UIKit.h>
@interface KSYSpectatorsTableView : UIView<UITableViewDataSource,UITableViewDelegate>

//观众的数组
@property (nonatomic, strong)NSArray *spectatorsArray;
@property (nonatomic, copy)void (^specTatorsInfoBlock)(id obj);
@end
