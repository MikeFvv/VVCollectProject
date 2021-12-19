//
//  BaccaratXiaSanLuView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BaccaratXiaSanLuView.h"
#import "UIView+Extension.h"

@interface BaccaratXiaSanLuView ()

/// 下三路
@property (nonatomic, strong) UIScrollView *xsl_ScrollView;

// ****** 下三路 ******

/// 记录最后一个数据
@property (nonatomic, assign) MapColorType xsl_lastModel;
/// 下三路 最后一个Label
@property (nonatomic, strong) UILabel *xsl_lastLabel;
/// 记录当前长龙个数
@property (nonatomic, assign) NSInteger currentLongNum;
/// 记录当前列的最小 X
@property (nonatomic, assign) CGFloat currentColMinX;
/// 记录所有列 最大Label的 x 值(取值是minX)
@property (nonatomic, assign) CGFloat allColMaxLabelX;
/// 把前一列大于等于当前X值的最后一个Label 记录,  用来判断长龙拐弯的的最后一个，动态移除X 小于当前的Label
@property (nonatomic, strong) NSMutableArray<UILabel *> *allBigColLastLabelArray;
/// 记录前一列最后一个Label
@property (nonatomic, strong) UILabel *frontColLastLabel;
/// 记录一条路
@property (nonatomic, strong) NSMutableArray *oneColArray;

@property (nonatomic, strong) NSMutableArray *xsl_DataArray;

@end

@implementation BaccaratXiaSanLuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createUI];
    }
    return self;
}

- (void)initData {
    _allColMaxLabelX = 0;
    _currentLongNum = 0;
}

- (void)createUI {
    [self addSubview:self.xsl_ScrollView];
}

- (void)setModel:(id)model {
    _model = model;
    self.xsl_DataArray = [NSMutableArray arrayWithArray:(NSArray *)model];
    [self xsl_createItems];
    
    NSLog(@"1");
}


#pragma mark -  下三路
- (void)xsl_createItems {
    
    CGFloat margin = 1;
    CGFloat w = 16;
    CGFloat h = 16;
    CGFloat x = 0;
    CGFloat y = 0;
    
    
    
    UILabel *label = [[UILabel alloc] init];
    label.layer.masksToBounds = YES;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = w/2;
    [self.xsl_ScrollView addSubview:label];
    
    
    MapColorType colorType = [self.xsl_DataArray.lastObject integerValue];
    
    if (colorType == ColorType_Red) {
        label.backgroundColor = [UIColor redColor];
    } else if (colorType == ColorType_Blue) {
        label.backgroundColor = [UIColor blueColor];
    } else {
        NSLog(@"🔴🔴🔴未知🔴🔴🔴");
    }
    
    
    if (self.xsl_DataArray.count == 1) {
        label.frame = CGRectMake(x, y, w, h);
        self.currentLongNum = 1;
        [self.oneColArray addObject:@(colorType)];
    } else {
        
        BOOL isLong = NO;
        if (colorType == self.xsl_lastModel) {
            isLong = YES;
        }
        if (isLong) {
            // 计算最大可使用空白格数
            NSInteger maxBlankColumns = 6;
            
            //            CGFloat lastLabelX = CGRectGetMaxX(self.frontColLastLabel.frame);
            //            CGFloat lastLabelY = CGRectGetMinY(self.frontColLastLabel.frame);
            
            UILabel *tailLabel = [self getMinYLabelColX:self.currentColMinX];
            tailLabel = tailLabel ? tailLabel : self.frontColLastLabel;
            CGFloat lastLabelX = CGRectGetMaxX(tailLabel.frame);
            CGFloat lastLabelY = CGRectGetMinY(tailLabel.frame);
            
            
            if (lastLabelX > 0 && lastLabelX >= CGRectGetMaxX(self.xsl_lastLabel.frame)) {
                maxBlankColumns = lastLabelY/(w +margin);
            }
            
            // 记录连续相同的结果个数
            self.currentLongNum += 1;
            if (self.currentLongNum <= maxBlankColumns) {  // 长龙向下
                self.currentColMinX = self.xsl_lastLabel.x;
                x = self.xsl_lastLabel.x;
                label.frame = CGRectMake(x, CGRectGetMaxY(self.xsl_lastLabel.frame) + margin, w, h);
                
            } else {
                // 长龙拐弯
                x = CGRectGetMaxX(self.xsl_lastLabel.frame) + margin;
                label.frame = CGRectMake(x, self.xsl_lastLabel.y, w, h);
                
                
                if (CGRectGetMinY(label.frame) == 0) {  // 极端特殊情况下，第一行长龙，需要把初始值矫正
                    self.currentColMinX = CGRectGetMinX(label.frame);
                }
            }
            
            if (x > self.allColMaxLabelX) {
                self.allColMaxLabelX = x;
            }
            [self.oneColArray addObject:@(colorType)];
        } else {
            
            // *** 开头第一个 ***
            
            self.oneColArray = nil;
            // 前一列最后一个 Label
            self.frontColLastLabel = self.xsl_lastLabel;
            
            
            y = 0;
            // 最顶上的长龙时处理 极端情况
            CGFloat lastLabelY = CGRectGetMinY(self.frontColLastLabel.frame);
            if (lastLabelY == 0) {
                CGFloat lastLabelX = CGRectGetMaxX(self.frontColLastLabel.frame);
                x = lastLabelX + margin;
            } else {
                x = self.currentColMinX + w + margin;
            }
            
            if (x > self.allColMaxLabelX) {
                self.allColMaxLabelX = x;
            }
            label.frame = CGRectMake(x, y, w, h);
            // 相同开奖结果清空
            self.currentLongNum = 1;
            [self.oneColArray addObject:@(colorType)];
            self.currentColMinX = CGRectGetMinX(label.frame);
            
            // 把前一列大于等于当前X值的最后一个Label 记录
            if (CGRectGetMaxX(self.xsl_lastLabel.frame) >= CGRectGetMaxX(label.frame)) {
                [self.allBigColLastLabelArray addObject:self.xsl_lastLabel];
            }
            
        }
    }
    
    if (self.allColMaxLabelX + w + margin > (self.bounds.size.width - 50)){ // 下三路闲庄路X大于整个屏幕时往后自动移动位置，好观看
        if ((self.allColMaxLabelX + w + margin) != (CGRectGetMaxX(self.xsl_lastLabel.frame) + margin)) {
            // 移动位置
            [UIView animateWithDuration:0.1 animations:^{
                [self.xsl_ScrollView setContentOffset:CGPointMake(self.allColMaxLabelX + w + margin - (self.bounds.size.width - 50), 0) animated:YES];
            }];
        }
    }
    
    self.xsl_lastLabel = label;
    self.xsl_lastModel = colorType;
}




/// 获得最小的Y 值 Label
/// @param currentColX 当前X值
- (UILabel *)getMinYLabelColX:(CGFloat)currentColX {
    
    UILabel *tempLabel = nil;
    CGFloat minY = (16 +1) * 6;
    for (UILabel *label in self.allBigColLastLabelArray.reverseObjectEnumerator) {  //  对数组逆序遍历，然后再删除元素就没有问题了。
        CGFloat oldX = CGRectGetMaxX(label.frame);
        CGFloat oldY = CGRectGetMaxY(label.frame);
        if (oldX >= currentColX) {  // 大于等于当前 X
            if (oldY < minY) {
                minY = oldY;
                tempLabel = label;  // 记录这个Label
            }
        } else {  // 否则移除小于当前的X 值Label
            [self.allBigColLastLabelArray removeObject:label];
        }
    }
    return tempLabel;
}

- (UIScrollView *)xsl_ScrollView {
    if (!_xsl_ScrollView) {
        _xsl_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        _xsl_ScrollView.delegate = self;
        _xsl_ScrollView.backgroundColor = [UIColor whiteColor];
        _xsl_ScrollView.contentSize = CGSizeMake(1000, 0);
        _xsl_ScrollView.layer.borderWidth = 1;
        _xsl_ScrollView.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _xsl_ScrollView;
}

- (NSMutableArray *)xsl_DataArray {
    if (!_xsl_DataArray) {
        _xsl_DataArray = [NSMutableArray array];
    }
    return _xsl_DataArray;
}

- (NSMutableArray *)oneColArray {
    if (!_oneColArray) {
        _oneColArray = [NSMutableArray array];
    }
    return _oneColArray;
}

- (NSMutableArray *)allBigColLastLabelArray {
    if (!_allBigColLastLabelArray) {
        _allBigColLastLabelArray = [NSMutableArray array];
    }
    return _allBigColLastLabelArray;
}


@end




