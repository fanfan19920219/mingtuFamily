//
//  videoViewController.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/7.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//
/*
 <embed src="http://player.youku.com/player.php/sid/XNTgzODY4MTU2/v.swf" allowFullScreen="true" quality="high" width="480" height="400" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>
 <iframe height=498 width=510 src="http://player.youku.com/embed/XNTgzODY4MTU2" frameborder=0 allowfullscreen></iframe>
 
 */
#define HTML @"<embed src=\"http://player.youku.com/player.php/sid/XNTgzODY4MTU2/v.swf\" allowFullScreen=\"true\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>"

#define HTML1 @"http://f.v.17173cdn.com/flash/PreloaderFileFirstpage.swf?cid=MTgwOTgyODI&refer=http://speed.gamebbs.qq.com/forum.php?mod=viewthread&tid=989178&extra=page%3D1"

//一周年
#define YIZHOUNIAN_URL [NSString stringWithFormat:@"<iframe height=%f width=%f src=\"http://player.youku.com/embed/XMzUyMTU1NTYw\" frameborder=0 allowfullscreen></iframe>",VIEW_HEIGHT,VIEW_WIDTH*2.5]

//三周年视频
#define SANZHOUNIAN_URL [NSString stringWithFormat:@"<iframe height=%f width=%f src=\"http://player.youku.com/embed/XNTgzODY4MTU2\" frameborder=0 allowfullscreen></iframe>",VIEW_HEIGHT,VIEW_WIDTH*2.5]

//音乐谷赛王
#define S_YINYUEGU @"<iframe class=\"vplayer\" width=480 height=400 src=\"http://v.17173.com/player_ifrm/MTgwOTgyODI.html\" scrolling=no frameborder=0 allowfullscreen></iframe>"


#define SECTION_HEIGHT 30.0


#import "videoViewController.h"
#import "Header.h"
@interface videoViewController()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
    NSMutableArray *_SectioArray;
    
}
@end

@implementation videoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self create_data];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
    
}


-(void)create_data{
    _SectioArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *personArray = [[NSMutableArray alloc]init];
    video_model *videomodel1 = [[video_model alloc]init];
    videomodel1.url = YIZHOUNIAN_URL;
    videomodel1.title = @"一周年视频";
    videomodel1.time = @"2013年12月5日";
    videomodel1.section = 0;
    
    video_model *videomodel2 = [[video_model alloc]init];
    videomodel2.url = SANZHOUNIAN_URL;
    videomodel2.title = @"三周年视频";
    videomodel2.time = @"2013年12月5日";
    videomodel2.section = 0;
    [personArray addObject:videomodel1];
    [personArray addObject:videomodel2];
    
    [_SectioArray addObject:personArray];
    
    NSMutableArray *swArray = [[NSMutableArray alloc]init];
    video_model *s_videomodel1 = [[video_model alloc]init];
    s_videomodel1.url = S_YINYUEGU;
    s_videomodel1.title = @"音乐谷极速之王";
    s_videomodel1.time = @"2013年12月5日";
    s_videomodel1.section = 1;
    [swArray addObject:s_videomodel1];
    
    [_SectioArray addObject:swArray];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    main_cell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[main_cell alloc]init];
    }
    video_model *model = [[_SectioArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell settime_label:model.time];
    [cell settitle_label:model.title];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_SectioArray objectAtIndex:section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_SectioArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    showWebViewController *show = [[showWebViewController alloc]init];
    video_model *videomodel = [[_SectioArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    show.URL = videomodel.url;
    show.orHTML = YES;
    [self.navigationController pushViewController:show animated:YES];
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, SECTION_HEIGHT)];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, VIEW_WIDTH, 20)];
    if(section ==0 ){
        titlelabel.text = @"玩家视频";
    }else if(section ==1){
        titlelabel.text = @"赛王视频";
    }
    [backGroundView addSubview:titlelabel];
    backGroundView.backgroundColor = RGBA(240, 240, 250, 1);
    return backGroundView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SECTION_HEIGHT;
}

@end
