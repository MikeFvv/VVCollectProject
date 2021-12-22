//
//  UIAlertViewBlocksController.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/22.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "UIAlertViewBlocksController.h"

@interface UIAlertViewBlocksController ()

@end

@implementation UIAlertViewBlocksController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [[[UIAlertView alloc] initWithTitle:@"Delete This Item?"
                                message:@"Are you sure you want to delete this really important thing?"
                       cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
                                          // Handle "Cancel"
                                        }]
                       otherButtonItems:[RIButtonItem itemWithLabel:@"Delete" action:^{
                                           // Handle "Delete"
                                        }], nil] show];
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
