//
//  CountDownController.m
//  VVCollectProject
//
//  Created by pt c on 2019/7/28.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "CountDownController.h"
#import "NSTimer+CQBlockSupport.h"

@interface CountDownController ()

@property (strong, nonatomic) UILabel *autoRefreshTimeLabel;
@property (nonatomic, strong) NSTimer *timer;

/** 倒计时开始值 */
@property (nonatomic, assign) NSInteger startCountDownNum;
/** 剩余倒计时的值 */
@property (nonatomic, assign) NSInteger restCountDownNum;

@end

@implementation CountDownController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *autoRefreshTimeLabel = [[UILabel alloc] init];
    autoRefreshTimeLabel.text = @"20s";
    autoRefreshTimeLabel.font = [UIFont systemFontOfSize:20];
    autoRefreshTimeLabel.textColor = [UIColor redColor];
    autoRefreshTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:autoRefreshTimeLabel];
    _autoRefreshTimeLabel = autoRefreshTimeLabel;
    
    [autoRefreshTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    _startCountDownNum = 10;
    [self startCountDown];
}



/** 开始倒计时 */
- (void)startCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _restCountDownNum = _startCountDownNum;
    
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer cq_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf p_handleCountDown];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.timer.fireDate = [NSDate distantPast];
}

/** 结束倒计时 */
- (void)endCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    // 重置剩余倒计时
    _restCountDownNum = _startCountDownNum;
    
    // 倒计时结束的回调
    [self endAction];
}


/** 处理倒计时进行中的事件 */
- (void)p_handleCountDown {
    // 调用倒计时进行中的回调
    [self countDownTimeing];
    
    if (_restCountDownNum == 0) { // 倒计时完成
        [self endCountDown];
        return;
    }
    _restCountDownNum --;
}


- (void)endAction {
    NSLog(@"结束");
    self.autoRefreshTimeLabel.text = [NSString stringWithFormat:@"%zd", self.restCountDownNum];
//    [self getChangLongData];
    [self startCountDown];
}

- (void)countDownTimeing {
    NSLog(@"1秒倒计时过程中");
    self.autoRefreshTimeLabel.text = [NSString stringWithFormat:@"%zd", self.restCountDownNum];
}



@end
