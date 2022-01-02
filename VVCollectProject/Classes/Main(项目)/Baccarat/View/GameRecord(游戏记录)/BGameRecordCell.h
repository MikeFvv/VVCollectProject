//
//  BaccaratCell.h
//  VVCollectProject
//
//  Created by Mike on 2019/2/22.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGameRecordCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;

@property (nonatomic, assign) NSInteger index;
// strong注释
@property (nonatomic, strong) id model;

@end

NS_ASSUME_NONNULL_END
