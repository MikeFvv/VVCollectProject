//
//  BugCollectionController.m
//  VVCollectProject
//
//  Created by pt c on 2019/7/23.
//  Copyright © 2019 Mike. All rights reserved.1
//

#import "BugCollectionController.h"

@interface BugCollectionController ()

@property (nonatomic, strong) UIImageView *urlImageView;

@end

@implementation BugCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark -  设置图片高度
- (void)setImageHeightAction:(int)AorB {
    
//    UIImageView *bigImageView = [[UIImageView alloc]init];
    
//    self.bigImageView = [[UIImageView alloc]init];
//    __weak __typeof(self)weakSelf = self;
//    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:self.currentPhotoM.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 不能进来这里 是因为过早释放了 bigImageView   >>>>>>
    
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        CGFloat imageYW = CGImageGetWidth(image.CGImage);
//        CGFloat imageW = strongSelf.view.width - strongSelf.leftTableView.width - 20;
//        strongSelf.imageHeight = imageW / (imageYW / CGImageGetHeight(image.CGImage));
//        [strongSelf buildABPanView:AorB];
//        [strongSelf.tableView reloadData];
//        self.bigImageView = nil;
//    }];
}

@end
