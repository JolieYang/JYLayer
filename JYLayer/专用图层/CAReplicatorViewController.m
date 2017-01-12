//
//  CAReplicatorViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/12.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "CAReplicatorViewController.h"

@interface CAReplicatorViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation CAReplicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRingLayers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRingLayers {
    // 1.添加CAReplicatorLayer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicatorLayer];
    
    //  2.配置CAReplicatorLayer
    replicatorLayer.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicatorLayer.instanceTransform = transform;
    
    replicatorLayer.instanceBlueOffset = -0.1;
    replicatorLayer.instanceGreenOffset = -0.1;
    
    // 创建子图层并放入replicator中
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 50, 50);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:layer];
}
@end
