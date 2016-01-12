//
//  KSYEpisodeView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/11.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYEpisodeView.h"

@interface KSYEpisodeView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_episodeTableView;
    
    NSMutableArray *tableArray;
    
}
@end


@implementation KSYEpisodeView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        
        tableArray=[NSMutableArray new];
        
        _episodeTableView=[[UITableView alloc]initWithFrame:self.bounds];
        _episodeTableView.backgroundColor=[UIColor clearColor];
        [self addSubview:_episodeTableView];
        _episodeTableView.delegate=self;
        _episodeTableView.dataSource=self;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identify=@"identify";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identify];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identify];
        cell.backgroundColor=[UIColor clearColor];
        UIView *tempView=[[UIView alloc]initWithFrame:cell.frame];
        tempView.backgroundColor=[UIColor blackColor];
        tempView.alpha=0.7;
        cell.backgroundView=tempView;
    }
    cell.textLabel.text=@"芈月传";
    cell.textLabel.textColor=[UIColor whiteColor];
    return cell;
}

@end
