//
//  KSYDetailView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/23.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYDetailView.h"
#import "KSYCommentService.h"

@interface KSYDetailModel (){
    NSArray *_model;
    NSMutableArray *_modelsCells;
}

@end

@implementation KSYDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self){
        _models=[[NSMutableArray alloc]init];
        _modelsCells=[[NSMutableArray alloc]init];
        self.backgroundColor=[UIColor clearColor];
        [self addBellowPart];
    }
    return self;
}
#pragma mark 加载数据
- (void)loadData{
    //每次进来都要重新刷新数据
    [_models removeAllObjects];
    [_modelsCells removeAllObjects];
    //利用代码块遍历
    NSArray *array=[[KSYCommentService sharedKSYCommentService]getAllCoreDataModel];
    _models=[NSMutableArray arrayWithArray:array];
    [_models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KSYComTvCell *cell=[[KSYComTvCell alloc]init];
        cell.commentModel=(CoreDataModel *)obj;
        [_modelsCells addObject:cell];
    }];
}
- (void)removeAllModel{
    [_models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CoreDataModel * commentModel=(CoreDataModel *)obj;
        [[KSYCommentService sharedKSYCommentService]removeCoreDateModel:commentModel];
    }];
}
- (void)addBellowPart{
    //初始化分段控制器
    NSArray *segmentedArray=[NSArray arrayWithObjects:@"评论",@"详情",@"推荐", nil];
    self.kSegmentedCTL=[[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.kSegmentedCTL.frame=CGRectMake(10, 10, THESCREENWIDTH-20, 30);
    self.kSegmentedCTL.tintColor=THEMECOLOR;
    [self addSubview:self.kSegmentedCTL];
    [self.kSegmentedCTL addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    self.kSegmentedCTL.selectedSegmentIndex=0;
    
    //添加一个分割线
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.kSegmentedCTL.frame)+10, THESCREENWIDTH, 1)];
    lineLabel.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:lineLabel];
    
    //初始化表视图 只要你在做你就在想
    _kTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineLabel.frame), THESCREENWIDTH, THESCREENHEIGHT/2-25) style:UITableViewStylePlain];
    self.kTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.kTableView];
    self.kTableView.delegate=self;
    self.kTableView.dataSource=self;
    
    //刷新数据
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
    static NSString *commentIdentify=@"commentIdentify";
    static NSString *detailIdentify=@"detailIdentify";
    static NSString *subscribeIdentify=@"subscribeIdentify";
    if (self.kSegmentedCTL.selectedSegmentIndex==0){
        KSYComTvCell *cell=[tableView dequeueReusableCellWithIdentifier:commentIdentify];
        if (!cell){
            cell=[[KSYComTvCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:commentIdentify];
            cell.backgroundColor=[UIColor clearColor];
            UIView* tempView=[[UIView alloc] initWithFrame:cell.frame];
            tempView.backgroundColor =DEEPCOLOR;
            cell.backgroundView = tempView;  //更换背景色     不能直接设置backgroundColor
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        KSYCommentModel *SKYmodel=_models[indexPath.row];
        cell.model1=SKYmodel;
        return cell;
//        KSYCommentModel *SKYmodel=_models[indexPath.row];
//        cell.model1=SKYmodel;
//        return cell;
//        KSYComTvCell *cell=[tableView dequeueReusableCellWithIdentifier:commentIdentify];
//        if (cell==nil){
//            cell=[[KSYComTvCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:commentIdentify];
//            cell.backgroundColor=[UIColor clearColor];
//            UIView* tempView=[[UIView alloc] initWithFrame:cell.frame];
//            tempView.backgroundColor =DEEPCOLOR;
//            cell.backgroundView = tempView;  //更换背景色     不能直接设置backgroundColor
//            UIView* tempView1=[[UIView alloc] initWithFrame:cell.frame];
//            tempView1.backgroundColor = DEEPCOLOR;
//            cell.selectedBackgroundView = tempView1;
//        }
//         KSYCommentModel *SKYmodel=_models[indexPath.row];
//        cell.commentModel=_models[indexPath.row];
//        cell.userInteractionEnabled=NO;
//        return cell;
    }
    else if (self.kSegmentedCTL.selectedSegmentIndex==1){
        KSYDetalTVCell *cell=[tableView dequeueReusableCellWithIdentifier:detailIdentify];
        if (cell==nil){
            cell=[[KSYDetalTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailIdentify];
            cell.backgroundColor=[UIColor clearColor];
            UIView* tempView=[[UIView alloc] initWithFrame:cell.frame];
            tempView.backgroundColor =DEEPCOLOR;
            cell.backgroundView = tempView;  //更换背景色     不能直接设置backgroundColor
            UIView* tempView1=[[UIView alloc] initWithFrame:cell.frame];
            tempView1.backgroundColor = DEEPCOLOR;
            cell.selectedBackgroundView = tempView1;
        }
        KSYDetailModel *SKYmodel=_models[indexPath.row];
        cell.model2=SKYmodel;//调用set方法
        return cell;
        
    }
    else if (self.kSegmentedCTL.selectedSegmentIndex==2){
        KSYIntTVCell *cell=[tableView dequeueReusableCellWithIdentifier:subscribeIdentify];
        if (cell==nil){
            cell=[[KSYIntTVCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:subscribeIdentify];
            cell.backgroundColor=[UIColor clearColor];
            UIView* tempView=[[UIView alloc] initWithFrame:cell.frame];
            tempView.backgroundColor = DEEPCOLOR;
            cell.backgroundView = tempView;  //更换背景色     不能直接设置backgroundColor
            UIView* tempView1=[[UIView alloc] initWithFrame:cell.frame];
            tempView1.backgroundColor = DEEPCOLOR;
            cell.selectedBackgroundView = tempView1;
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
    //根据路径获得字典
    [_models removeAllObjects];
    [_modelsCells removeAllObjects];
    //如果是评论，加载评论的数据
    if(segment.selectedSegmentIndex==0){
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Model1" ofType:@"plist"];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_models addObject:[KSYCommentModel modelWithDictionary:obj]];
            KSYComTvCell *cell=[[KSYComTvCell alloc]init];
            [_modelsCells addObject:cell];
        }];
        [self.kTableView reloadData];
    }
    //如果是详情，获取详情的数据
    else if(segment.selectedSegmentIndex==1){
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
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Model3" ofType:@"plist"];
        NSArray *array=[NSArray arrayWithContentsOfFile:path];
        //利用代码块遍历
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_models addObject:[KSYIntroduceModel modelWithDictionary:obj]];
            KSYIntTVCell *cell=[[KSYIntTVCell alloc]init];
            [_modelsCells addObject:cell];
        }];
        [self.kTableView reloadData];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.showCommentView) {
        self.showCommentView(_kSegmentedCTL.selectedSegmentIndex,_kTableView.contentOffset.y);
    }
}
@end
