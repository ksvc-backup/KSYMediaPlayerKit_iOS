//
//  KSYShortVideoPlayView.m
//  KSYVideoDemo
//
//  Created by 孙健 on 15/12/25.
//  Copyright © 2015年 kingsoft. All rights reserved.
//

#import "KSYShortVideoPlayView.h"
#import "KSYCommentView.h"

@interface KSYShortVideoPlayView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *ksyShortTableView;
    NSString *videoString;
    KSYCommentView *commentView;

}
@end


@implementation KSYShortVideoPlayView


- (instancetype)initWithFrame:(CGRect)frame UrlPathString:(NSString *)urlPathString
{
    videoString=urlPathString;
    //重置播放界面的大小
    self = [super initWithFrame:frame];//初始化父视图的(frame、url)
    if (self) {
        ksyShortTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        ksyShortTableView.backgroundColor=[UIColor blackColor];
        ksyShortTableView.delegate=self;
        ksyShortTableView.dataSource=self;
        [self addSubview:ksyShortTableView];
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
        [self addCommentView];
        commentView.hidden=YES;
    }
    return self;
}
#pragma mark 添加评论视图
- (void)addCommentView
{
    WeakSelf(KSYShortVideoPlayView);
    commentView=[[KSYCommentView alloc]initWithFrame:CGRectMake(0, self.height-40, self.width, 40)];
    commentView.textFieldDidBeginEditing=^(){
        [weakSelf changeCommentViewFrame];
    };
    commentView.send=^(){
        [weakSelf rechangeCommentViewFrame];
    };
    [self addSubview:commentView];
}
#pragma mark 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _models.count;
}
#pragma mark 每行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId1=@"identify1";
    static NSString *cellId2=@"identify2";
    if (indexPath.row==0) {
        commentView.hidden=YES;
        _videoCell=[tableView dequeueReusableCellWithIdentifier:cellId1];
        if (!_videoCell) {
            _videoCell=[[KSYShortTabelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1 urlstr:videoString frame:CGRectMake(0, 0, self.width, 260)];
            _videoCell.ksyShortView.isBackGroundReleasePlayer=self.isDidRelease;
        }
        return _videoCell;
    }else {
        commentView.hidden=NO;
        KSYComTvCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId2];
        if (!cell){
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
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (ksyShortTableView.contentOffset.y>260.0) {
        [_videoCell.ksyShortView pause];
    }else{
        [_videoCell.ksyShortView play];
    }
}
#pragma mark 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0){
        return 260;
    }else{
        
        KSYComTvCell *cell=_modelsCells[indexPath.row];
        cell.model1=_models[indexPath.row];//这里执行set方法
        return cell.height;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (void)changeCommentViewFrame
{
    commentView.frame=CGRectMake(0, self.height/2-8, self.width, 40);
}
- (void)rechangeCommentViewFrame
{
    commentView.frame=CGRectMake(0, self.height-40, self.width, 40);
    UITextField *kTextField=(UITextField *)[self viewWithTag:kCommentFieldTag];
    [kTextField resignFirstResponder];
}
@end
