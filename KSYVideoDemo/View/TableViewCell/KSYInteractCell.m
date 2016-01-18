//
//  KSYInteractCell.m
//  KSYVideoDemo
//
//  Created by 孙健 on 16/1/7.
//  Copyright © 2016年 kingsoft. All rights reserved.
//

#import "KSYInteractCell.h"
#import "KSYInterfaceModel.h"

@interface KSYInteractCell (){
    KSYInterfaceModel *_interfaceModel;
    int _playTimes;
    int _commentTimes;
    int _subscribTimes;
    int _shareTimes;
}

@end



@implementation KSYInteractCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addButtons];
        [self addLabels];
        _playTimes=200;
        _commentTimes=200;
        _subscribTimes=200;
        _shareTimes=200;
        //kvc
        _interfaceModel=[[KSYInterfaceModel alloc]init];
        [_interfaceModel setValue:@"200" forKey:@"playTimes"];
        [_interfaceModel addObserver:self forKeyPath:@"playTimes" options:NSKeyValueObservingOptionNew context:nil];
        [_interfaceModel setValue:@"200" forKey:@"commentTimes"];
        [_interfaceModel addObserver:self forKeyPath:@"commentTimes" options:NSKeyValueObservingOptionNew context:nil];
        [_interfaceModel setValue:@"200" forKey:@"subscribTimes"];
        [_interfaceModel addObserver:self forKeyPath:@"subscribTimes" options:NSKeyValueObservingOptionNew context:nil];
        [_interfaceModel setValue:@"200" forKey:@"shareTimes"];
        [_interfaceModel addObserver:self forKeyPath:@"shareTimes" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}
- (void)addButtons{
    NSArray *array=[NSArray arrayWithObjects:@"playTime",@"comments",@"subscribe",@"sharedTimes", nil];
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.frame=CGRectMake(30+i*60, 10, 30, 30);
        UIImage *image=[UIImage imageNamed:array[i]];
        [btn setImage:image forState:UIControlStateNormal];
        btn.layer.masksToBounds=YES;
        btn.layer.borderColor=[THEMECOLOR CGColor];
        btn.layer.borderWidth=1;
        btn.layer.cornerRadius=5;
        btn.tag=160+i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.showsTouchWhenHighlighted=YES;
    }
}
- (void)addLabels{
    for (int i=0; i<4; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(25+i*60, 45, 40, 30)];
        [self addSubview:label];
        label.textColor=[UIColor whiteColor];
        label.text=@"200";
        label.tag=165+i;
        label.textAlignment=NSTextAlignmentCenter;
    }
}
- (void)clickBtn:(UIButton *)btn{
    if (btn.tag==160) {
        [_interfaceModel setValue:[NSString stringWithFormat:@"%d",_playTimes++] forKey:@"playTimes"];
    }else if (btn.tag==161){
        [_interfaceModel setValue:[NSString stringWithFormat:@"%d",
                                   _commentTimes++] forKey:@"commentTimes"];
    }else if (btn.tag==162){
        [_interfaceModel setValue:[NSString stringWithFormat:@"%d",_subscribTimes++] forKey:@"subscribTimes"];
    }else if (btn.tag==163){
        [_interfaceModel setValue:[NSString stringWithFormat:@"%d",_shareTimes++] forKey:@"shareTimes"];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString: @"playTimes"]) {
        UILabel *label=(UILabel *)[self viewWithTag:165];
        label.text=[NSString stringWithFormat:@"%d",_playTimes];
    }else if ([keyPath isEqualToString: @"commentTimes"]) {
        UILabel *label=(UILabel *)[self viewWithTag:166];
        label.text=[NSString stringWithFormat:@"%d",_commentTimes];
    }else if ([keyPath isEqualToString: @"subscribTimes"]) {
        UILabel *label=(UILabel *)[self viewWithTag:167];
        label.text=[NSString stringWithFormat:@"%d",_subscribTimes];
    }else if ([keyPath isEqualToString: @"shareTimes"]) {
        UILabel *label=(UILabel *)[self viewWithTag:168];
        label.text=[NSString stringWithFormat:@"%d",_shareTimes];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dealloc{
    [_interfaceModel removeObserver:self forKeyPath:@"playTimes"];
    [_interfaceModel removeObserver:self forKeyPath:@"commentTimes"];
    [_interfaceModel removeObserver:self forKeyPath:@"subscribTimes"];
    [_interfaceModel removeObserver:self forKeyPath:@"shareTimes"];
    
}

@end
