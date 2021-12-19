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
/// 大眼路
@property (nonatomic, strong) UIScrollView *dyl_ScrollView;

@property (nonatomic, assign) MapColorType dyl_lastColorType;
/// 大路 最后一个Label
@property (nonatomic, strong) UILabel *dyl_lastLabel;
/// 记录长龙个数
@property (nonatomic, assign) NSInteger dyl_longNum;
/// 记录长龙的最小 X
@property (nonatomic, assign) CGFloat dyl_longMinX;
/// 记录最大的 x 值
@property (nonatomic, assign)CGFloat dyl_maxXValue;
/// 记录当前长龙最低下第一个 label
@property (nonatomic, strong) UILabel *dyl_changLongBottomLbl;
/// 记录前一路最后一个Label
@property (nonatomic, strong) UILabel *dyl_frontLastLabel;
/// 记录一条路
@property (nonatomic, strong) NSMutableArray *dyl_yiluArray;

@end

@implementation BaccaratXiaSanLuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


#pragma mark -  大眼路
/// 大眼路视图
- (void)daYanLu_createItems {
    
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
    [self.dyl_ScrollView addSubview:label];
    
    MapColorType colorType = [self.dyl_DataArray.lastObject integerValue];
    
    if (colorType == ColorType_Red) {
        label.backgroundColor = [UIColor redColor];
    } else if (colorType == ColorType_Blue) {
        label.backgroundColor = [UIColor blueColor];
    } else {
        NSLog(@"🔴🔴🔴未知🔴🔴🔴");
    }
    
    
    if (self.dyl_DataArray.count == 1) {
        label.frame = CGRectMake(x, y, w, h);
        self.dyl_longNum = 1;
        [self.dyl_yiluArray addObject:@(colorType)];
    } else {
        
        BOOL isLong = NO;
        if (colorType == self.dyl_lastColorType) {
            isLong = YES;
        }
        
        if (isLong) {
            // 计算最大可使用空白格数
            NSInteger maxBlankColumns = 6;
            CGFloat lastLabelX = CGRectGetMaxX(self.dyl_frontLastLabel.frame);
            CGFloat lastLabelY = CGRectGetMinY(self.dyl_frontLastLabel.frame);
            if (lastLabelX > 0 && lastLabelX >= CGRectGetMaxX(self.dyl_lastLabel.frame)) {
                maxBlankColumns = lastLabelY/(w +margin);
            }
            
            // 记录连续相同的结果个数
            self.dyl_longNum += 1;
            if (self.dyl_longNum <= maxBlankColumns) {
                self.dyl_longMinX = self.dyl_lastLabel.x;
                x = self.dyl_lastLabel.x;
                label.frame = CGRectMake(x, CGRectGetMaxY(self.dyl_lastLabel.frame) + margin, w, h);
            } else {
                x = CGRectGetMaxX(self.dyl_lastLabel.frame) + margin;
                label.frame = CGRectMake(x, self.dyl_lastLabel.y, w, h);
            }
            
            if (x > self.dyl_maxXValue) {
                self.dyl_maxXValue = x;
            }
            [self.dyl_yiluArray addObject:@(colorType)];
        } else {
            
            // 开头第一个
            if (self.dyl_yiluArray.count > 0) {
                self.dyl_yiluArray = nil;
                self.dyl_frontLastLabel = self.dyl_lastLabel;
            }
            
            
            y = 0;
            // 最顶上的长龙时处理 极端情况
            CGFloat lastLabelY = CGRectGetMinY(self.dyl_frontLastLabel.frame);
            if (lastLabelY == 0) {
                CGFloat lastLabelX = CGRectGetMaxX(self.dyl_frontLastLabel.frame);
                x = lastLabelX + margin;
            } else {
                x = self.dyl_longMinX + w + margin;
            }
            
            if (x > self.dyl_maxXValue) {
                self.dyl_maxXValue = x;
            }
            label.frame = CGRectMake(x, y, w, h);
            // 相同开奖结果清空
            self.dyl_longNum = 1;
            [self.dyl_yiluArray addObject:@(colorType)];
            self.dyl_longMinX = CGRectGetMinX(label.frame);
        }
    }
    
    if (self.dyl_maxXValue + w + margin > (self.bounds.size.width - 50)){
        if ((self.dyl_maxXValue + w + margin) != (CGRectGetMaxX(self.dyl_lastLabel.frame) + margin)) {
            // 移动位置
            [UIView animateWithDuration:0.1 animations:^{
                [self.dyl_ScrollView setContentOffset:CGPointMake(self.dyl_maxXValue + w + margin - (self.bounds.size.width - 50), 0) animated:YES];
            }];
        }
    }
    
    
    self.dyl_lastLabel = label;
    self.dyl_lastColorType = colorType;
    
}






- (void)createUI {
    [self addSubview:self.dyl_ScrollView];
    
}

- (UIScrollView *)dyl_ScrollView {
    if (!_dyl_ScrollView) {
        _dyl_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        _dyl_ScrollView.delegate = self;
        _dyl_ScrollView.backgroundColor = [UIColor whiteColor];
        _dyl_ScrollView.contentSize = CGSizeMake(1000, 0);
        _dyl_ScrollView.layer.borderWidth = 1;
        _dyl_ScrollView.layer.borderColor = [UIColor redColor].CGColor;
        _dyl_maxXValue = 0;
        _dyl_longNum = 0;
        
        _dyl_ScrollView.backgroundColor = [UIColor randomColor];
    }
    return _dyl_ScrollView;
}



- (NSMutableArray *)dyl_yiluArray {
    if (!_dyl_yiluArray) {
        _dyl_yiluArray = [NSMutableArray array];
    }
    return _dyl_yiluArray;
}


@end




