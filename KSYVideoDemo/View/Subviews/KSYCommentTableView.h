//
//  KSYCommentTableView.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/8.
//  Copyright © 2015年 kingsoft. All rights reserved.
//  用户评论列表

#import <UIKit/UIKit.h>

@interface KSYCommentTableView : UIView<UITableViewDataSource,UITableViewDelegate>

- (void)newUserAdd:(id)object;
@end
