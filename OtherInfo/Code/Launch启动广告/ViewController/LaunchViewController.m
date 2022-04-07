//
//  LaunchViewController.m
//  小黄鸭
//
//  Created by Elite on 2021/12/6.
//  Copyright © 2021 iOS. All rights reserved.
//

#import "LaunchViewController.h"
#import "EPVTabBarController.h"
#import "EPVCycleCheckRequest.h"
#import "EPVVIPManager.h"
#import "EPVVideoAdInfoModel.h"
#import "GuideViewModel.h"

@interface LaunchViewController ()

@property (nonatomic) UIImageView           *topLauchImageView;
@property (nonatomic) UIButton              *timeCountBtn;
@property (nonatomic) NSTimer               *countDownTimer;
@property (nonatomic) NSInteger              adTime;
@property (nonatomic) EPVVideoAdInfoModel   *admodel;
@property (nonatomic) GuideViewModel        *viewModel;
@property (nonatomic) NSArray<AdvertisementModel *>       *_04_AdvertisementItems;

@end



@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [kNotificationCenter addObserver:self selector:@selector(getTokenSuccess) name:NOTI_GETTOKENSUCCESS object:nil];
    
    // 检查线路
    [self requestNewDataWithInfo];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 獲取底部 TabBar 配置
//    [self loadCustomTabBar];
}

// 獲取: 啟動廣告
- (void)loadLaunchAdvertisement {
    
    kWeakSelf(self)
    [VASNetwork loadAdvertisement:AdvertisementPositionLaunch success:^(NSMutableArray<AdvertisementModel *> * _Nonnull items) {
        [weakself set_04_AdvertisementItems:items];
        
        AdvertisementModel *item = items.firstObject;
        
        [weakself.topLauchImageView qj_setImageWithURL:SERVER_IMAGE(item.img_path)];
        [weakself onTimer];
                
#if TARGET_IPHONE_SIMULATOR
        weakself.adTime = 1;
#else
        weakself.adTime = 6;
#endif
        
        weakself.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    } failure:^(NSError * _Nonnull error) {
        [weakself closeLaunchImage];
    }];
}

- (void)requestNewDataWithInfo {
    [MBProgressHUD showActivityMessageInWindow:@"正在检查线路"];
    [EPVCycleCheckRequest requestCycleURLWithCallBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [EPVHTTPRequest requestBootStrap:^(id  _Nullable responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [kNotificationCenter postNotificationName:@"tokenChange" object:self];
                });
            } failure:^(NSError * _Nullable error) {
                [MBProgressHUD showErrorMessage:@"网络错误问题，请检测后重启动"];
            }];
        }else{
            [MBProgressHUD showErrorMessage:@"网络错误问题，请检测后重启动"];
        }
    }];
}

// 检查线路
//- (void)checkLines {
//    [MBProgressHUD showActivityMessageInWindow:@"正在检查线路"];
//
//    kWeakSelf(self)
//    [EPVCycleCheckRequest requestCycleURLWithCallBack:^(BOOL isSuccess) {
//        if (isSuccess) {
//            [MBProgressHUD hideHUD];
//
////            [weakself requestSettingList];
//
//            if ([EPVConfigModel getOwnToken].length > 0) {
//                [weakself getTokenSuccess];
//            }
//        } else {
//            DLog(@"App 被查封");
//            [MBProgressHUD hideHUD];
//            [MBProgressHUD showErrorMessage:@"线路全挂，稍后重试"];
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenChange" object:self];
//        }
//    }];
//}

- (void)startWebAdLaunCj {
    
//    DLog(@"1111111%@",[EPVConfigModel getSampleImageAddress:self.admodel.img_path]);
    
    UIImageView *lauchBackImageView = [UIImageView new];
    lauchBackImageView.tag = 666;
    lauchBackImageView.userInteractionEnabled = YES;
    
//    self.lauchBackImageView = lauchBackImageView;
    
    [self.view addSubview:lauchBackImageView];
    
    lauchBackImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    
    UIImageView *topLauchImageView = [UIImageView new];
    topLauchImageView.backgroundColor = UIColor.whiteColor;
    topLauchImageView.tag = 3100;
    topLauchImageView.userInteractionEnabled = YES;
    // UIViewContentModeScaleAspectFill 用图片内容来填充视图的大小，多余得部分可以被修剪掉来填充整个视图边界。
    topLauchImageView.contentMode = UIViewContentModeScaleToFill;
    [lauchBackImageView addSubview:topLauchImageView];
//    _topLauchImageView = topLauchImageView;
    
    self.topLauchImageView = topLauchImageView;
    
    UITapGestureRecognizer *ss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressed)];
    [topLauchImageView addGestureRecognizer:ss];
    
    //    topLauchImageView.backgroundColor = [UIColor redColor];
    
    topLauchImageView.sd_layout
        .topSpaceToView(lauchBackImageView, 0)
        .leftSpaceToView(lauchBackImageView, 0)
        .heightIs(KScreenHeight - (kBottomSafeAreaHeight + 110))
        .widthIs(KScreenWidth);
    
    [self loadLaunchAdvertisement];
    
    UIView *whiteView = [UIView new];
    whiteView.backgroundColor = UIColor.whiteColor;
    
    //    whiteView.backgroundColor = [UIColor greenColor];
    
    [lauchBackImageView addSubview:whiteView];
    
    whiteView.sd_layout
        .heightIs(kBottomSafeAreaHeight + 110)
        .bottomSpaceToView(lauchBackImageView, 0)
        .leftSpaceToView(lauchBackImageView, 0)
        .widthIs(KScreenWidth);
    
    UIImageView *logoImagV = [UIImageView new];
    logoImagV.image = IMAGE_NAMED(@"logo_default");
    [whiteView addSubview:logoImagV];
    
    logoImagV.sd_layout
        .centerXEqualToView(whiteView)
        .topSpaceToView(whiteView, 10)
        .widthIs(logoImagV.image.size.width)
        .heightIs(logoImagV.image.size.height)
    ;
    
    NSString *webStr = [EPVConfigModel getWebSite];
    if (webStr && webStr.length) {
        UIButton *linkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *linkStr = [NSString stringWithFormat:@"官网网址%@", webStr];
        [linkBtn setTitle:linkStr forState:UIControlStateNormal];
        linkBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [linkBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [linkBtn setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:204.0/255.0 blue:0.0 alpha:1.0]];
        linkBtn.layer.cornerRadius = 4;
        linkBtn.layer.masksToBounds = YES;
        [whiteView addSubview:linkBtn];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12]};
        CGSize size=[linkStr sizeWithAttributes:attrs];
        linkBtn.sd_layout
            .heightIs(20)
            .centerXEqualToView(whiteView)
            .topSpaceToView(logoImagV, 5)
            .widthIs(size.width + 20);
        [linkBtn addTarget:self action:@selector(linkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    UILabel *hintLabl = [UILabel new];
    hintLabl.font = SYSTEMFONT(14);
    hintLabl.textColor = UIColor.blackColor;
    hintLabl.text = @"禁止中国大陆和未满18岁用户访问";
    [whiteView addSubview:hintLabl];
    
    hintLabl.sd_layout
        .heightIs(20)
        .centerXEqualToView(logoImagV)
        .topSpaceToView(logoImagV, 32);
    
    [hintLabl setSingleLineAutoResizeWithMaxWidth:KScreenWidth];
    
    
    UIButton * btn = [UIButton new];
    [btn setTitle:@"查看详情" forState:UIControlStateNormal];
    [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [btn setBackgroundColor:RGBColor(3, 2, 8, 0.59)];
    btn.titleLabel.font = SYSTEMFONT(14);
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = UIColor.whiteColor.CGColor;
    
    self.timeCountBtn = btn;
    self.timeCountBtn.userInteractionEnabled = NO;
    
    ViewRadius(btn, 16);
    [lauchBackImageView addSubview:self.timeCountBtn];
    
    
    
    self.timeCountBtn.sd_layout
        .bottomSpaceToView(lauchBackImageView,  kBottomSafeAreaHeight + 110 + 35)
        .rightSpaceToView(lauchBackImageView, 20)
        .heightIs(32)
        .widthIs(90);
    
    //    btn.backgroundColor = [UIColor redColor];
    
}

- (void)linkBtnClick {
    NSURL *URL = [NSURL URLWithString:[EPVConfigModel getWebSite]];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
    }
}

- (void)loadCustomTabBar {
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", URL_main, @"bottom_nav"];
    
    [EPVHTTPRequest requestWithGETURL:URLString parameters:nil success:^(id responseObject) {
        id list = responseObject[@"list"];
        
        NSMutableArray <CustomTabBarModel *> *items = [CustomTabBarModel mj_objectArrayWithKeyValuesArray:list];
        
        if (items.count > 0) {
            Globe.customTabBarItems = items;
        }
    } failure:^(NSError *error) {
        // Nothing
    }];
}

- (void)didPressed {
    AdvertisementModel *hh = self._04_AdvertisementItems.firstObject;
    
    [Utils taskJump:self model:[hh modelToJSONObject]];
}

- (void)showTabBarViewController {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    EPVTabBarController *viewController     = [[EPVTabBarController alloc] init];

    //
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    Globe.tabBarViewController = viewController;
    Globe.tabBarNavigationController = navigationController;
    
    [window setRootViewController:navigationController];
    [window makeKeyAndVisible];
}

#pragma mark - 开启关闭动画
- (void)startcloseAnimation {
    
    // 還在倒計時中
    if (self.adTime > 0) {
        return;
    }
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.5;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.3];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    [self.lauchBackImageView.layer addAnimation:opacityAnimation forKey:@"animateOpacity"];
    [NSTimer scheduledTimerWithTimeInterval:opacityAnimation.duration
                                     target:self
                                   selector:@selector(closeLaunchImage)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)onTimer {
    [kNotificationCenter removeObserver:self name:@"lockFinish" object:nil];
    if (self.adTime == 0) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        if ([EPVVIPManager sharedInstance].isVIPUser) {
            [self startcloseAnimation];
        } else {
            self.timeCountBtn.userInteractionEnabled = YES;
            [self.timeCountBtn addTarget:self action:@selector(startcloseAnimation) forControlEvents:UIControlEventTouchUpInside];
            [self.timeCountBtn setTitle:@"关闭广告" forState:UIControlStateNormal];
        }
    } else {
        self.adTime -- ;
        if ([EPVVIPManager sharedInstance].isVIPUser) {
            [self.timeCountBtn setTitle:[NSString stringWithFormat:@"关闭广告%ld", self.adTime] forState:UIControlStateNormal];
            self.timeCountBtn.userInteractionEnabled = YES;
            [self.timeCountBtn addTarget:self action:@selector(startcloseAnimation) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [self.timeCountBtn setTitle:[NSString stringWithFormat:@"查看详情%ld", self.adTime] forState:UIControlStateNormal];
        }
    }
}

- (void)requestSettingList {
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_main, URL_Setting_List];
    
    kWeakSelf(self)
    [EPVHTTPRequest requestWithGETURL:url parameters:nil success:^(id responseObject) {
        NSDictionary *valueDic = [responseObject objectForKey:@"value"];
        NSString *webSite = [valueDic objectForKey:@"site"];
        
        [EPVConfigModel saveConfigwebSite:webSite];
        
        [weakself startWebAdLaunCj];
        
        DLog(@"websit ---- %@",[EPVConfigModel getWebSite]);
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
}

- (void)closeLaunchImage {
    for (UIView *view in self.lauchBackImageView.subviews) {
        [view removeFromSuperview];
    }
    [self.lauchBackImageView removeFromSuperview];
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
    
    [self showTabBarViewController];
}


- (void)getTokenSuccess {
    
    //
    [self requestSettingList];
    
    //
    
    //
    [self loadCustomTabBar];
    
    //
    [CurrentUser loadPersonProfile];
    
    //
    if (self.viewModel == nil) {
        self.viewModel = [[GuideViewModel alloc] init];
        [self.viewModel requestAuthorizationLocalNotification]; // 請求授權本地通知
        [self.viewModel loadLocalNotificationConfig];
    }
           
    // 獲取: 付款前綴地址
    [self loadPaymentPrefixAddress];
}

// 獲取: 付款前綴地址
- (void)loadPaymentPrefixAddress {
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_main, URL_LOAD_PAYMENT_LINE];
    
    [EPVHTTPRequest requestWithGETURL:url parameters:nil success:^(id  _Nullable responseObject) {
        Globe.paymentURLPrefix = responseObject[@"list"];
    } failure:^(NSError * _Nullable error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end
