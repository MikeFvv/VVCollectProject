//
//  AppViewController.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/13.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI {
    self.view.backgroundColor = [UIColor cyanColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
