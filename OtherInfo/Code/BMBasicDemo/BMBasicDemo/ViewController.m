//
//  ViewController.m
//  BMBasicDemo
//
//  Created by BLOM on 10/3/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:backView];
}


@end
