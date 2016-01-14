//
//  KSYThemeManager.h
//  KSYVideoDemo
//
//  Created by Blues on 15/5/25.
//  Copyright (c) 2015年 kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KSYThemeManager : NSObject

+ (KSYThemeManager *)sharedInstance;
- (NSString *)changeTheme:(NSString *)themeName;
- (UIImage *)imageInCurThemeWithName:(NSString *)strName;
- (void)setStrResourcePath:(NSString *)strResourcePath;
- (UIColor *)themeColor;

@end
