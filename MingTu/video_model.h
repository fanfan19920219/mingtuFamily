//
//  video_model.h
//  MingTu
//
//  Created by zhangzhihua on 16/3/7.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface video_model : NSObject
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)NSInteger section;
@property (nonatomic , strong)NSString *title;
@property (nonatomic , strong)NSString *time;

@end
