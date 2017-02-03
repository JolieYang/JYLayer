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

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) CALayer *shipLayer;
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

- (void)createPath {
    
}

- (void)createColorLayer {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(25, 25, 50, 50);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}

// 1.1 使用CABasicAnimation设置图层背景色。(显式动画方式)
// 效果: 点击按钮，会过渡到新颜色，但又马上（动画执行完毕后，默认动画持续时间为0.25s）返回原始颜色
// 分析: 该动画只修改了图层的呈现层，没有改变Model层.一旦动画结束并从图层上移除，图层就恢复到之前的外观状态。
- (IBAction)changeColorUseBasicAnimation:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)[UIColor randomColor].CGColor;
    [self.colorLayer addAnimation:animation forKey:nil];
}
// 1.2 修复bug，但依旧有些问题,我们需要从呈现图层那里获取fromValue而不是模型图层。另外，由于这个图层不是UIView关联的图层，
// 我们还需手动禁用隐式动画行为，否则默认的图层行为会干扰我们的显式动画。（实际上，显式动画通常会覆盖隐式动画，但为了安全最好这么做。）
- (IBAction)changeColorUseBasicAniamtionV2:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.fromValue = (__bridge id _Nullable)(self.colorLayer.backgroundColor);
    UIColor *changedColor = [UIColor randomColor];
    self.colorLayer.backgroundColor = changedColor.CGColor;
    [self.colorLayer addAnimation:animation forKey:nil];
}
// 1.3
- (IBAction)changeColorUseBasicAnimationV3:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    CALayer *layer = self.colorLayer.presentationLayer ? : self.colorLayer;
    UIColor *changedColor = [UIColor randomColor];
    animation.fromValue = (__bridge id)layer.backgroundColor;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = changedColor.CGColor;
    [CATransaction commit];
}
// 1.4
- (IBAction)changeColorUseBasicAnimationV4:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)[UIColor randomColor].CGColor;
    
    [self applyBasicAniamtion:animation toLayer:self.colorLayer];
}
// 可以创建可复用的CABasicAnimation方法
- (void)applyBasicAniamtion:(CABasicAnimation *)animation toLayer:(CALayer *)layer {
    animation.fromValue = [layer.presentationLayer ? : layer valueForKeyPath:animation.keyPath];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [layer setValue:animation.toValue forKeyPath:animation.keyPath];
    [CATransaction commit];
    
    [layer addAnimation:animation forKey:nil];
}

- (IBAction)keyframeAnimationChangeColor:(id)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor];
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (IBAction)shipAction:(id)sender {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 100)];
    [bezierPath addCurveToPoint:CGPointMake(250, 100) controlPoint1:CGPointMake(114, 0) controlPoint2:CGPointMake(174, 200)];
    // draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    // 添加飞船
    if (!self.shipLayer) {
        self.shipLayer = [CALayer layer];
        _shipLayer.frame = CGRectMake(0, 0, 64, 64);
        _shipLayer.position = CGPointMake(0, 100);
        _shipLayer.contents= (__bridge id)[UIImage imageNamed:@"ship.png"].CGImage;
        [self.containerView.layer addSublayer:_shipLayer];
    }
    // 创建关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    [self.shipLayer addAnimation:animation forKey:nil];
}
// 飞船根据曲线的切线自动旋转
- (IBAction)shipAction2:(id)sender {
    if (!self.shipLayer) {
        self.shipLayer = [CALayer layer];
        _shipLayer.frame = CGRectMake(0, 0, 64, 64);
        _shipLayer.position = CGPointMake(0, 100);
        _shipLayer.contents= (__bridge id)[UIImage imageNamed:@"ship.png"].CGImage;
        [self.containerView.layer addSublayer:_shipLayer];
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = [self bezierPath].CGPath;
    // 根据曲线的切线自动旋转
    animation.rotationMode = kCAAnimationRotateAuto;
    [self.shipLayer addAnimation:animation forKey:nil];
}
- (UIBezierPath *)bezierPath {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 100)];
    [bezierPath addCurveToPoint:CGPointMake(250, 100) controlPoint1:CGPointMake(114, 0) controlPoint2:CGPointMake(174, 200)];
    return bezierPath;
}

// 2. 动画完成后修改图层的颜色
#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}


@end
