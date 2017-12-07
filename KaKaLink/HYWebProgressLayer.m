//
//  HYWebProgressLayer.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYWebProgressLayer.h"
#import "NSTimer+HYAction.h"

static NSTimeInterval const kFastTimeInterval = 0.03;
@implementation HYWebProgressLayer
{
    CAShapeLayer *_layer;
    NSTimer *_timer;
    CGFloat _plusWidth;
}

+ (instancetype)layerWithFrame:(CGRect)frame
{
    HYWebProgressLayer *layer = [self new];
    layer.frame = frame;
    return layer;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.anchorPoint = CGPointMake(0, 0.5);
    self.lineWidth = 1.5;
    self.strokeColor = [UIColor subjectColor].CGColor;
    HYWeakSelf;
    _timer = [NSTimer hy_scheduledTimerWithTimeInterval:kFastTimeInterval repeats:YES block:^(NSTimer *timer) {
        [wSelf pathChanged:timer];
    }];
    [_timer pause];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 1.5)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 1.5)];
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _plusWidth = 0.01;
}

- (void)pathChanged:(NSTimer *)timer
{
    if (self.strokeEnd >= 0.97)
    {
        [_timer pause];
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.strokeEnd += _plusWidth;
    if (self.strokeEnd > 0.8)
    {
        _plusWidth = 0.001;
    }
    [CATransaction commit];
}

- (void)startLoad
{
    [_timer resumeWithTimeInterval:kFastTimeInterval];
}

- (void)finishedLoad
{
    [self closeTimer];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.strokeEnd = 1.0;
    [CATransaction commit];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperlayer];
    });
}

- (void)dealloc
{
    [self closeTimer];
}

#pragma mark -private
- (void)closeTimer
{
    [_timer invalidate];
    _timer = nil;
}



@end
