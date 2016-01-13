//
//  KSYEpisodeView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/11.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYEpisodeView.h"
#import "KSYEpisodeModel.h"
@interface KSYEpisodeView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_episodeTableView;
    
    NSMutableArray *_tableArray;
    
}
@end


@implementation KSYEpisodeView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        
        _tableArray=[NSMutableArray new];
        
        _episodeTableView=[[UITableView alloc]initWithFrame:self.bounds];
        _episodeTableView.backgroundColor=[UIColor clearColor];
        [self addSubview:_episodeTableView];
        _episodeTableView.delegate=self;
        _episodeTableView.dataSource=self;
        [self reloadData];
    }
    return self;
}
- (void)reloadData{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"episodeModel"ofType:@"plist"];
    NSArray *array=[NSArray arrayWithContentsOfFile:path];
    
    for(NSDictionary *dict in array){
        [_tableArray addObject:dict];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableArray.count;
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
    KSYEpisodeModel *model=[[KSYEpisodeModel alloc]initWithDictionary:_tableArray[indexPath.row]];
    cell.textLabel.text=model.name;
    cell.textLabel.textColor=[UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KSYEpisodeModel *model=[[KSYEpisodeModel alloc]initWithDictionary:_tableArray[indexPath.row]];
    if (self.changeVidoe) {
        self.changeVidoe(model.url);
    }
}
@end
