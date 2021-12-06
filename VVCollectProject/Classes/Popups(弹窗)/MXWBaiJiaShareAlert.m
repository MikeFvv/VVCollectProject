//
//  MXWBaiJiaShareAlert.m
//  小黄鸭
//
//  Created by blom on 2021/11/23.
//  Copyright © 2021 iOS. All rights reserved.
//

#import "MXWBaiJiaShareAlert.h"
#import "UIColor+Hex.h"
//#import "HMScannerController.h"


@interface MXWBaiJiaShareAlert()

/** 版本号 */
@property (nonatomic, copy) NSString *version;
/** 版本更新内容 */
@property (nonatomic, copy) NSString *desc;
/// <#strong属性#>
@property (nonatomic, strong) UIImageView *logoImgView;
/// <#strong属性#>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *contentImgView;
///二维码
@property (nonatomic,strong) UIImageView *qrCodeIcon;

@end

@implementation MXWBaiJiaShareAlert


+ (void)showBaiJiaVideoShoreAlert
{
    MXWBaiJiaShareAlert *updateAlert = [[MXWBaiJiaShareAlert alloc] initShoreAlert];
    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
}

- (instancetype)initShoreAlert
{
    self = [super init];
    if (self) {
//        self.version = version;
//        self.desc = description;
        
        [self _setupUI];
        [self createQrImage];
    }
    return self;
}


-(void)setDataDict:(NSDictionary *)dataDict{
//    EPVUserInfoModel *infoModel = [EPVUserInfoModel getUserInfoModel];

//    self.promotedCountLabel.text = [NSString stringWithFormat:@"已推广%@人",infoModel.level.invitees_number];
//    self.ruleContentLabel.text = dataDict[@"rule"];
//    self.totalPointLabel.text = [NSString stringWithFormat:@"共计赚取%@金币",dataDict[@"gold_num"]];
}


-(void)createQrImage {
//    NSString * cardName = [EPVUserInfoModel getUserInfoModel].link;
//    UIImage * avatar = IMAGE_NAMED(@"logo");
    
    // 二维码控件
//    [HMScannerController cardImageWithCardName:cardName avatar:avatar scale:0.2 completion:^(UIImage *image) {
//        self.qrCodeIcon.image = image;
//        //6self.qrImageView.image = image;
//    }];
}

- (UIImageView *)qrCodeIcon {
    if (!_qrCodeIcon) {
        _qrCodeIcon = [UIImageView new];
    }
    return _qrCodeIcon;
}

- (void)_setupUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
    
    //添加手势事件  添加事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
    //将手势添加到需要相应的view中去
    [self addGestureRecognizer:tapGesture];
    //选择触发事件的方式（默认单机触发）
    [tapGesture setNumberOfTapsRequired:1];
    
    
    //bgView最大高度
    CGFloat maxHeight = 463;
    
    //backgroundView
    UIView *bgView = [[UIView alloc]init];
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
    bgView.center = self.center;
    bgView.bounds = CGRectMake(0, 0, self.frame.size.width - mxwRealHeight(40), maxHeight);
    [self addSubview:bgView];
    
    //    bgView.backgroundColor = [UIColor gradientFromColor:RGB(251, 233, 204) toColor:RGB(225, 190, 131) withHeight:maxHeight];
    bgView.backgroundColor = RGB(255, 227, 98);
    
    
    UIView *contentView = [[UIView alloc] init];
    contentView.layer.cornerRadius = 10;
    contentView.layer.masksToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(bgView).offset(8);
        make.bottom.right.equalTo(bgView).offset(-8);
    }];
    
    
    
    UIImageView *logoImgView = [[UIImageView alloc] init];
    logoImgView.userInteractionEnabled = YES;
    logoImgView.image = [UIImage imageNamed:@"235_logo"];
    logoImgView.contentMode = UIViewContentModeScaleAspectFill;
    logoImgView.userInteractionEnabled = YES;
    logoImgView.layer.cornerRadius = 8;
    logoImgView.layer.masksToBounds = YES;
    [contentView addSubview:logoImgView];
    _logoImgView = logoImgView;
    
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(contentView).offset(16);
        make.size.mas_equalTo(50);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"--";
    titleLabel.font =  [UIFont fontWithName:@"PingFang SC" size:18];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 2;
    [contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImgView.mas_top).offset(1);
        make.left.equalTo(logoImgView.mas_right).offset(8);
        make.right.equalTo(contentView.mas_right).offset(-25);
    }];
    
    
    
    UIImageView *contentImgView = [[UIImageView alloc] init];
    contentImgView.userInteractionEnabled = YES;
    contentImgView.image = [UIImage imageNamed:@"com_ph_video"];
    contentImgView.contentMode = UIViewContentModeScaleAspectFill;
    //    contentImgView.userInteractionEnabled = YES;
    //    contentImgView.layer.cornerRadius = 8;
        contentImgView.layer.masksToBounds = YES;
    [contentView addSubview:contentImgView];
    _contentImgView = contentImgView;
    
    [contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImgView.mas_bottom).offset(16);
        make.left.equalTo(contentView.mas_left).offset(16);
        make.right.equalTo(contentView.mas_right).offset(-16);
        make.height.mas_equalTo(182);
    }];
    
    
    
    [contentView addSubview:self.qrCodeIcon];
    [self.qrCodeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentImgView.mas_bottom).offset(16);
        make.left.equalTo(contentView.mas_left).offset(25);
        make.size.mas_equalTo(90);
    }];
    
    
    UILabel *titssLabel = [[UILabel alloc] init];
    titssLabel.text = @"扫描二维码\n下载APP立即观看";
    titssLabel.font =  [UIFont fontWithName:@"PingFang SC" size:20];
    titssLabel.textAlignment = NSTextAlignmentLeft;
    titssLabel.textColor = [UIColor blackColor];
    titssLabel.numberOfLines = 2;
    [contentView addSubview:titssLabel];

    [titssLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrCodeIcon.mas_top).offset(0);
        make.left.equalTo(self.qrCodeIcon.mas_right).offset(10);
        make.right.equalTo(contentView.mas_right).offset(-22);
    }];

    NSString *eeStr = [NSString stringWithFormat:@"若二维码无法打开请输入网址"];

    UILabel *titDLabel = [[UILabel alloc] init];
    titDLabel.text = eeStr;
    titDLabel.font =  [UIFont fontWithName:@"PingFang SC" size:12];
    titDLabel.textAlignment = NSTextAlignmentLeft;
    titDLabel.textColor = [UIColor blackColor];
    titDLabel.numberOfLines = 1;
    [contentView addSubview:titDLabel];

    [titDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titssLabel.mas_bottom).offset(0);
        make.left.equalTo(self.qrCodeIcon.mas_right).offset(10);
        make.right.equalTo(contentView.mas_right).offset(-22);
    }];
    
    
    // 保存按钮
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    linkButton.backgroundColor = RGB(255, 227, 98);
//    linkButton.clipsToBounds = YES;
//    linkButton.layer.cornerRadius = 44/2;
    linkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [linkButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [linkButton setTitle:@"https://xxxxxx.xxxx" forState:UIControlStateNormal];
    [linkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [contentView addSubview:linkButton];
    
    [linkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.qrCodeIcon.mas_bottom).offset(0);
        make.left.equalTo(self.qrCodeIcon.mas_right).offset(10);
        make.right.equalTo(contentView.mas_right).offset(-22);
    }];
    
    
    // 保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    saveButton.backgroundColor = RGB(255, 227, 98);
    saveButton.clipsToBounds = YES;
    saveButton.layer.cornerRadius = 44/2;
    [saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"保存图片分享" forState:UIControlStateNormal];
    [saveButton setTitleColor:RGB(98, 65, 24) forState:UIControlStateNormal];
    [contentView addSubview:saveButton];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(20);
        make.bottom.equalTo(contentView.mas_bottom).offset(-20);
        make.right.equalTo(contentView.mas_centerX).offset(-5);
        make.height.mas_equalTo(44);
    }];
    
    
    //复制分享按钮
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    copyButton.backgroundColor = RGB(255, 227, 98);
    copyButton.clipsToBounds = YES;
    copyButton.layer.cornerRadius = 44/2;
    [copyButton addTarget:self action:@selector(copyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [copyButton setTitle:@"复制分享链接" forState:UIControlStateNormal];
    [copyButton setTitleColor:RGB(98, 65, 24) forState:UIControlStateNormal];
    [contentView addSubview:copyButton];
    
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-20);
        make.bottom.equalTo(contentView.mas_bottom).offset(-20);
        make.left.equalTo(contentView.mas_centerX).offset(5);
        make.height.mas_equalTo(44);
    }];
    
    
    
    //显示更新
    [self showWithAlert:bgView];
}



-(void)copyButtonAction {
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    DLog(@"%@",[EPVUserInfoModel getUserInfoModel].link_text);
//    pasteboard.string = [EPVUserInfoModel getUserInfoModel].link_text;
//    [MBProgressHUD showSuccessMessage:@"复制推广链接成功"];
//    [[SensorsAnalyticsSDK sharedInstance] track:@"InviteFriend" withProperties:@{@"invite_entrance":self.entryStr,@"invitebutton_type":@"分享推广链接"}];
}
-(void)saveButtonAction {
    
    UIImage * image = self.qrCodeIcon.image;
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
//    NSString *msg = nil ;
//    if(error != NULL){
//        msg = @"保存图片失败" ;
//       
//        [MBProgressHUD showErrorMessage:NSStringFormat(@"请去设置->%@视频->打开添加图片权限", APPNameTitle)];
//      
//    }else{
//        msg = @"保存图片成功" ;
//        [[SensorsAnalyticsSDK sharedInstance] track:@"InviteFriend" withProperties:@{@"invite_entrance":self.entryStr,@"invitebutton_type":@"保存二维码"}];
//        [MBProgressHUD showSuccessMessage:msg];
//        
//        NSString * url = [NSString stringWithFormat:@"%@%@",URL_main,URL_User_TaskFinish];
//        
//        NSDictionary * ary = @{
//                               @"task_id":[EPVConfigModel getQrTaskID],
//                               
//                               };
//        
//        [EPVHTTPRequest requestWithPOSTURL:url parameters:ary success:^(id responseObject) {
//            NSInteger pointReward = [[responseObject objectForKey:@"point_reward"] integerValue];
//            if (@(pointReward).boolValue) {
//                [[SensorsAnalyticsSDK sharedInstance] track:@"GenerateGoldCoin" withProperties:@{@"generate_method":@"保存二维码",@"generate_quantity":@(pointReward)}];
//            }
//            DLog(@"%@",responseObject);
//        } failure:^(NSError *error) {
//            
//        }];
//    }
}









/** 取消按钮点击事件 */
- (void)cancelAction
{
    [self dismissAlert];
}

/**
 添加Alert入场动画
 @param alert 添加动画的View
 */
- (void)showWithAlert:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6f;  // 入场出场动画时间
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}


/** 添加Alert出场动画 */
- (void)dismissAlert{
    
    [UIView animateWithDuration:0.6f animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

/**
 计算字符串高度
 @param string 字符串
 @param font 字体大小
 @param maxSize 最大Size
 @return 计算得到的Size
 */
- (CGSize)_sizeofString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}




@end

