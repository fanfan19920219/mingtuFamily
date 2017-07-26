//
//  AVplayerDownView.h
//  MingTu
//
//  Created by zhangzhihua on 2017/7/26.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVplayerDownView : UIView
@property (strong, nonatomic) IBOutlet UILabel *VideoName;
@property (strong, nonatomic) IBOutlet UILabel *PlayerNum;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UITextField *contentText;


+(instancetype)AView;
+(instancetype)BView;

-(void)setVideo_Name:(NSString*)name;
@end
