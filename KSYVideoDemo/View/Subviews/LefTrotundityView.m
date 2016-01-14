//
//  LefTrotundityView.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 16/1/6.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "LefTrotundityView.h"

@implementation LefTrotundityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        leftView = [[UIView alloc] init];
        leftView.backgroundColor = [UIColor blueColor];

        [self addSubview:leftView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(frame.size.height/3.0, 0, frame.size.width, frame.size.height)];
    leftView.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
    leftView.layer.cornerRadius = leftView.frame.size.width / 2;
    leftView.clipsToBounds = YES;

}
@end
