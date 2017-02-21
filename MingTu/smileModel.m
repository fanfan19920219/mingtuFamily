//
//  smileModel.m
//  MingTu
//
//  Created by zhangzhihua on 2017/2/16.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "smileModel.h"

@implementation smileModel

-(void)setValue:(NSDictionary *)valueDic{
    @try {
        self.content = [NSString stringWithFormat:@"%@",[valueDic objectForKey:@"content"]];
        self.hashId = [NSString stringWithFormat:@"%@",[valueDic objectForKey:@"hashId"]];
        self.unixtime = [NSString stringWithFormat:@"%@",[valueDic objectForKey:@"unixtime"]];
        self.updatetime = [NSString stringWithFormat:@"%@",[valueDic objectForKey:@"updatetime"]];
                
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


@end
