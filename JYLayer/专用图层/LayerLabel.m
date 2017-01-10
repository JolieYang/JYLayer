//
//  LayerLabel.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/10.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//


// 用CATextLayer作为宿主图层的UILabel子类
#import "LayerLabel.h"

@implementation LayerLabel

+ (Class)layerClass {
    return [CATextLayer class];
}
- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}

- (void)setUp {
    //set defaults from UILabel settings
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    //we should really derive these from the UILabel settings too //but that's complicated, so for now we'll just hard-code them
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self.layer display];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}

- (void)setText:(NSString *)text {
    super.text = text;
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor {
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    super.font = font;
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    
    CGFontRelease(fontRef);
}


@end
