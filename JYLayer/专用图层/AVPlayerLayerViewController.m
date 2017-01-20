//
//  AVPlayerLayerViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/20.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "AVPlayerLayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerLayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation AVPlayerLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     // 播放本地资源
    // m1
//    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"ChinaPromotionalVideo.mp4" ofType:nil];
//    NSURL *url = [NSURL fileURLWithPath:urlStr];
    // m2
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"ChinaPromotionalVideo" withExtension:@"mp4"];
    // 播放网络资源
//    NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
//    NSURL *url = [NSURL URLWithString:playString];
    
    AVPlayer *player = [AVPlayer  playerWithURL:url];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:layer];
    
    // 对图层进行转换
    [self transofrmAVPlayerLayer:layer];
    
    // 播放视频
    [player play];
}

- (void)transofrmAVPlayerLayer:(AVPlayerLayer *)layer {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    layer.transform = transform;
    
    // 添加圆角和边框
    layer.masksToBounds = YES;
    layer.cornerRadius = 20.0;
    layer.borderColor = [UIColor greenColor].CGColor;
    layer.borderWidth = 3.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
