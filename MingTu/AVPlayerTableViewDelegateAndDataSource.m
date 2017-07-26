//
//  AVPlayerTableViewDelegateAndDataSource.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/26.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "AVPlayerTableViewDelegateAndDataSource.h"
#import "AVPlayerChatTableViewCell.h"

@interface AVPlayerTableViewDelegateAndDataSource()

@property (nonatomic , strong)NSMutableArray *dataArray;
@property (nonatomic , strong)AVPlayerTableViewReturnBlock returnBlock;
@end


@implementation AVPlayerTableViewDelegateAndDataSource

#pragma mark - tableViewDelegate

-(instancetype)init_withdataArray:(NSMutableArray*)array withReturnBlock:(AVPlayerTableViewReturnBlock)returnBlock{
    if(self){
        self = [super init];
        self.dataArray = array;
        self.returnBlock = returnBlock;
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    AVPlayerChatTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AVPlayerChatTableViewCell" owner:nil options:nil] lastObject];
    }
    AVPlayerContentModel *model =[_dataArray objectAtIndex:indexPath.row];
//    cell.nickName.text = [NSString stringWithFormat:@"%@:",model.userName];
//    cell.content.text = model.userContent;
    return cell;
}

@end
