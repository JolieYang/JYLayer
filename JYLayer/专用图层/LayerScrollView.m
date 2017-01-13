//
//  LayerScrollView.m
//  JYLayer
//
//  Created by Jolie_Yang on 2017/1/13.
//  Copyright © 2017年 China Industrial Bank. All rights reserved.
//

#import "LayerScrollView.h"

@implementation LayerScrollView

+ (Class)layerClass {
    return [CAScrollLayer class];
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

- (void)setUp {
    self.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
    CGPoint offset = self.bounds.origin;
    offset.x = [recognizer translationInView:self].x;
    offset.y = [recognizer translationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    [recognizer setTranslation:CGPointZero inView:self];
}

@end
