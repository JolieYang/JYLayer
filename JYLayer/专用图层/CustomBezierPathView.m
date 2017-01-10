//
//  CustomBezierPathView.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/9.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "CustomBezierPathView.h"

@implementation CustomBezierPathView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 1. 绘制三角形
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(10, 70)];
    [path addLineToPoint:CGPointMake(70, 70)];
    [path closePath];
    // 填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    // 线条颜色
    UIColor *stroke = [UIColor redColor];
    [stroke set];
    [path stroke];
    
    // 2. 创建椭圆的贝塞尔曲线
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(80, 10, 70, 70)];
    [path1 fill];
    
    // 3. 创建矩形的贝塞尔曲线
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(160, 10, 70, 70)];
    [path2 stroke];
    
    // 4. 定义二级贝塞尔曲线  重点|拐弯点
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(10, 100)];
    [path3 addQuadCurveToPoint:CGPointMake(70, 100) controlPoint:CGPointMake(47, 170)];
    [path3 setLineWidth:3];
    [path3 stroke];
    
    // 5. 定义三级贝塞尔曲线 重点|拐点|拐点
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(160, 100)];
    [path4 addCurveToPoint:CGPointMake(260, 100) controlPoint1:CGPointMake(200, 80) controlPoint2:CGPointMake(260, 120)];
    [path4 stroke];
    
    
    // 6. 创建圆弧
    UIBezierPath *path5 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(10, 100) radius:10 startAngle:0 endAngle:M_PI clockwise:YES];
    [path5 fill];
}

@end
