//
//  LayerDelegateViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2016/12/15.
//  Copyright © 2016年 China Industrial Bank. All rights reserved.
//

#import "LayerDelegateViewController.h"

@interface LayerDelegateViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *blueLayer;

@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation LayerDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.blueLayer.delegate = self;
    [self.layerView.layer addSublayer:self.blueLayer];
    //force layer to redraw
    [self.blueLayer display];
    [self.blueLayer convertPoint:self.blueLayer.position toLayer:self.layerView.layer];
    
    
    // 修改zPosition调整图层显示顺序
    self.orangeView.layer.zPosition = 1.0f;
    
}

#pragma mark Hit Testing
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    // 将坐标转换为layerView的坐标
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    // m1. containsPoint
    if ([self.layerView.layer containsPoint:point]) {
        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
        if ([self.blueLayer containsPoint:point]) {
            NSLog(@"Inside Blue layer");
        } else {
            NSLog(@"Inside White Layer");
        }
    }
    
    // m2. hitTest
    CGPoint touchPoint = [[touches anyObject] locationInView:self.layerView];
    CALayer *layer = [self.layerView.layer hitTest:touchPoint];
    if (layer == self.blueLayer) {
        NSLog(@"Inside Blue");
    } else if (layer == self.layerView.layer) {
        NSLog(@"Inside White");
    }
    
    layer = [self.orangeView.layer hitTest:touchPoint];
    if (layer == self.orangeView.layer) {
        NSLog(@"Inside orange");
    }
}


#pragma mark CALayerDelegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
