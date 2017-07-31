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
    AVPlayerContentModel *playerModel = [_dataArray objectAtIndex:indexPath.row];
    CGFloat height = 44;
    if([self setContentSize:playerModel.userContent]>44){
        int num= floor([self setContentSize:playerModel.userContent]/44);
        height = 44+ 20*(num);
    }
    return height;
}

-(CGFloat)setContentSize:(NSString *)stringContent{
    NSMutableParagraphStyle *paragraphrpStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphrpStyle.lineSpacing = 5;
    NSDictionary *attributesrp = @{NSFontAttributeName: [UIFont systemFontOfSize:15 weight:0.001],NSParagraphStyleAttributeName:paragraphrpStyle,NSForegroundColorAttributeName:[UIColor grayColor]};
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 220, 30000);
    CGRect labelSize = [stringContent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesrp context:nil];
    return labelSize.size.height;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"AVPlayerChatTableViewCell";//这里的cellID就是cell的xib对应的名称
    AVPlayerChatTableViewCell *cell = (AVPlayerChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(nil == cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIndentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    AVPlayerContentModel *playerModel = [_dataArray objectAtIndex:indexPath.row];
    @try {
        cell.cell_name.text = [NSString stringWithFormat:@"%@:",playerModel.userName];
        cell.cell_content.text = playerModel.userContent;
    } @catch (NSException *exception) {
    } @finally {
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
