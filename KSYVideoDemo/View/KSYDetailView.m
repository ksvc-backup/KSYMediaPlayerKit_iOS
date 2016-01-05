//
//  KSYDetailView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/23.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYDetailView.h"

@implementation KSYDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self){
        [self addBellowPart];
    }
    return self;
}

- (void)addBellowPart{

    self.backgroundColor=[UIColor whiteColor];
    //初始化分段控制器
    NSArray *segmentedArray=[NSArray arrayWithObjects:@"评论",@"详情",@"推荐", nil];
    self.kSegmentedCTL=[[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.kSegmentedCTL.frame=CGRectMake(10, 10, THESCREENWIDTH-20, 30);
    [self addSubview:self.kSegmentedCTL];
    [self.kSegmentedCTL addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    self.kSegmentedCTL.selectedSegmentIndex=0;
    //添加一个分割线
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.kSegmentedCTL.frame)+10, THESCREENWIDTH, 1)];
    lineLabel.backgroundColor=[UIColor blackColor];
    [self addSubview:lineLabel];
    //初始化表视图 只要你在做你就在想
    _kTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineLabel.frame)+10, THESCREENWIDTH, THESCREENHEIGHT/2-72) style:UITableViewStylePlain];
    self.kTableView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.kTableView];
    self.kTableView.delegate=self;
    self.kTableView.dataSource=self;
    [self segmentChange:self.kSegmentedCTL];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.kSegmentedCTL.selectedSegmentIndex==1){
        return 1;
    }
    return   _models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kSegmentedCTL.selectedSegmentIndex==0){
        KSYComTvCell *cell=[tableView dequeueReusableCellWithIdentifier:@"KSY1TableViewCellIdentify"];
        if (cell==nil){
            cell=[[KSYComTvCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"KSY1TableViewCellIdentify"];
            UIView* tempView=[[UIView alloc] initWithFrame:cell.frame];
            tempView.backgroundColor =KSYCOLER(90, 90, 90);
            cell.backgroundView = tempView;  //更换背景色     不能直接设置backgroundColor
            UIView* tempView1=[[UIView alloc] initWithFrame:cell.frame];
            tempView1.backgroundColor = KSYCOLER(100, 100, 100);
            cell.selectedBackgroundView = tempView1;
        }
         KSYCommentModel *SKYmodel=_models[indexPath.row];
        cell.model1=SKYmodel;
        return cell;
    }
    else if (self.kSegmentedCTL.selectedSegmentIndex==1){
        KSYDetalTVCell *cell=[tableView dequeueReusableCellWithIdentifier:@"KSY2TableViewCellIdentify"];
        if (cell==nil){
            cell=[[KSYDetalTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"KSY2TableViewCellIdentify"];
        }
        KSYDetailModel *SKYmodel=_models[indexPath.row];
        cell.model2=SKYmodel;//调用set方法
        return cell;
        
    }
    else if (self.kSegmentedCTL.selectedSegmentIndex==2){
        KSYIntTVCell *cell=[tableView dequeueReusableCellWithIdentifier:@"KSY3TableViewCellIdentify"];
        if (cell==nil){
            cell=[[KSYIntTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"KSY3TableViewCellIdentify"];
        }
        KSYIntroduceModel *SKYmodel=_models[indexPath.row];
        cell.model3=SKYmodel;//调用set方法
        return cell;
    }
    else
        return nil;
}
#pragma mark tableViewDelegate 表视图代理方法
#pragma mark 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kSegmentedCTL.selectedSegmentIndex==0){
        KSYComTvCell *cell=_modelsCells[indexPath.row];
        cell.model1=_models[indexPath.row];//这里执行set方法
        return cell.height;
    }
    else if (self.kSegmentedCTL.selectedSegmentIndex==1){
        KSYDetalTVCell *cell=_modelsCells[indexPath.row];
        cell.model2=_models[indexPath.row];//这里执行set方法
        return cell.height;
    }
    else if (self.kSegmentedCTL.selectedSegmentIndex==2){
        KSYIntTVCell *cell=_modelsCells[indexPath.row];
        cell.model3=_models[indexPath.row];//这里执行set方法
        return cell.height;
        
    }
    else
        return 0;
}

- (void)segmentChange:(UISegmentedControl *)segment{
    //如果是评论，加载评论的数据
    if(segment.selectedSegmentIndex==0){
        //每次进来都要重新刷新数据
        [_models removeAllObjects];
        [_modelsCells removeAllObjects];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Model1" ofType:@"plist"];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        _models=[[NSMutableArray alloc]init];
        _modelsCells=[[NSMutableArray alloc]init];
        //利用代码块遍历
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_models addObject:[KSYCommentModel modelWithDictionary:obj]];
            KSYComTvCell *cell=[[KSYComTvCell alloc]init];
            [_modelsCells addObject:cell];
        }];
        [self.kTableView reloadData];
    }
    //如果是详情，获取详情的数据
    else if(segment.selectedSegmentIndex==1){
        //根据路径获得字典
        [_models removeAllObjects];
        [_modelsCells removeAllObjects];
        NSString *path=[[NSBundle mainBundle]pathForResource:@"Model2" ofType:@"plist"];
        NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:path];
        [_models addObject:[KSYDetailModel modelWithDictionary:dict]];
        KSYDetalTVCell *cell=[[KSYDetalTVCell alloc]init];
        [_modelsCells addObject:cell];
        //这样做复杂啦换一种方法
        
        [self.kTableView reloadData];
        
    }
    //如果是推荐，获取推荐的数据
    else if(segment.selectedSegmentIndex==2){
        [_models removeAllObjects];
        [_modelsCells removeAllObjects];
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Model3" ofType:@"plist"];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        _models=[[NSMutableArray alloc]init];
        _modelsCells=[[NSMutableArray alloc]init];
        //利用代码块遍历
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_models addObject:[KSYIntroduceModel modelWithDictionary:obj]];
            KSYIntTVCell *cell=[[KSYIntTVCell alloc]init];
            [_modelsCells addObject:cell];
        }];
        [self.kTableView reloadData];
        
    }
}

@end
