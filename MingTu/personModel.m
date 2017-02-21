//
//  personModel.m
//  MingTu
//
//  Created by M-SJ077 on 2017/2/7.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "personModel.h"

@implementation personModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"person_name"];
    [aCoder encodeObject:self.phone forKey:@"person_phone"];
    [aCoder encodeObject:self.qq forKey:@"person_qq"];
    [aCoder encodeObject:self.qq forKey:@"person_image"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"person_name"];
        self.phone = [aDecoder decodeObjectForKey:@"person_phone"];
        self.qq = [aDecoder decodeObjectForKey:@"person_qq"];
        self.qq = [aDecoder decodeObjectForKey:@"person_image"];
    }
    return self;
}

@end
