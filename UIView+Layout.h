//
//  UIView+a.h
//  0217autolayout
//
//  Created by zhangzhihua on 16/2/17.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;

-(void)setLayoutSonView:(UIView*)sonView andup:(CGFloat)up left:(CGFloat)left down:(CGFloat)down right:(CGFloat)right;
-(void)setSlide:(UIView*)view andSlideColor:(UIColor*)color;
@end
