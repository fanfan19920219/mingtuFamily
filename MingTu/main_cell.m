//
//  main_cell.m
//  MingTu
//
//  Created by zhangzhihua on 16/3/7.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "main_cell.h"
#import "Header.h"
#define cell_width  [UIScreen mainScreen].bounds.size.width
#define cell_height 70.0
// [ UIScreen mainScreen ].bounds.size.width
// [ UIScreen mainScreen ].bounds.size.height

@interface main_cell()

@property (nonatomic ,strong)UIImageView *showImageView;
@property (nonatomic , strong)UILabel *title_Label;
@property (nonatomic , strong)UILabel *time_Label;


@end


@implementation main_cell

-(instancetype)init{
    if(self){
        self = [super init];
        self.frame = CGRectMake(0, 0, cell_width, cell_height);
        self.showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        self.showImageView.image = [UIImage imageNamed:@"视频placeholer.jpg"];
        [self.showImageView setSlide:self.showImageView andSlideColor:nil];
        [self.contentView addSubview:self.showImageView];
        
        self.title_Label = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 150, 20)];
        self.title_Label.textColor = RGBA(44, 44, 44, 1);
        self.title_Label.font = [UIFont systemFontOfSize:16 weight:0.005];
        
        self.time_Label = [[UILabel alloc]initWithFrame:CGRectMake(80, cell_height - 20, 150, 20)];
        self.time_Label.textColor = RGBA(187, 187, 187, 1);
        self.time_Label.font = [UIFont systemFontOfSize:16 weight:0.005];

        [self.contentView addSubview:self.title_Label];
        [self.contentView addSubview:self.time_Label];
    }
    return self;
}

-(void)settime_label:(NSString *)timeString{
    self.time_Label.text = timeString;
}

-(void)settitle_label:(NSString *)titleString{
    self.title_Label.text = titleString;
}

@end
