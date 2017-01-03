//
//  ViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2016/12/13.
//  Copyright © 2016年 China Industrial Bank. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *snowImageView;

// 图片拼合
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *secondImageView;
@property (nonatomic, strong) UIImageView *thirdImageView;
@property (nonatomic, strong) UIImageView *fourthImageView;
@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupLayer];
    [self testSpriteImage];
}

- (void)setupLayer {
    // 1. 添加蓝色色块
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(30, 30, 50, 50);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:blueLayer];
    
    // 2. 在UIView的寄主图层中显示照片
    UIImage *image = [UIImage imageNamed:@"red_snowman"];
    self.snowImageView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    self.snowImageView.layer.contentsGravity = kCAGravityCenter;
    // 3. contentScale
    self.snowImageView.layer.contentsScale = [UIScreen mainScreen].scale;
    // 4. maskToBounds
//    self.snowImageView.layer.masksToBounds = YES;
}

// 图片拼合
- (void)testSpriteImage {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
    [self.view addSubview:_imageView];
    _secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 250, 100, 100)];
    [self.view addSubview:_secondImageView];
    _thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 400, 100, 100)];
    [self.view addSubview:_thirdImageView];
    _fourthImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 400, 100, 100)];
    [self.view addSubview:_fourthImageView];
    
    UIImage *image = [UIImage imageNamed:@"water"];
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:_imageView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:_secondImageView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:_thirdImageView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:_fourthImageView.layer];
}
- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
