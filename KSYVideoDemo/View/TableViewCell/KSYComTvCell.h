//
//  KSYComTvCell.h
//  AMZVideoDemo
//
//  Created by 孙健 on 15/12/8.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSYCommentModel.h"
#import "CoreDataModel.h"
@interface KSYComTvCell : UITableViewCell


@property (nonatomic, strong) CoreDataModel *commentModel;
//状态属性
@property (nonatomic, strong) KSYCommentModel *model1;
//高度属性
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie;

@end
