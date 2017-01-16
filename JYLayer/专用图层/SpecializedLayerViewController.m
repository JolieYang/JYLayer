//
//  SpecializedLayerViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/9.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "SpecializedLayerViewController.h"
#import "CAShapeLayerViewController.h"
#import "CATextLayerViewController.h"

@interface SpecializedLayerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *vcArray;

@end

@implementation SpecializedLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[@"CAShapeLayer",@"CATextLayer",@"CATransformLayer",@"CAGradientLayer",@"CAReplicator"
                       ,@"CAScrollLayer",@"CATiledLayer"];
    self.vcArray = @[@"CAShapeLayerViewController",@"CATextLayerViewController",@"CATransformLayerViewController"
                     ,@"CAGradientLayerViewController",@"CAReplicatorViewController", @"CAScrollLayerViewController"
                     ,@"CATiledLayerViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:self.vcArray[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.dataArray[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = title;
    
    return cell;
}
@end
