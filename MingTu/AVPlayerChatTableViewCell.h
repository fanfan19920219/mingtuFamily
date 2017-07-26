//
//  AVPlayerChatTableViewCell.h
//  MingTu
//
//  Created by zhangzhihua on 2017/7/26.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVPlayerChatTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *content;

+ (instancetype)qqFriendMessageCellWithTableView:(UITableView *)tableView;


@end
