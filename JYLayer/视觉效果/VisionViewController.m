//
//  VisionViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2016/12/26.
//  Copyright © 2016年 China Industrial Bank. All rights reserved.
//

#import "VisionViewController.h"

@interface VisionViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerWhiteView;
@property (weak, nonatomic) IBOutlet UIView *layerRedView;

// 阴影
@property (weak, nonatomic) IBOutlet UIView *layerBlueView;
@property (weak, nonatomic) IBOutlet UIImageView *layerSnowmanImageView;

// 阴影裁剪
@property (weak, nonatomic) IBOutlet UIView *layerOrangeView;
@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;

// shadowPath
@property (weak, nonatomic) IBOutlet UIImageView *snowmanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *snowmanImageView2;

@end

@implementation VisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.圆角
    self.layerWhiteView.layer.cornerRadius = 20.0f;
    self.layerRedView.layer.cornerRadius = 20.0f;
    self.layerWhiteView.layer.masksToBounds = YES;
    // masksToBounds裁剪后无法看见阴影
    self.layerWhiteView.layer.shadowOpacity = 0.9;
    
    
    // 2.边框
    self.layerWhiteView.layer.borderColor = [UIColor greenColor].CGColor;
    self.layerWhiteView.layer.borderWidth = 2.0;
    
    
    // 3.阴影
    self.layerBlueView.layer.shadowOpacity = 0.7;
    self.layerBlueView.layer.shadowColor = [UIColor greenColor].CGColor;
    self.layerBlueView.layer.shadowOffset = CGSizeMake(10, 10);
    self.layerBlueView.layer.shadowRadius = 5.0f;
    self.layerSnowmanImageView.layer.shadowOpacity = 0.7f;
    
    // 3.1阴影裁剪
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView1.layer.shadowOpacity = 0.7f;
    self.layerView1.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layerView1.layer.shadowRadius = 5.0f;
    self.layerView1.layer.masksToBounds = YES;
    
    self.layerOrangeView.layer.shadowOpacity = 0.5f;
    self.layerOrangeView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layerOrangeView.layer.shadowRadius = 5.0f;
    self.layerOrangeView.layer.cornerRadius = 20.0f;
    
    // 3.2shadowPath
    self.snowmanImageView.layer.shadowOpacity = 0.7f;
    self.snowmanImageView2.layer.shadowOpacity = 0.7f;
    // 创建方形阴影
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL, self.snowmanImageView.bounds);
    self.snowmanImageView.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
    // 创建圆形阴影
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, self.snowmanImageView2.bounds);
    self.snowmanImageView2.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
