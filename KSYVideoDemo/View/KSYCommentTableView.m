//
//  KSYCommentTableView.m
//  KSYVideoDemo
//
//  Created by 崔崔 on 15/12/8.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYCommentTableView.h"
#import "KSYCommentCell.h"
#import "CommentModel.h"
@interface KSYCommentTableView ()
{
    NSMutableArray  *_commentArray;
    UITableView     *_tableView;
}
@end

@implementation KSYCommentTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _commentArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 7; i++) {
            [_commentArray addObject:@""];
        }
        self.backgroundColor = [UIColor clearColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
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
        _commentArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < 7; i++) {
            [_commentArray addObject:@""];
        }
        self.backgroundColor = [UIColor clearColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_tableView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id model = _commentArray[indexPath.row];
    if ([model isKindOfClass:[CommentModel class]]) {
        CommentModel *userModel = (CommentModel *)model;
        if (userModel.userName != nil) {
            return 35;
        }
    }
    return 50;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"identifer";
    KSYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[KSYCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.userModel = [_commentArray objectAtIndex:indexPath.row];

    return cell;
}

- (void)newUserAdd:(id)object
{
    
//    int i = 0;
    //一个cell刷新
//    if (_commentArray.count > 15) {
//        
//        [_commentArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 1)]];
//        i = 3;
//        
//    }

    [_commentArray addObject:object];

    
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_commentArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

//- (void)delleteObj:(id)object
//{
//
////    [self performSelector:@selector(test:) withObject:object afterDelay:4];
//}
//
//- (void)test:(CommentModel *)obj
//{
//
//    [_commentArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0]];
//    [_tableView reloadData];
//    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_commentArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//
////    NSInteger i = [_commentArray indexOfObject:obj];
////    [_commentArray removeObject:obj];
////    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
////    [_commentArray insertObject:@"" atIndex:i];
////
////    [_tableView reloadData];
//}
@end
