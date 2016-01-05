//
//  VideoViewController.h
//  KS3PlayerDemo
//
//  Created by Blues on 15/3/18.
//  Copyright (c) 2015年 KSY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController {
    
    BOOL _pauseInBackground;
}

@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic) BOOL isFullScreen;
@property (nonatomic, assign) BOOL isCycleplay;
@property (nonatomic,assign) NSUInteger motionInterfaceOrientation;
@property (readonly)            BOOL fullScreenModeToggled;
@property (nonatomic,assign)UIDeviceOrientation beforeOrientation;
@property (nonatomic,assign)UIDeviceOrientation deviceOrientation;

//- (void)setFullscreen:(BOOL)isFullscreen;
- (void)launchFullScreen;
- (void)minimizeVideo;
@end
