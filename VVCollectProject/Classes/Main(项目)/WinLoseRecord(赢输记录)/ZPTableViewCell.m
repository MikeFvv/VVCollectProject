//
//  ZPTableViewCell.m
//  用storyboard自定义等高的cell
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPTableViewCell.h"
#import "WinLoseModel.h"

@interface ZPTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end

@implementation ZPTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"deal";
    
    ZPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZPTableViewCell class]) owner:nil options:nil] lastObject];
    }
    
    return cell;
}

-(void)setDeal:(WinLoseModel *)deal
{
    _deal = deal;
    self.titleLabel.text = deal.title;
//    self.money.text = [NSString stringWithFormat:@"￥ %@", deal.money;
//    self.des.text = [NSString stringWithFormat:@"%@人已购买", deal.des];
}

@end
