//
//  CAEmitterLayerViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/17.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "CAEmitterLayerViewController.h"

@interface CAEmitterLayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addFireExplosionEffect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFireExplosionEffect {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitterLayer];
    
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width/2.0, emitterLayer.frame.size.height/2.0);
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id)[UIImage imageNamed:@"fire"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;// 桔色
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    emitterLayer.emitterCells = @[cell];
}
@end
