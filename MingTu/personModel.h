//
//  personModel.h
//  MingTu
//
//  Created by M-SJ077 on 2017/2/7.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface personModel : NSObject<NSCopying, NSMutableCopying, NSCoding>

@property (nonatomic , strong)NSString *name;
@property (nonatomic , strong)NSString *phone;
@property (nonatomic , strong)NSString *qq;
@property (nonatomic , strong)UIImage *headImageView;

@end
