//
//  KSYShortTabelViewCell.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/28.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSYBasePlayView.h"

@interface KSYShortTabelViewCell :UITableViewCell



@property (nonatomic,strong) KSYBasePlayView *ksyShortView;



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier urlstr:(NSString *)urlstring frame:(CGRect)frame;

@property (nonatomic, assign) BOOL isReleased;


@end
