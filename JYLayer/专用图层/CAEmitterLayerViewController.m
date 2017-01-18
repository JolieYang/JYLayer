//
//  CAEmitterLayerViewController.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/17.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "CAEmitterLayerViewController.h"

@interface CAEmitterLayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) CAEmitterLayer *fireEmitter;
@property (nonatomic, strong) CAEmitterLayer *smokeEmitter;

@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addFireExplosionEffect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFireExplosionEffect {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitterLayer];
    
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterPosition = CGPointMake(emitterLayer.frame.size.width/2.0, emitterLayer.frame.size.height/2.0);
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id)[UIImage imageNamed:@"fire"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;// 桔色
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    emitterLayer.emitterCells = @[cell];
}

#pragma mark Action
- (IBAction)removeEmitterAction:(id)sender {
    if (self.containerView.layer.sublayers.count == 0) {
        return;
    } else {
        [self.containerView.layer.sublayers[0] removeFromSuperlayer];
        [self removeEmitterAction:nil];
    }
}
- (IBAction)snowFlakeAction:(id)sender {
    [self removeEmitterAction:nil];
    // Configure the particle emitter to the top edge of the screen
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(self.containerView.bounds.size.width / 2.0, -30);
    snowEmitter.emitterSize		= CGSizeMake(self.containerView.bounds.size.width * 2.0, 0.0);;
    
    // Spawn points for the flakes are within on the outline of the line
    snowEmitter.emitterMode		= kCAEmitterLayerOutline;
    snowEmitter.emitterShape	= kCAEmitterLayerLine;
    
    // Configure the snowflake emitter cell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate		= 1.0;
    snowflake.lifetime		= 120.0;
    
    snowflake.velocity		= -10;				// falling down slowly
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 2;
    snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle
    snowflake.spinRange		= 0.25 * M_PI;		// slow spin
    
    snowflake.contents		= (id) [[UIImage imageNamed:@"snowFlake"] CGImage];
    snowflake.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    // Make the flakes seem inset in the background
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.containerView.layer insertSublayer:snowEmitter atIndex:0];
}

- (IBAction)fireAction:(id)sender {
    [self removeEmitterAction:nil];
    
    CGRect viewBounds = self.containerView.layer.bounds;
    
    // Create the emitter layers
    self.fireEmitter	= [CAEmitterLayer layer];
    self.smokeEmitter	= [CAEmitterLayer layer];
    
    // Place layers just above the tab bar
    self.fireEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height - 60);
    self.fireEmitter.emitterSize	= CGSizeMake(viewBounds.size.width/2.0, 0);
    self.fireEmitter.emitterMode	= kCAEmitterLayerOutline;
    self.fireEmitter.emitterShape	= kCAEmitterLayerLine;
    // with additive rendering the dense cell distribution will create "hot" areas
    self.fireEmitter.renderMode		= kCAEmitterLayerAdditive;
    
    self.smokeEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height - 60);
    self.smokeEmitter.emitterMode	= kCAEmitterLayerPoints;
    
    // Create the fire emitter cell
    CAEmitterCell* fire = [CAEmitterCell emitterCell];
    [fire setName:@"fire"];
    
    fire.birthRate			= 100;
    fire.emissionLongitude  = M_PI;
    fire.velocity			= -80;
    fire.velocityRange		= 30;
    fire.emissionRange		= 1.1;
    fire.yAcceleration		= -200;
    fire.scaleSpeed			= 0.3;
    fire.lifetime			= 50;
    fire.lifetimeRange		= (50.0 * 0.35);
    
    fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire.contents = (id) [[UIImage imageNamed:@"fire"] CGImage];
    
    
    // Create the smoke emitter cell
    CAEmitterCell* smoke = [CAEmitterCell emitterCell];
    [smoke setName:@"smoke"];
    
    smoke.birthRate			= 11;
    smoke.emissionLongitude = -M_PI / 2;
    smoke.lifetime			= 10;
    smoke.velocity			= -40;
    smoke.velocityRange		= 20;
    smoke.emissionRange		= M_PI / 4;
    smoke.spin				= 1;
    smoke.spinRange			= 6;
    smoke.yAcceleration		= -160;
    smoke.contents			= (id) [[UIImage imageNamed:@"fireSmoke"] CGImage];
    smoke.scale				= 0.1;
    smoke.alphaSpeed		= -0.12;
    smoke.scaleSpeed		= 0.7;
    
    
    // Add the smoke emitter cell to the smoke emitter layer
    self.smokeEmitter.emitterCells	= [NSArray arrayWithObject:smoke];
    self.fireEmitter.emitterCells	= [NSArray arrayWithObject:fire];
    [self.containerView.layer addSublayer:self.smokeEmitter];
    [self.containerView.layer addSublayer:self.fireEmitter];
    
    [self setFireAmount:0.9];
}
- (void) setFireAmount:(float)zeroToOne
{
    // Update the fire properties
    [self.fireEmitter setValue:[NSNumber numberWithInt:(zeroToOne * 500)]
                    forKeyPath:@"emitterCells.fire.birthRate"];
    [self.fireEmitter setValue:[NSNumber numberWithFloat:zeroToOne]
                    forKeyPath:@"emitterCells.fire.lifetime"];
    [self.fireEmitter setValue:[NSNumber numberWithFloat:(zeroToOne * 0.35)]
                    forKeyPath:@"emitterCells.fire.lifetimeRange"];
    self.fireEmitter.emitterSize = CGSizeMake(50 * zeroToOne, 0);
    
    [self.smokeEmitter setValue:[NSNumber numberWithInt:zeroToOne * 4]
                     forKeyPath:@"emitterCells.smoke.lifetime"];
    [self.smokeEmitter setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:zeroToOne * 0.3] CGColor]
                     forKeyPath:@"emitterCells.smoke.color"];
}
#pragma mark Interaction
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self controlFireHeight:event];
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self controlFireHeight:event];
}


- (void) controlFireHeight:(UIEvent *)event
{
    UITouch *touch			= [[event allTouches] anyObject];
    CGPoint touchPoint		= [touch locationInView:self.view];
    float distanceToBottom	= self.view.bounds.size.height - touchPoint.y;
    float percentage		= distanceToBottom / self.view.bounds.size.height;
    percentage				= MAX(MIN(percentage, 1.0), 0.1);
    [self setFireAmount:2 *percentage];
}


@end
