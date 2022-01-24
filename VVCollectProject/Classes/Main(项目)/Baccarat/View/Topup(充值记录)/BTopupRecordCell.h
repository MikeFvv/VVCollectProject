//
//  BTopupRecordCell.h
//  VVCollectProject
//
//  Created by Admin on 2022/1/25.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BalanceRecordModel;

@interface BTopupRecordCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;

@property (nonatomic, assign) NSInteger index;
// strong注释
@property (nonatomic, strong) BalanceRecordModel *model;
@end

NS_ASSUME_NONNULL_END
