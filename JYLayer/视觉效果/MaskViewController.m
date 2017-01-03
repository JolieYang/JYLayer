//
//  MaskViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2016/12/27.
//  Copyright © 2016年 China Industrial Bank. All rights reserved.
//

#import "MaskViewController.h"

@interface MaskViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *chrismanImageView;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *transparentButton;
@property (weak, nonatomic) IBOutlet UIButton *transparentButton2;
@end

@implementation MaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 图层蒙版
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.chrismanImageView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"chris_tree"];
    maskLayer.contents = (__bridge id _Nullable)(maskImage.CGImage);
    
    self.chrismanImageView.layer.mask = maskLayer;
    
    // 组透明
    self.button.layer.cornerRadius = 10;
    self.transparentButton.layer.cornerRadius = 10;
    self.transparentButton2.layer.cornerRadius = 10;
    
    UILabel *buttonLB = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 100, 20)];
    buttonLB.text = @"Hello world";
    [self.button addSubview:buttonLB];
    
    self.transparentButton.alpha = 0.5;
    UILabel *transparentLB = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 100, 20)];
    transparentLB.text = @"Hello world";
    [self.transparentButton addSubview:transparentLB];
    
    self.transparentButton2.alpha = 0.5;
    UILabel *transparentLB2 = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 100, 20)];
    transparentLB2.text = @"Hello world";
    [self.transparentButton2 addSubview:transparentLB2];
    self.transparentButton2.layer.shouldRasterize = YES;
    self.transparentButton2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
