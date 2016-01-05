#KSYMediaPlayer-iOS-SDK-LIBRARY
---
##LIBRARY更新日志
  
**2016-01-05**

  -   **V 0.1.0** 初版本发布，提供对应场景(手机直播及回看，游戏直播，在线视频点播及短视频)的基本UI以及播放器状态控制逻辑

##LIBRARY使用说明
###适用场景说明
本项目为基于KSY MediaPlayer Android SDK封装的Library库，以及一系列集成示例工程，分别适用于以下不同场景：

* 手机直播观看及手机直播回看
* 游戏直播观看
* 在线视频点播观看
* 短视频观看

**Library库集成并封装了Ksy MediaPlayer iOS SDK**，目的是方便开发者快速集成播放器。无需为播放相关的UI，直播与点播差异，以及各种事件和状态（Home键,电源键,弱网状态操作等）下播放器状态处理耗费太多精力。

**不同场景的集成示例工程，对应的UI及状态处理逻辑均有差异**，请开发者结合自身APP类型，合理的参考集成示例。鉴于APP业务逻辑可能与SDK默认处理逻辑略有差异，SDK提供了对应的状态修改API，如果不够灵活，开发者也可自行修改源码逻辑。

###结构
KSYMediaPlayer Demo 采用MVC模式，对播放器的核心SDK KSYMediaPlayer.framework进行了UI层次的封装。其核心播放类基本与iOS的MPMoviePlayerController接口保持一致，在其基础上扩充了一些功能。

##LIBRARY结构说明
###app工程

- **Framework** 文件夹：包含了核心SDK KSYMediaPlayer.framework；iOS系统播放类库：VideoToolbox.framework；以及一些系统依赖库：libz.tbd，libbz2.tbd，libstdc++.6.tbd。
- **VideoViewController** 文件夹：包含了手机直播回看集成示例，游戏直播观看集成示例等集成，在后面会有详细介绍。
- **View** 文件夹：包含了直播视图所需要的各种定制化模块化视图
- **Model** 文件夹：包含了视图所需要的数据模型
- **Catergoary** 文件夹：类别
- **Reachability** 文件夹：判断网络状况的类库
- **Resources** 文件夹：包含了图片等资源

###关键类说明
- **KSYBasePlayView** 本工程中播放视图的基类，封装了KsyMediaPlayer API，也包含了播放器状态控制及部分特殊事件回调与处理.
- **KSYVideoOnDemandPlayVC** 	在线视频观看集成示例
- **KSYPopilarLivePlayVC**		传统直播观看集成示例
- **KSYPopilarLivePlayBackVC**	传统直播回看集成示例
- **KSYPhoneLivePlayVC**		手机直播观看示例
- **KSYPhoneLivePlayBackVC**	手机直播回看观看示例
- **KSYShortVideoPlayVC**		短视频播放示例

##集成
**导入SDK以及相关代码**

- 新建工程，引入KSYMediaPlayer.framework，VideoToolbox.framework，libz.tbd，libbz2.tbd，libstdc++.6.tbd这些类库。
- 引入View,Model,Catergoary,Reahabitity文件夹

**初始化**

以手机直播为例

**1.在Controller中引入KSYPhoneLivePlayView.h，CommentModel.h，SpectatorModel.h**

```
import "KSYPhoneLivePlayView.h"
import "CommentModel.h"
import "SpectatorModel.h"

```

**2.Controller中初始化KSYPhoneLivePlayView**

```
    _phoneLivePlayVC = [[KSYPhoneLivePlayView alloc] initWithFrame:self.view.bounds urlString:self.videoUrlString playState:KSYPhoneLivePlay];
    //观看用户
    _phoneLivePlayVC.spectatorsArray = _spectatorsArr;
	[self.view addSubview:_phoneLivePlayVC];


```

**3.设置KSYPhoneLivePlayView回调接口**

```
    _phoneLivePlayVC.liveBroadcastCloseBlock = ^{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定退出观看？" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    };
    _phoneLivePlayVC.liveBroadcastReporteBlock = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请调用举报接口" delegate:weakSelf cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    };
    _phoneLivePlayVC.shareBlock = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请调用分享接口" delegate:weakSelf cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    };

```

**4.销毁播放器**

```
        [_phoneLivePlayVC shutDown];

```

> 对应其它同场景的详细集成示例，请参考Demo中的其他场景


##接口说明

###KSYBasePlayView接口说明

**方法名：**

初始化播放视图

-(instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;

参数说明：

- frame: 设置播放视图的frame
- urlString：播放地址

**方法名：**

播放

-(void)play;

**方法名：**

暂停

-(void)pause;

**方法名：**

停止

-(void)stop;

**方法名：**

关闭播放器

-(void)shutDown;

**方法名：**

更新当前播放时间

-(void)updateCurrentTime;

**方法名：**

seek到某一时间点

-(void)moviePlayerSeekTo:(NSTimeInterval)position;

###KSYBasePlayView属性说明

```
中断事件是否释放播放器，返回重新创建，针对点播。直播默认是YES
isBackGroundReleasePlayer;


```
```
视频总时长
duration

```

```
视频播放的当前时间
currentPlaybackTime

```









