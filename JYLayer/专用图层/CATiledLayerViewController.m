//
//  CATiledLayerViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/16.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

// [Bug] 返回会崩溃 20170116

#import "CATiledLayerViewController.h"

@interface CATiledLayerViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation CATiledLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTileLayer];
}

- (void)addTileLayer {
    CATiledLayer *tileLayer = [CATiledLayer layer];
    tileLayer.frame = CGRectMake(0, 0, 2048, 2048);
//    tileLayer.delegate = self;
    [self.scrollView.layer addSublayer:tileLayer];
    
    self.scrollView.contentSize = tileLayer.frame.size;
    
    [tileLayer setNeedsDisplay];
}

#pragma mark CALayerDelegate
- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx {
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height);
    
    // 加载图片
    NSString *imageName = [NSString stringWithFormat:@"big_snowman_%02li_%02li", (long)x , (long)y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
//    UIImage *tileImage = [UIImage imageNamed:imageName];
    
    // 绘制小片
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
