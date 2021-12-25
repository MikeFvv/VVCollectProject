//
//  BGameRecordsCell.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGameRecordsCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameMLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;
@end

NS_ASSUME_NONNULL_END
