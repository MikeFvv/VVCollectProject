//
//  NextViewController.m
//  NSAttributedString_Yjl
//
//  Created by 余晋龙 on 2016/11/2.
//  Copyright © 2016年 余晋龙. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果图";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.label.attributedText = _attributedStr;
}
-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:self.view.frame];
        _label.numberOfLines = 0;
        [self.view addSubview:_label];
    }
    return _label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
