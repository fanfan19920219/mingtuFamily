//
//  AVplayerDownView.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/26.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "AVplayerDownView.h"

@implementation AVplayerDownView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)AView{
    return [[[NSBundle mainBundle]loadNibNamed:@"AVplayerDownView" owner:nil options:nil] objectAtIndex:0];
}

+(instancetype)BView{
    return [[[NSBundle mainBundle]loadNibNamed:@"AVplayerDownView" owner:nil options:nil] objectAtIndex:1];
}

-(void)setVideo_Name:(NSString*)name{
    self.VideoName.text = name;
}


@end
