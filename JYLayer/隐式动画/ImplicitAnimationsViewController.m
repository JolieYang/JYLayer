//
//  TransitionsViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/23.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "ImplicitAnimationsViewController.h"
#import "AppDelegate.h"

@interface ImplicitAnimationsViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation ImplicitAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
- (IBAction)homeAction:(id)sender {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    AppDelegate *pDelegate = [UIApplication sharedApplication].delegate;
    pDelegate.window.rootViewController = vc;
}

// 添加colorLayer
- (IBAction)configColorLayer {
    if (self.colorLayer) {
        return;
    }
    self.colorLayer = [CALayer layer];
    //    self.colorLayer.frame = self.layerView.bounds;
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}
// 添加具备Custom Action的colorLayer. 现调用这个，然后再调用改变颜色，隐式动画为指定的Custom Action，即颜色切换时会从左边push。
- (IBAction)addColorLayerWithCustomAction:(id)sender {
    if (self.colorLayer) {
        return;
    }
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    // 添加custom Action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor": transition};
    
    [self.layerView.layer addSublayer:self.colorLayer];
}

// 移除colorLayer
- (IBAction)removeColorLayerAction:(id)sender {
    if (self.layerView.layer.sublayers.count == 0) {
        return;
    } else {
        [self.layerView.layer.sublayers[0] removeFromSuperlayer];
        self.colorLayer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeColorAction:(id)sender {
    [self configColorLayer];
    
    self.colorLayer.backgroundColor = [UIColor randomColor].CGColor;
}

// 通过新建事务无副作用的修改动画时间
- (IBAction)transitionChangeColorAction:(id)sender {
    [self configColorLayer];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    [self changeColorAction:nil];
    
    [CATransaction commit];
}
// 设置动画完成块--选择90度
- (IBAction)changeColorByAddCompleBlockAction:(id)sender {
    [self configColorLayer];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_4);
        self.colorLayer.affineTransform = transform;
    }];
    
    [self changeColorAction:nil];
    
    [CATransaction commit];
}
// 修改底图颜色--动画的执行并不是按动画持续时间平滑的过渡，而是直接切换。
- (IBAction)changeBackingViewColorAction:(id)sender {
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    
    self.layerView.layer.backgroundColor = [UIColor randomColor].CGColor;
    
    [CATransaction commit];
}

// 启用隐式动画修改底图颜色
- (IBAction)enableImplicitAction:(id)sender {
    NSLog(@"Outside:%@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    
    self.layerView.layer.backgroundColor = [UIColor randomColor].CGColor;
    
    NSLog(@"Inside:%@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    
    [UIView commitAnimations];
}

// 使用呈现图层去检测当前图层的位置对，demo: 对colorLayer做检测，点击在colorLayer区域就修改color的背景色，不在区域内就移动colorLayer的position到所点击的point上.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.layerView];
    
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        self.colorLayer.backgroundColor = [UIColor randomColor].CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}

@end
