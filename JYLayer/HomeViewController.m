//
//  HomeViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/23.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)jumpToPartTwoAction:(id)sender {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Motion" bundle:nil] instantiateViewControllerWithIdentifier:@"TransitionsViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)jumpToPartThreeAction:(id)sender {
    NSLog(@"该部分还未开始学习");
}

@end
