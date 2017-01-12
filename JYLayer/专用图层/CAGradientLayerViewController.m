//
//  CAGradientLayerViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/12.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "CAGradientLayerViewController.h"

@interface CAGradientLayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *multipartContainerView;
@end

@implementation CAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self twoColorDiagonalGradient];
    [self multipartGradient];
}

// 两种颜色的对角线渐变
- (void)twoColorDiagonalGradient {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    UIColor *firstColor = [UIColor redColor];
    UIColor *secondColor = [UIColor blueColor];
    // colors数组成员类型为CGColorRef
    gradientLayer.colors = @[(__bridge id)firstColor.CGColor, (__bridge id)secondColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

// 多种颜色的渐变
- (void)multipartGradient {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.multipartContainerView.bounds;
    [self.multipartContainerView.layer addSublayer:gradientLayer];
    
    UIColor *firstColor = [UIColor redColor];
    UIColor *secondColor = [UIColor blueColor];
    UIColor *thirdColor = [UIColor yellowColor];
    // colors数组成员类型为CGColorRef
    gradientLayer.colors = @[(__bridge id)firstColor.CGColor, (__bridge id)secondColor.CGColor,(__bridge id)thirdColor.CGColor];
    gradientLayer.locations = @[@0.0, @0.24, @0.5];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
