//
//  yue_scrollView.m
//  MingTu
//
//  Created by zhangzhihua on 2017/2/20.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "yue_scrollView.h"

@implementation yue_scrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"----点击myView----");
}
//这个方法只能针对自己和他自己的子视图
-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];

    if (hitView == self){
        return nil;
    }else{
        return hitView;
    }
}
@end
