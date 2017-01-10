//
//  CATextLayerViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/10.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "CATextLayerViewController.h"
#import <CoreText/CoreText.h>

@interface CATextLayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UIView *labelView2;
@end

@implementation CATextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing  elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar  leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc  elementum, libero ut porttitor dictum, diam odio congue lacus, vel  fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet";
    [self setTextLayerNotPixWithText:text];
    
    [self richTextWithText:text];
}
// 使用CATextLayer
- (void)setTextLayerNotPixWithText:(NSString *)text {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor greenColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    textLayer.string = text;
}

// 富文本
- (void)richTextWithText:(NSString *)text {
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView2.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.labelView2.layer addSublayer:textLayer];
    //set text attributes
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    // 创建属性化字符串
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    // 将UIFont转化为CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    // 设置文本属性
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:
                                  (__bridge id)[UIColor blackColor].CGColor, (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    [string setAttributes:attribs range:NSMakeRange(0, [text length])]; attribs = @{
                                                                                    (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor, (__bridge id)kCTUnderlineStyleAttributeName:
                                                                                        @(kCTUnderlineStyleSingle),
                                                                                    (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                                                                                    };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    
    CFRelease(fontRef);
    
    // 设置图层文本
    textLayer.string = string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
