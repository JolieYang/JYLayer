//
//  ExplicitAnimationsViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/24.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "ExplicitAnimationsViewController.h"

@interface ExplicitAnimationsViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation ExplicitAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createColorLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createColorLayer {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}

// 使用CABasicAnimation设置图层背景色。(显式动画方式)
- (IBAction)changeColorUseBasicAnimation:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)[UIColor randomColor].CGColor;
    [self.colorLayer addAnimation:animation forKey:nil];
}


@end
