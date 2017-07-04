//
//  PersonalViewController.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/3.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//


#define HEADERIMG_SIZE 140.f
#define TITLELABEL_WIDTH 200
#define TITLELABEL_HEIGHT 20
#define HEADERVIEW_HEIGHT 240.f

#import "PersonalViewController.h"
#import "Header.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIView *_headerView;
    UIButton *_headerButton;
    UILabel *_titlelabel;
    
    UITableView *_tableView;
    NSArray *_titleArray;
    UIImagePickerController *_imagePickerController;
}

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    [self create_Views];
    [self create_tableView];
}

-(void)create_Views{
    
    UIImage *headImage = [[ZZH_LoadingProject shareMBProgress]readImage:TRUEPATH_IMAGE(HEADER_IMAGENAME)];
    if(headImage==nil){
        headImage = [UIImage imageNamed:HEAD_INDEXIMAGE];
    }
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,VIEW_WIDTH, HEADERVIEW_HEIGHT)];
    _headerView.backgroundColor = RGBA(255, 250, 250, 1);
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"个人中心背景.jpg"]];
    backImage.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    backImage.alpha = 0.8;
    [_headerView addSubview:backImage];
    
    [self.view addSubview:_headerView];
    
    _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton.frame = CGRectMake((VIEW_WIDTH/2) - HEADERIMG_SIZE/2, 104, HEADERIMG_SIZE, HEADERIMG_SIZE);
    _headerButton.layer.cornerRadius = HEADERIMG_SIZE/2;
    [_headerButton addTarget:self action:@selector(getHead) forControlEvents:UIControlEventTouchUpInside];
    [_headerButton setImage:headImage forState:UIControlStateNormal];
    [_headerButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
//    [_headerView addSubview:_headerButton];
    [self setSlide:_headerButton];
    
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake((VIEW_WIDTH - TITLELABEL_WIDTH)/2, _headerButton.frame.origin.y + HEADERIMG_SIZE + 84, TITLELABEL_WIDTH, TITLELABEL_HEIGHT)];
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    _titlelabel.font = [UIFont systemFontOfSize:13 weight:0.1];
    _titlelabel.textColor = RGBA(44, 44, 44, 1);
    //_titlelabel.text = @"任 叶 萍";
    [_headerView addSubview:_titlelabel];
    
    //添加遮罩
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame =CGRectMake(0, 0, VIEW_WIDTH, 44);
    //            [selfView.navigationController.view.layer addSublayer:gradient];
    // 颜色分配
    gradient.colors = @[(__bridge id)RGBA(163, 141, 185, 1).CGColor,(__bridge id)[UIColor clearColor].CGColor];
    // 颜色分割线
    gradient.locations  = @[@(0),@(1)];
    // 起始点
    gradient.startPoint = CGPointMake(0, 0);
    // 结束点
    gradient.endPoint   = CGPointMake(0, 1);
    [self.view.layer addSublayer:gradient];
    
}

-(void)create_tableView{
    
    _titleArray = @[@"常用联系人",@"更换下拉壁纸"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerView.frame.origin.y + HEADERVIEW_HEIGHT + 64, VIEW_WIDTH, VIEW_HEIGHT - (_headerView.frame.origin.y + HEADERVIEW_HEIGHT) - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70.f;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.alpha = 0.8;
    [self.view addSubview:_tableView];
    
}

-(void)setSlide:(UIView*)view{
    //button设置边框
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:1.5];   //边框宽度
    [view.layer setBorderColor:RGBA(255, 255, 255, 1).CGColor];//边框颜色
    
    //[NSHomeDirectory() stringByAppendingString:@"/name.plist"]
    
}


-(void)getHead{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    [[cell.contentView viewWithTag:2] removeFromSuperview];
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    if([[_titleArray objectAtIndex:indexPath.row] isEqualToString:@"BianBian"]){
        cell.textLabel.text = @"";
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
        imageView.layer.cornerRadius = imageView.frame.size.height/2;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:@"bianbian.png"];
        imageView.tag = 2;
        [cell.contentView addSubview:imageView];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13 weight:0.001];
    cell.textLabel.textColor = RGBA(152, 122, 122, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:{
            personInformationViewController *personVC = [[personInformationViewController alloc]init];
            [self.navigationController pushViewController:personVC animated:YES];
        }
            break;
        case 1:{
            [self getHead];
//            showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
//            showViewcontroller.URL = PERSONAL_MAIN;
//            //            [self.navigationController pushViewController:showViewcontroller animated:YES];
//            [self presentViewController:showViewcontroller animated:YES completion:^{
//                
//            }];
        }
            break;
        case 2:{
//            showWebViewController *showViewcontroller = [[showWebViewController alloc]init];
//            showViewcontroller.URL = SPEED;
//            //            [self.navigationController pushViewController:showViewcontroller animated:YES];
//            [self presentViewController:showViewcontroller animated:YES completion:^{
//                
//            }];
        }
            break;
            
        case 3:{
            BianBianViewController *bianbian = [[BianBianViewController alloc]init];
            //            [self.navigationController pushViewController:showViewcontroller animated:YES];
            [self.navigationController pushViewController:bianbian animated:YES];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [_headerButton setImage:image forState:UIControlStateNormal];
        NSNotification *notification =[NSNotification notificationWithName:@"refreshHeader" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
    [[ZZH_LoadingProject shareMBProgress]saveImage:image andPath:TRUEPATH_IMAGE(HEADER_IMAGENAME)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
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
