//
//  VVSSessionViewController.m
//  VVCollectProject
//
//  Created by Mike on 2019/3/28.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "VVSSessionViewController.h"

//#import "YYModel.h"




#define headerImg1  @"http://10.10.15.175:8080/group1/M00/00/08/CgoPr1ybAWOAaNIHAAFLpTSM390606.png"
#define headerImg2  @"http://www.qqzhi.com/uploadpic/2014-09-14/004638238.jpg"
#define headerImg3  @"http://e.hiphotos.baidu.com/image/pic/item/5ab5c9ea15ce36d3b104443639f33a87e950b1b0.jpg"


/**
 *  Socket通信状态
 */
typedef NS_ENUM(NSInteger, NIMMessageType){
    /**
     *  文本类型消息
     */
    NIMMessageTypeText          = 0,
    /**
     *  图片类型消息
     */
    NIMMessageTypeImage         = 1,
    /**
     *  声音类型消息
     */
    NIMMessageTypeAudio         = 2,
    /**
     *  视频类型消息
     */
    NIMMessageTypeVideo         = 3,
    /**
     *  位置类型消息
     */
    NIMMessageTypeLocation      = 4,
    /**
     *  通知类型消息
     */
    NIMMessageTypeNotification  = 5,
    /**
     *  文件类型消息
     */
    NIMMessageTypeFile          = 6,
    /**
     *  提醒类型消息
     */
    NIMMessageTypeTip           = 10,
    /**
     *  机器人类型消息
     */
    NIMMessageTypeRobot         = 11,
    /**
     *  自定义类型消息
     */
    NIMMessageTypeCustom        = 100
};


@interface VVSSessionViewController ()

@end

@implementation VVSSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)receiveMessage:(NSDictionary *)dictPar {
    
    NSDictionary *dictData = (NSDictionary *)dictPar[@"data"];

    NSDictionary *dict = @{@"text":dictData[@"content"],
                           @"date":@"2018-10-10 09:22:15",
                           @"from":@"2",
                           @"messageId":@"20181010092515",
                           @"type":@"1",
                           @"sessionId":self.sessionId,
                           @"headerImg":dictData[@"user"][@"avatar"]
                           };
    
    [self.datas addObject:[SSChatDatas receiveMessage:dict]];
    [self.mTableView reloadData];
}






@end
