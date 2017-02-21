//
//  UIView+a.m
//  0217autolayout
//
//  Created by zhangzhihua on 16/2/17.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "UIView+Layout.h"
#import "Header.h"

@implementation UIView (Layout)


-(void)setLayoutSonView:(UIView*)sonView andup:(CGFloat)up left:(CGFloat)left down:(CGFloat)down right:(CGFloat)right{
    //将子view添加到父视图上
    [self addSubview:sonView];
    //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
    [sonView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //layout 子view
    //上间距
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:sonView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:up];
    //左间距
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:sonView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:left];
    //下间距
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:sonView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-right];
    //右间距
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:sonView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-down];
    //把约束添加到父视图上
    NSArray *array = [NSArray arrayWithObjects:contraint1,contraint2,contraint3,contraint4, nil];
    [self addConstraints:array];
}

//setFrame
#pragma mark ------X------
-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)x{
    return self.frame.origin.x;
}

#pragma mark ------Y------
-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

#pragma mark ------W------
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width{
    return self.frame.size.width;
}

#pragma mark ------H------
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setSlide:(UIView*)view andSlideColor:(UIColor*)color{
    //button设置边框
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:1.0];   //边框宽度
    if(color!=nil){
        [view.layer setBorderColor:color.CGColor];
        return;
    }
    [view.layer setBorderColor:RGBA(222, 222, 222, 1).CGColor];//边框颜色
}

//-(void)setBackgroundColor:(UIColor *)backgroundColor{
//    self.backgroundColor = backgroundColor;
//}





@end
