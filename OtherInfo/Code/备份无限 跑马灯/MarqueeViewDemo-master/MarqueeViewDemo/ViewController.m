//
//  ViewController.m
//  MarqueeViewDemo
//
//  Created by Tiny on 2018/3/28.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "ViewController.h"
#import "HXQMarqueeModel.h"
#import "HXQMarqueeView.h"
#import "UIView+Extionsiton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSString *path =  [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
    NSArray * arr = [[NSArray alloc] initWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *modelList = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 2; index++) {
        for (NSDictionary *dict in arr) {
            HXQMarqueeModel *model = [[HXQMarqueeModel alloc] initWithDictionary:dict];
            [modelList addObject:model];
        }
    }
    
    
    HXQMarqueeView *marqueeView = [[HXQMarqueeView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    marqueeView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:marqueeView];
//    marqueeView.isLeftSlide = NO;
    [marqueeView setItems:modelList];
    [marqueeView startAnimation];
    
    [marqueeView addMarueeViewItemClickBlock:^(HXQMarqueeModel *model) {
        NSLog(@"%@",model.userImg);
    }];
    

}

@end
