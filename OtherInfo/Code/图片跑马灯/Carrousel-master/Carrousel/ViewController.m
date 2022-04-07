//
//  ViewController.m
//  Carrousel
//
//  Created by leilurong on 2017/1/3.
//  Copyright © 2017年 leilurong. All rights reserved.
//

#import "ViewController.h"
#import "LRCarrouselView.h"
#import "UIButton+Category.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self testCarrouselView];
}

- (void)testCarrouselView{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 8; i ++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"mm%ld.jpeg", (long)i]];
        [array addObject:image];
    }
    LRCarrouselView *carr = [[LRCarrouselView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 198) images:array callback:^(NSInteger index, NSInteger event) {
        
        NSLog(@"%ld %@", index, event == 1 ? @"点击" : @"长按");
    }];
    [carr addImage:[UIImage imageNamed:@"mm8.jpeg"]];
    carr.backgroundColor = [UIColor blackColor];
    carr.animationSpeed = 20;
    carr.showReflectLayer = YES;
    [self.view addSubview:carr];
    
    
    
}



@end
