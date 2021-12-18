//
//  BlackJackCell.h
//  VVCollectProject
//
//  Created by Mike on 2019/3/12.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BJWinOrLoseResultModel.h"

@interface BlackJackCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;
// strong注释
@property (nonatomic, strong) BJWinOrLoseResultModel *model;
@property (nonatomic, strong) UILabel *indexLabel;

@end

