//
//  KSYSpectatorsTableView.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/9.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYSpectatorsTableView.h"
#import "KSYSpectatorsCell.h"

@interface KSYSpectatorsTableView ()
{

    UITableView     *_tableView;
}

@end
@implementation KSYSpectatorsTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

        self.backgroundColor = [UIColor clearColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 40, self.frame.size.width)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_tableView];

    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        

        self.backgroundColor = [UIColor clearColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 40, self.frame.size.width)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_tableView];
        
    }
    return self;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _spectatorsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"identifer";
    
    KSYSpectatorsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[KSYSpectatorsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.backgroundColor = [UIColor clearColor];
//    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    cell.spectatorModel = self.spectatorsArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.specTatorsInfoBlock) {
        self.specTatorsInfoBlock(self.spectatorsArray[indexPath.row]);

    }
}
@end
