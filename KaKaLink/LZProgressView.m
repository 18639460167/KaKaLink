//
//  LZProgressView.m
//  LZProgressView
//
//  Created by mac on 10/28/15.
//  Copyright © 2015 mac. All rights reserved.
//

#import "LZProgressView.h"
#import "CCArcMoveLayer.h"

static NSString * const kName = @"name";
@interface LZProgressView ()
{
    CGFloat radius;
    NSTimer *mtimer;
}

@property (nonatomic, assign) CGFloat lineWidth; /**<边框宽度*/
@property (nonatomic, strong) NSArray *lineColor; /**<边框颜色*/

@property (nonatomic, strong) CAShapeLayer *progressLayer; /**<进度条*/

@property (nonatomic, strong) CCArcMoveLayer *arcMoveLayer; // 对号
@property (strong, nonatomic) CAShapeLayer *checkLine; // 圆圈
@property (nonatomic, strong ) CAShapeLayer *failMoveLayer; // 错误
@property (nonatomic, strong) CAShapeLayer *rightMoveLayer; // 右侧线
@end

@implementation LZProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame
                  andLineWidth:2.0
                  andLineColor:@[
                                 [UIColor redColor],
                                 [UIColor greenColor],
                                 [UIColor blueColor]]];
}

- (instancetype)initWithFrame:(CGRect)frame andLineWidth:(CGFloat)lineWidth andLineColor:(NSArray *)lineColor {
    self = [super initWithFrame:frame];
    if(self) {
        self.lineWidth = lineWidth;
        self.lineColor = lineColor;
        radius = self.frame.size.width/2;
    }
    
    return self;
}

- (void)startAnimation
{
    [self setup];
}

- (void)setup {
    NSAssert(self.lineWidth > 0.0, @"lineWidth must great than zero");
    NSAssert(self.lineColor.count > 0, @"lineColor must set");
    
    //外层旋转动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @0.0;
    rotationAnimation.toValue = @(2*M_PI);
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.duration = 3.0;
    rotationAnimation.beginTime = 0.0;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    //内层进度条动画
    CABasicAnimation *strokeAnim1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnim1.fromValue = @0.0;
    strokeAnim1.toValue = @1.0;
    strokeAnim1.duration = 1.0;
    strokeAnim1.beginTime = 0.0;
    strokeAnim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
   
    //内层进度条动画
    CABasicAnimation *strokeAnim2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeAnim2.fromValue = @0.0;
    strokeAnim2.toValue = @1.0;
    strokeAnim2.duration = 1.0;
    strokeAnim2.beginTime = 1.0;
    strokeAnim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.duration = 2.0;
    // float类型，无穷大
    animGroup.repeatCount = HUGE_VALF;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.animations = @[strokeAnim1, strokeAnim2];
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.lineWidth, self.lineWidth, CGRectGetWidth(self.frame)-self.lineWidth*2, CGRectGetHeight(self.frame)-self.lineWidth*2)];
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.strokeColor = ((UIColor *)self.lineColor[0]).CGColor;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeStart = 0.0;
    self.progressLayer.strokeEnd = 1.0;
    self.progressLayer.path = path.CGPath;
    [self.progressLayer addAnimation:animGroup forKey:@"strokeAnim"];
    
    [self.layer addSublayer:self.progressLayer];
    
  mtimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(randomColor)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void)randomColor {
    UIColor *color = (UIColor *)[self.lineColor objectAtIndex:arc4random()%self.lineColor.count];
    self.progressLayer.strokeColor = color.CGColor;
}

#pragma mark - 请求成功
/**
 *  请求成功
 */
- (void)requestSuccess
{
    [self createCircle];
    [self addAnimation];
}
- (void)addAnimation
{
    self.arcMoveLayer = [CCArcMoveLayer layer];
    self.arcMoveLayer.contentsScale = [UIScreen mainScreen].scale;
    self.arcMoveLayer.bounds = CGRectMake(0, 0, radius*2, radius*2);
    self.arcMoveLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // animation
    self.arcMoveLayer.progress = 1; // end status
    [self.layer addSublayer:self.arcMoveLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.duration = 1;
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
   // animation.delegate = self;
    [animation setValue:@"successStep1" forKey:kName];
    [self.arcMoveLayer addAnimation:animation forKey:nil];
    
    self.checkLine = [CAShapeLayer layer];
    [self.layer addSublayer:self.checkLine];
    self.checkLine.frame = self.layer.bounds;
    // path
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
    
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds) - radius + 5, CGRectGetMidY(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) - radius / 5, CGRectGetMidY(self.bounds) + radius / 5 * 2)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) + radius - radius / 8 * 3, CGRectGetMidY(self.bounds) - radius / 2)];
    
    self.checkLine.path = path.CGPath;
    self.checkLine.lineWidth = self.lineWidth;
    self.checkLine.lineCap = kCALineCapRound;
    self.checkLine.strokeColor = [UIColor colorWithRed:1 / 255.0 green:174 / 255.0 blue:159 / 255.0 alpha:1.0].CGColor;
    self.checkLine.fillColor = nil;
    
    //SS(strokeStart)
    CGFloat SSFrom = 0;
    CGFloat SSTo = 1.0;
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(SSFrom);
    startAnimation.toValue = @(SSTo);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @(SSFrom);
    endAnimation.toValue = @(SSTo);
    
    
    CAAnimationGroup *step2 = [CAAnimationGroup animation];
    step2.animations = @[endAnimation];
    step2.duration = 0.5;
    step2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.checkLine addAnimation:step2 forKey:nil];

}

#pragma mark - 请求失败
- (void)requestFail
{
    [self createCircle];
    [self failAnimation];
}

#pragma mark- 画圆
- (void)createCircle
{
    [mtimer invalidate];
    [self.layer removeAllAnimations];
    [self.progressLayer removeAllAnimations];
    self.progressLayer.hidden = YES;
    
    self.arcMoveLayer = [CCArcMoveLayer layer];
    self.arcMoveLayer.contentsScale = [UIScreen mainScreen].scale;
    self.arcMoveLayer.bounds = CGRectMake(0, 0, radius*2, radius*2);
    self.arcMoveLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // animation
    self.arcMoveLayer.progress = 1; // end status
    [self.layer addSublayer:self.arcMoveLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.duration = 1;
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
   // animation.delegate = self;
    [animation setValue:@"successStep1" forKey:kName];
    [self.arcMoveLayer addAnimation:animation forKey:nil];
}
- (void)failAnimation
{
    self.failMoveLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.failMoveLayer];
    self.failMoveLayer.frame = self.layer.bounds;
    // path
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame)/4+3, CGRectGetHeight(self.frame)/5+3)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/4*3-3,
                                     CGRectGetHeight(self.frame)/5*4-3)];
    
    self.failMoveLayer.path = path.CGPath;
    self.failMoveLayer.lineWidth = self.lineWidth;
    self.failMoveLayer.lineCap = kCALineCapRound;
    self.failMoveLayer.strokeColor = [UIColor colorWithRed:1 / 255.0 green:174 / 255.0 blue:159 / 255.0 alpha:1.0].CGColor;
    self.failMoveLayer.fillColor = nil;
    
    
    self.rightMoveLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.rightMoveLayer];
    self.rightMoveLayer.frame = self.layer.bounds;
    // path
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:CGPointMake(CGRectGetWidth(self.frame)/4*3-3, CGRectGetHeight(self.frame)/5+3)];
    [path1 addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/4+3,
                                     CGRectGetHeight(self.frame)/5*4-3)];
    
    self.rightMoveLayer.path = path1.CGPath;
    self.rightMoveLayer.lineWidth = self.lineWidth;
    self.rightMoveLayer.lineCap = kCALineCapRound;
    self.rightMoveLayer.strokeColor = [UIColor colorWithRed:1 / 255.0 green:174 / 255.0 blue:159 / 255.0 alpha:1.0].CGColor;
    self.rightMoveLayer.fillColor = nil;
    
    CGFloat SSFrom = 0;
    CGFloat SSTo = 1.0;
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @(SSFrom);
    startAnimation.toValue = @(SSTo);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @(SSFrom);
    endAnimation.toValue = @(SSTo);
    CAAnimationGroup *step2 = [CAAnimationGroup animation];
    step2.animations = @[endAnimation];
    step2.duration = 0.5;
    step2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.failMoveLayer addAnimation:step2 forKey:nil];
    [self.rightMoveLayer addAnimation:step2 forKey:nil];
}
@end
