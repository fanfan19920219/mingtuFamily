//
//  PersonalTableViewCell.m
//  MingTu
//
//  Created by M-SJ077 on 2017/2/7.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "PersonalTableViewCell.h"

@interface PersonalTableViewCell ()
@end


@implementation PersonalTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self){
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
