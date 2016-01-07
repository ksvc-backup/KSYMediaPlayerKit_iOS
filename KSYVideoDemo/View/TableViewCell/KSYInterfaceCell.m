//
//  KSYInterfaceCell.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/7.
//  Copyright © 2016年 kingsoft. All rights reserved.
//  要用到的技术：1.KVC、KVO 2.自动布局 3.归档解档

#import "KSYInterfaceCell.h"
#import "KSYShortModel.h"

@interface KSYInterfaceCell (){
    KSYShortModel *_shortModel;
    int playTimes;
    int commentTimes;
    int subscriberTimes;
    int sharedTimes;
}

@end


@implementation KSYInterfaceCell
//初始化单元格
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView* tempView=[[UIView alloc] initWithFrame:self.frame];
        tempView.backgroundColor =KSYCOLER(90, 90, 90);
        self.backgroundView = tempView;  //更换背景色     不能直接设置backgroundColor
        UIView* tempView1=[[UIView alloc] initWithFrame:self.frame];
        tempView1.backgroundColor = KSYCOLER(90, 90, 90);
        self.selectedBackgroundView = tempView1;
        [self addButtons];
        [self addLabels];
        _shortModel=[[KSYShortModel alloc]init];
        [_shortModel setValue:@"200" forKey:@"playTimes"];
        [_shortModel addObserver:self forKeyPath:@"playTimes" options:NSKeyValueObservingOptionNew context:nil];
        [_shortModel setValue:@"200" forKey:@"commentTimes"];
        [_shortModel addObserver:self forKeyPath:@"commentTimes" options:NSKeyValueObservingOptionNew context:nil];
        [_shortModel setValue:@"200" forKey:@"subscriberTimes"];
        [_shortModel addObserver:self forKeyPath:@"subscriberTimes" options:NSKeyValueObservingOptionNew context:nil];
        [_shortModel setValue:@"200" forKey:@"sharedTimes"];
        [_shortModel addObserver:self forKeyPath:@"sharedTimes" options:NSKeyValueObservingOptionNew context:nil];
        
        playTimes=200;
        commentTimes=200;
        subscriberTimes=200;
        sharedTimes=200;
    }
    return self;
}
- (void)addButtons{
    //创建一个数组用来存放图片名称
    NSArray *pictureName=[NSArray arrayWithObjects:@"playTimes",@"Comments", @"Subscribe",@"Share",nil];
    //循环添加4个按钮
    for (int i=0; i<4; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(20+50*i, 5, 30, 30)];
        [self addSubview:button];
        button.layer.masksToBounds=YES;
        button.layer.borderWidth=1;
        button.layer.cornerRadius=5;
        button.layer.borderColor=[KSYCOLER(92, 232, 223)CGColor];
        [button setImage:[UIImage imageNamed:pictureName[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=160+i;
        button.showsTouchWhenHighlighted=YES;
    }
}
- (void)addLabels{
    //循环创建4个标签
    for(int i=0;i<4;i++){
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20+50*i, 40, 30, 30)];
        [self addSubview:label];
        label.textColor=[UIColor whiteColor];
        label.text=@"200";
        label.tag=165+i;
    }
}
- (void)ClickButton:(UIButton *)btn{
    if (btn.tag==160) {
        [_shortModel  setValue:[NSString stringWithFormat:@"%d",playTimes++] forKey:@"playTimes"];
    }else if (btn.tag==161){
        [_shortModel  setValue:[NSString stringWithFormat:@"%d",commentTimes++] forKey:@"commentTimes"];
    }else if (btn.tag==162){
        [_shortModel  setValue:[NSString stringWithFormat:@"%d",subscriberTimes++] forKey:@"subscriberTimes"];
    }else if (btn.tag==163){
        [_shortModel  setValue:[NSString stringWithFormat:@"%d",sharedTimes++] forKey:@"sharedTimes"];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"playTimes"]) {
        UILabel *label=(UILabel *)[self viewWithTag:165];
        label.text=[NSString stringWithFormat:@"%@",[_shortModel valueForKey:@"playTimes"]];
    }else if ([keyPath isEqualToString:@"commentTimes"]){
        UILabel *label=(UILabel *)[self viewWithTag:166];
        label.text=[NSString stringWithFormat:@"%@",[_shortModel valueForKey:@"commentTimes"]];
    }else if ([keyPath isEqualToString:@"subscriberTimes"]) {
        UILabel *label=(UILabel *)[self viewWithTag:167];
        label.text=[NSString stringWithFormat:@"%@",[_shortModel valueForKey:@"subscriberTimes"]];
    }else if ([keyPath isEqualToString:@"sharedTimes"]){
        UILabel *label=(UILabel *)[self viewWithTag:168];
        label.text=[NSString stringWithFormat:@"%@",[_shortModel valueForKey:@"sharedTimes"]];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
