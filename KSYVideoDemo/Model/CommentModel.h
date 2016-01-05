//
//  CommentModel.h
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/9.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommentModel : NSObject
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *userHead;
@property (nonatomic, copy)NSString *userComment;
@property (nonatomic, strong)UIColor *backColor;
@property (nonatomic, assign)BOOL isShoudDele;

//临时成员
@property (nonatomic, strong)UIColor *headColor;
@end
