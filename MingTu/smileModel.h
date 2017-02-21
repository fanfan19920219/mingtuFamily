//
//  smileModel.h
//  MingTu
//
//  Created by zhangzhihua on 2017/2/16.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface smileModel : NSObject

@property (nonatomic , strong)NSString *content;
@property (nonatomic , strong)NSString *hashId;
@property (nonatomic , strong)NSString *unixtime;
@property (nonatomic , strong)NSString *updatetime;

-(void)setValue:(NSDictionary *)valueDic;

@end
