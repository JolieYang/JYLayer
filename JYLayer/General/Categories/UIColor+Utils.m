//
//  UIColor+Utils.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/25.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)
+ (UIColor *)randomColor {
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    return randomColor;
}
@end
