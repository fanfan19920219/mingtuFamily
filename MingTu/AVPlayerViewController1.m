//
//  AVPlayerViewController1.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/26.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "AVPlayerViewController1.h"
#import "ZFPlayerView.h"
#import <MediaPlayer/MediaPlayer.h>

#define PLAYER_VIEW_HEIGHT 200.f

@interface AVPlayerViewController1 ()<ZFPlayerDelegate>
@property (nonatomic , strong)AVPlayer *player ;
@property (nonatomic , strong)ZFPlayerView *playerView;
@property (nonatomic , strong)NSURL *url;
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器
@property (nonatomic , strong) UIView *showView;
@property (nonatomic , strong) UIView *downView;
@property (nonatomic , strong)UITableView *chatContentTableView;
@property (nonatomic , strong)NSMutableArray *chatContentArray;
@property (nonatomic , strong)AVplayerDownView *downViewDown;
@property (nonatomic , strong)AVPlayerTableViewDelegateAndDataSource *delegateAndDataSource;

@end

@implementation AVPlayerViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initplayer];
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame = CGRectMake(100, 100, 40, 40);
    playButton.backgroundColor = [UIColor redColor];
    [playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMPPlayer];
    [self create_Views];
    
}

-(void)create_Views{
    AVplayerDownView *downViewTop = [AVplayerDownView BView];
    downViewTop.VideoName.text = self.videoShowName;
    downViewTop.PlayerNum.text = @"播放33次";
    downViewTop.frame = CGRectMake(0,  64 + PLAYER_VIEW_HEIGHT, VIEW_WIDTH, 44);
    [self.view addSubview:downViewTop];
    
    _downViewDown = [AVplayerDownView AView];
//    _downViewDown.contentText.text = @"";
    [_downViewDown.sendButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    _downViewDown.frame = CGRectMake(0, VIEW_HEIGHT - 44, VIEW_WIDTH, 44);
    [self.view addSubview:_downViewDown];
    
    _chatContentArray = [[NSMutableArray alloc]init];
    
    _chatContentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108 + PLAYER_VIEW_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT - ( 108 + PLAYER_VIEW_HEIGHT) - 44) style:UITableViewStylePlain];
    _chatContentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatContentTableView.tableFooterView = [[UIView alloc]init];
    
    
    _delegateAndDataSource = [[AVPlayerTableViewDelegateAndDataSource alloc]init_withdataArray:_chatContentArray withReturnBlock:^(id obj) {
        
    }];
    _chatContentTableView.dataSource =_delegateAndDataSource;
    _chatContentTableView.delegate = _delegateAndDataSource;
    [self.view addSubview:_chatContentTableView];
    
}


-(void)sendClick:(UIButton*)sender{
    AVPlayerContentModel *contentModel = [[AVPlayerContentModel alloc]init];
    contentModel.userName = @"张蔚然";
    contentModel.userContent = [NSString stringWithFormat:@"%@",_downViewDown.contentText.text];
    [_chatContentArray addObject:contentModel];
    NSLog(@"contenarray --- %@",_chatContentArray);
    [_chatContentTableView reloadData];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:_chatContentArray.count-1 inSection:0];
    [_chatContentTableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self.view endEditing:YES];
    _downViewDown.contentText.text = @"";
}



-(void)initMPPlayer{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //播放
    [self.moviePlayer play];
    
    //添加通知
    [self addNotification];
}
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:self.videoLocalName ofType:@"mp4"];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
//https://imgcache.qq.com/tencentvideo_v1/playerv3/TPout.swf?max_age=86400&v=20161117&vid=u0528zcn9yh&auto=0
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://imgcache.qq.com/tencentvideo_v1/playerv3/TPout.swf?max_age=86400&v=20161117&vid=m0527kk2b0d&auto=0";
    //https://imgcache.qq.com/tencentvideo_v1/playerv3/TPout.swf?max_age=86400&v=20161117&vid=m0527kk2b0d&auto=0
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getFileUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=CGRectMake(0, 64, VIEW_WIDTH, PLAYER_VIEW_HEIGHT);
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}


-(void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=NO;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}



























/*****************************************************************************************/
-(void)initplayer{
    self.playerView = [[ZFPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        // Here a 16:9 aspect ratio, can customize the video aspect ratio
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    //https://imgcache.qq.com/tencentvideo_v1/playerv3/TPout.swf?max_age=86400&v=20161117&vid=k0368f002ex&auto=0
    //http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
    self.url = [NSURL URLWithString:@"https://imgcache.qq.com/tencentvideo_v1/playerv3/TPout.swf?max_age=86400&v=20161117&vid=k0368f002ex&auto=0"];
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    // model
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.fatherView = self.view;
    playerModel.videoURL = self.url;
    playerModel.title = @"这是title";
    [self.playerView playerControlView:controlView playerModel:playerModel];
    // delegate
    self.playerView.delegate = self;
    // auto play the video
    [self.playerView autoPlayTheVideo];
    
}

-(void)play{
    [self.player play];
}

/** 返回按钮事件 */
- (void)zf_playerBackAction{
    
}
/** 下载视频 */
- (void)zf_playerDownload:(NSString *)url{
    
}
/** 控制层即将显示 */
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    
}
/** 控制层即将隐藏 */
- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
