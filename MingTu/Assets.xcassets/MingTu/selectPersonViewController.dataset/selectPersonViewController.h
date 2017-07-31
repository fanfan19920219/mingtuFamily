//
//  selectPersonViewController.h
//  MingTu
//
//  Created by M-SJ077 on 2017/2/8.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface selectPersonViewController : UIViewController

@property (nonatomic ,strong)NSString *methodString;
@property (nonatomic , assign)BOOL orLocation;
@property (nonatomic ,assign)id<SetPersonDelegate> delegate;
@end
