//
//  CAScrollLayerViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/13.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "CAScrollLayerViewController.h"
#import "LayerScrollView.h"

@interface CAScrollLayerViewController ()
@property (weak, nonatomic) IBOutlet LayerScrollView *layerScrollView;
@end

@implementation CAScrollLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setUp];
}

- (void)setUp {
    UIImage *image = [UIImage imageNamed:@"red_snowman"];
    self.layerScrollView.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layerScrollView.layer.contentsGravity = kCAGravityCenter;
    self.layerScrollView.layer.contents = (__bridge id _Nullable)(image.CGImage);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
