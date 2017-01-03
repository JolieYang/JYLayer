//
//  3DTransformViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2016/12/28.
//  Copyright © 2016年 China Industrial Bank. All rights reserved.
//

#import "3DTransformViewController.h"

@interface _DTransformViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerPinkView;

@property (weak, nonatomic) IBOutlet UIImageView *layerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *layerImageView2;
@end

@implementation _DTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 绕Y轴旋转图层
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerPinkView.layer.transform = transform;
    self.layerImageView.layer.transform = transform;
    // 透视投影：ps,感觉没什么效果
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = -1.0 / 500.0;
    transform2 = CATransform3DRotate(transform2, M_PI_4, 0, 1, 0);
    self.layerImageView2.layer.transform = transform2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
