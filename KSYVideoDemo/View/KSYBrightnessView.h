//
//  KSYBrightnessView.h
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/25.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSYBrightnessView : UIView
@property (nonatomic ,copy) void  (^brightDidBegin)(UISlider *slider);
@property (nonatomic ,copy) void  (^brightChanged)(UISlider *slider);
@property (nonatomic ,copy) void  (^brightChangeEnd)(UISlider *slider);
@end
