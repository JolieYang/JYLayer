//
//  AffinesTransformViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2016/12/28.
//  Copyright © 2016年 China Industrial Bank. All rights reserved.
//

#import "AffinesTransformViewController.h"

@interface AffinesTransformViewController ()

// 旋转45度
@property (weak, nonatomic) IBOutlet UIView *layerBlueView;
// 复合变换
@property (weak, nonatomic) IBOutlet UIView *layerPurpleView;

@end

@implementation AffinesTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.仿射转换
    // 1.1 简单转换：旋转45度
    CGAffineTransform affineTransform = CGAffineTransformMakeRotation(M_PI_4);
    self.layerBlueView.layer.affineTransform = affineTransform;
    // 1.2 复合转换：先缩小百分之五十，再旋转30度，最后向右移动200个像素
    CGAffineTransform transform = CGAffineTransformIdentity;// 创建空的转换
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    transform = CGAffineTransformRotate(transform, M_PI/180.0*30.0);
    transform = CGAffineTransformTranslate(transform, 200, 0);
    self.layerPurpleView.layer.affineTransform = transform;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
