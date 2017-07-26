//
//  AVPlayerTableViewDelegateAndDataSource.h
//  MingTu
//
//  Created by zhangzhihua on 2017/7/26.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Header.h"
@interface AVPlayerTableViewDelegateAndDataSource : NSObject <UITableViewDelegate,UITableViewDataSource>

-(instancetype)init_withdataArray:(NSMutableArray*)array withReturnBlock:(AVPlayerTableViewReturnBlock)returnBlock;

@end
