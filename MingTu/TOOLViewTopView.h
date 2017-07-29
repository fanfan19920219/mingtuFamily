//
//  TOOLViewTopView.h
//  MingTu
//
//  Created by Star J on 2017/7/29.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOOLViewTopView : UIView

+(instancetype)TView;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *centerButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *downButton;

@end
