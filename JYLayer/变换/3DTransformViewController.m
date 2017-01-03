//
//  3DTransformViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2016/12/28.
//  Copyright © 2016年 China Industrial Bank. All rights reserved.
//

#import "3DTransformViewController.h"

@interface _DTransformViewController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *layerImageView;

// sublayerTransform
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *snowImage1;
@property (weak, nonatomic) IBOutlet UIImageView *snowImage2;

@end

@implementation _DTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // sublayerTransform
//    self.layerImageView.layer.sublayerTransform
}

#pragma mark 1
// 绕Y轴旋转45度
- (IBAction)tapAction1:(id)sender {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    self.layerImageView.layer.transform = transform;
}
// 雪人底图绕Y轴逆时针旋转45度
- (IBAction)tapAction9:(id)sender {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, -M_PI_4, 0, 1, 0);
    
    self.bgView.layer.transform = transform;
}
// 雪人绕Z轴旋转45度
- (IBAction)tapAction7:(id)sender {
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    self.layerImageView.layer.transform = transform;
}
// 雪人底图绕Z轴逆时针旋转45度
- (IBAction)tapAction8:(id)sender {
    CATransform3D transform = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    self.bgView.layer.transform = transform;
}
// 透视投影：ps,感觉没什么效果 --> 选择的图片原因导致看不到，换图片后就可见效果
- (IBAction)tapAction2:(id)sender {
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = -1.0 / 500.0;
    transform2 = CATransform3DRotate(transform2, M_PI_4, 0, 1, 0);
    self.layerImageView.layer.transform = transform2;
}
// 沿Y轴旋转180度，显示背面
- (IBAction)tapAction5:(id)sender {
    CATransform3D transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    self.layerImageView.layer.transform = transform;
}
// 不绘制背面
- (IBAction)tapAction6:(id)sender {
    self.layerImageView.layer.doubleSided = NO;
}


- (IBAction)remakeAction:(id)sender {
    self.layerImageView.layer.transform = CATransform3DIdentity;
    self.layerImageView.layer.doubleSided = YES;
}
- (IBAction)remakeAction1:(id)sender {
    self.bgView.layer.transform = CATransform3DIdentity;
}
#pragma mark 2
// 设置相同的透视和灭点
- (IBAction)tapAction3:(id)sender {
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500.0;
    self.containerView.layer.sublayerTransform = perspective;// 相同的透视
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.snowImage1.layer.transform = transform1;
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.snowImage2.layer.transform = transform2;
    
}
// 未设置相同的透视
- (IBAction)tapAction4:(id)sender {
    self.containerView.layer.sublayerTransform = CATransform3DIdentity;
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.snowImage1.layer.transform = transform1;
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.snowImage2.layer.transform = transform2;
}
- (IBAction)remakeAction2:(id)sender {
    self.containerView.layer.sublayerTransform = CATransform3DIdentity;
    self.snowImage1.layer.transform = CATransform3DIdentity;
    self.snowImage2.layer.transform = CATransform3DIdentity;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
