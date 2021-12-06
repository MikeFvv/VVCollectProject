//
//  MXWAdTimerAlertView.m
//  小黄鸭
//
//  Created by Admin on 2021/12/3.
//  Copyright © 2021 iOS. All rights reserved.
//


#define BaseTag      100

#define kMXWItemViewWidth  260
#define kMXWItemViewHeight  345


#import "MXWAdTimerAlertView.h"
#import "MXWAdModel.h"



@interface MXWAdTimerAlertView()<UIScrollViewDelegate>
{
    UIPageControl   *pageControl;
    UIButton        *cancelBtn;
    NSString        *placeHolderImgStr;
}
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)NSInteger    itemsCount;
@property(nonatomic,strong)NSArray      *adDataList;
@property(nonatomic,assign)BOOL         hiddenPageControl;
@end


@implementation MXWAdTimerAlertView


+(MXWAdTimerAlertView *)showInView:(UIView *)view theDelegate:(id)delegate theADInfo: (NSArray *)dataList placeHolderImage: (NSString *)placeHolderStr{
    if (!dataList) {
        return nil;
    }
    
    MXWAdTimerAlertView *sqAlertView = [[MXWAdTimerAlertView alloc] initShowInView:view theDelegate:delegate theADInfo:dataList placeHolderImage:placeHolderStr];
    return sqAlertView;
}
- (instancetype)initShowInView:(UIView *)view theDelegate:(id)delegate
                     theADInfo:(NSArray *)dataList
              placeHolderImage: (NSString *)placeHolderStr{
    self = [super init];
    if (self) {
        self.frame = view.bounds;
        
        self.backgroundColor    = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        placeHolderImgStr       = placeHolderStr;
        self.delegate           = delegate;
        self.hiddenPageControl  = NO;
        self.adDataList         = dataList;
        
        [[[UIApplication sharedApplication].windows objectAtIndex:0] endEditing:YES];
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
        
        [self showAlertAnimation];
        // 全屏幕点击消失
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromCurrentView:)];
//        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
- (void)showAlertAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue         = [NSNumber numberWithFloat:0];
    animation.toValue           = [NSNumber numberWithFloat:1];
    animation.duration          = 0.25;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animation forKey:@"opacity"];
}

-(void)removeFromCurrentView:(UIGestureRecognizer *)gesture
{
    UIView * subView    = (UIView *)[self viewWithTag:99];
    UIView * shadowView = self;
    if (CGRectContainsPoint(subView.frame, [gesture locationInView:shadowView])){
        
    }else{
        [self removeSelfFromSuperview];
    }
}
- (void)removeSelfFromSuperview
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, mxwScreenHeight()/2-kMXWItemViewHeight/2, mxwScreenWidth(), kMXWItemViewHeight)];
        _scrollView.backgroundColor         = [UIColor clearColor];
        _scrollView.userInteractionEnabled  = YES;
        _scrollView.contentSize     = CGSizeMake(30+(kMXWItemViewWidth+12)*_itemsCount, kMXWItemViewHeight);
        _scrollView.delegate        = self;
//        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
//        _scrollView.backgroundColor         = [UIColor redColor];
    }
    return _scrollView;
}
-(void)setAdDataList:(NSArray *)adDataList{
    
    _adDataList = adDataList;
    _itemsCount = adDataList.count;
    
    [self creatItemView];
}
-(void)creatItemView{
    
    if (_itemsCount == 0) {
        return;
    }
    
    CGFloat spacingWidth = 0;
    
    
    if (_itemsCount == 1) {
        self.hiddenPageControl = YES;
    }
    if (_itemsCount > 1) {
        spacingWidth = 12;
    }
    
    [self addSubview:self.scrollView];
    
    
    for ( int i = 0; i < _itemsCount; i++ ) {
        MXWAdModel *adModel = [_adDataList objectAtIndex:i];
        
        CGFloat leftMargin = (mxwScreenWidth()-kMXWItemViewWidth)/2;
        if (_itemsCount > 1) {
            leftMargin = 30 + i*(kMXWItemViewWidth+spacingWidth);
        }
        
        
        MXWItemView*item = [[MXWItemView alloc] initWithFrame:CGRectMake(leftMargin,0, kMXWItemViewWidth, kMXWItemViewHeight)];
        item.userInteractionEnabled = YES;
        item.index  = i;
        item.tag    = BaseTag+item.index;
//        item.imageView.image      = [UIImage imageNamed:adModel.imgStr];
       NSURL *aaaa = SERVER_IMAGE(adModel.imgStr);
        [item.imageView sd_setImageWithURL:SERVER_IMAGE(adModel.imgStr) placeholderImage:[UIImage imageNamed:@"com_ph_video"]];
        
        
//        /uploads/images/products/activity/2021-12-02/1638413317.jpg
        item.count_down = adModel.countdown;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContentImgView:)];
        [item addGestureRecognizer:singleTap];
        [_scrollView addSubview:item];
    }
    
    cancelBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(mxwScreenWidth()/2-22, (mxwScreenHeight()/2+kMXWItemViewHeight/2)+25, 36, 36);
    [cancelBtn setImage:[UIImage imageNamed:@"104_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(removeSelfFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    //初始化pageControl
//    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, mxwScreenHeight()-120, mxwScreenWidth(), 20)];
//    pageControl.numberOfPages   = _itemsCount;
//    pageControl.currentPage     = 0;
//    [pageControl addTarget:self action:@selector(pageValueChange:) forControlEvents:UIControlEventValueChanged];
//    pageControl.hidden          = self.hiddenPageControl;
//
//    [self addSubview:pageControl];
}
-(void)tapContentImgView:(UITapGestureRecognizer *)gesture{
    UIView *imageView = gesture.view;
    NSInteger itemTag = (long)imageView.tag-BaseTag;
    if ([self.delegate respondsToSelector:@selector(clickAlertViewAtIndex:)]){
        [self.delegate clickAlertViewAtIndex:itemTag];
        [self removeSelfFromSuperview];
    }
}

-(void)pageValueChange:(UIPageControl*)page{
    
    [UIView animateWithDuration:.35 animations:^{
        _scrollView.contentOffset = CGPointMake(page.currentPage*mxwScreenWidth(), 0);
    }];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index         = scrollView.contentOffset.x/mxwScreenWidth();
    pageControl.currentPage = index;
}

@end

/************分**********割**********线************/
//自定义中间主界面
@implementation MXWItemView

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews {
    self.userInteractionEnabled = YES;
    self.layer.masksToBounds    = YES;
    self.layer.cornerRadius     = 5;
    self.layer.shadowOpacity    = .2;
    self.layer.shadowOffset     = CGSizeMake(0, 2.5);
    self.layer.shadowColor      = [UIColor clearColor].CGColor;
    
    [self addSubview:self.imageView];
    [self addSubview:self.countdownTimeLabel];
    
    [self createTimer];
}
-(UIImageView *)imageView {
    if (!_imageView) {
//        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height-10)];
        _imageView.backgroundColor        = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.masksToBounds    = YES;
        
    }
    return _imageView;
}

#pragma mark -  倒计时功能
-(UILabel *)countdownTimeLabel {
    if (!_countdownTimeLabel) {
        _countdownTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, self.bounds.size.width-(70+10), 20)];
        _countdownTimeLabel.text = @"此商品还有12小时59分钟59秒";
        _countdownTimeLabel.font = [UIFont fontWithName:@"PingFang SC" size:12];
        _countdownTimeLabel.textColor = [UIColor whiteColor];
        _countdownTimeLabel.textAlignment = NSTextAlignmentLeft;
        _countdownTimeLabel.adjustsFontSizeToFitWidth = YES;
        _countdownTimeLabel.backgroundColor        = [UIColor clearColor];
    }
    return _countdownTimeLabel;
}

- (void)createTimer {
    
    self.mxwTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(changLongTimeAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.mxwTimer forMode:NSRunLoopCommonModes];
}


- (void)changLongTimeAction {
    
    _count_down = _count_down-1;
    
//    for (int i = 0; i < self.changLongDataArray.count; i++) {
//        MFHChangLongDataModel *model = self.changLongDataArray[i];
//        [model countDown];
//    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kChangLongTimeCellNotification object:nil];
    
    [self mxwTimerClosedCountDown:_count_down];
}


/// 参数不为空是添加，为空时移除  mike<<< 移除定时器
/// @param newWindow newWindow
-(void)willMoveToWindow:(UIWindow *)newWindow{
    if (!newWindow) {
        if (_mxwTimer) {
            [_mxwTimer invalidate];
            _mxwTimer = nil;
        }
    }
}

-(void)dealloc {
    [_mxwTimer invalidate];
    _mxwTimer = nil;
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -  倒计时
// 倒计时定时器处理逻辑
-(void)mxwTimerClosedCountDown:(NSInteger)seconds {
    
    if(seconds <= 0) { 
        self.countdownTimeLabel.text =  @"--";
        
    } else {
        
       NSString *tempTimeStr = [NSString stringWithFormat:@"此商品还有%@",[self getHHMMSSFromSS: [NSString stringWithFormat:@"%zd",seconds] isShowDay:YES]];
        self.countdownTimeLabel.text = tempTimeStr;
    }
}

/// 传入秒 转换 为时间类型字符串  得到 xx:xx:xx 或 xx:xx
/// @param totalTime 总秒数
/// @param isShowDay 是否显示天数 ， NO 直接显示小时数
- (NSString *)getHHMMSSFromSS:(NSString *)totalTime isShowDay:(BOOL)isShowDay {
    NSInteger seconds = [totalTime integerValue];
    // 小时
    NSString *str_hour = nil;
    if(seconds/3600/24 > 0) {
        if (isShowDay) {
            str_hour = [NSString stringWithFormat:@"%ld天%02ld",seconds/3600/24,seconds%(3600*24)/3600];
        } else {
            str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
        }
    } else {
        str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    }
    // 分钟
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    // 秒
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    
    // 时间格式
    NSString *format_time;
    if(![str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@小时%@分钟%@秒",str_hour,str_minute,str_second];
    } else if (![str_minute isEqualToString:@"00"] || ![str_second isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];
    } else {
        format_time = @"00分钟00秒";
    }
    return format_time;
}

@end


