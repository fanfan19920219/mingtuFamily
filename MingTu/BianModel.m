//
//  BianModel.m
//  MingTu
//
//  Created by zhangzhihua on 2017/3/2.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "BianModel.h"

@implementation BianModel
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.time forKey:@"time"];
}

/**
 *  从文件中解析对象时会调用
 *  在这个方法中说清楚哪些属性需要存储
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.content = [decoder decodeObjectForKey:@"content"];
        self.time = [decoder decodeObjectForKey:@"time"];
    }
    return self;
}
@end
