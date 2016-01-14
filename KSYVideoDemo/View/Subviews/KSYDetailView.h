//
//  KSYDetailView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/23.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  MVC 设计模式 M：模型 V：视图 C：控制器

#import <UIKit/UIKit.h>



@interface KSYDetailView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) NSMutableArray *modelsCells;
@property (nonatomic, strong) UISegmentedControl *kSegmentedCTL;
@property (nonatomic, strong) UITableView * kTableView;

@end
