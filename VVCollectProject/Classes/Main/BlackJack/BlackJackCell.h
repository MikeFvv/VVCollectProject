//
//  BlackJackCell.h
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/3/12.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlackJackCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;
// strong注释
@property (nonatomic,strong) id model;
@property (nonatomic, strong) UILabel *indexLabel;

@end

