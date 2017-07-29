//
//  TOOLViewTopView.m
//  MingTu
//
//  Created by Star J on 2017/7/29.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "TOOLViewTopView.h"

@implementation TOOLViewTopView


+(instancetype)TView{
    return [[[NSBundle mainBundle]loadNibNamed:@"TOOLViewTopView" owner:nil options:nil] objectAtIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
