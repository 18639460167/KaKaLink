//
//  HYCountingLable.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/9.
//  Copyright © 2017年 Black. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "HYCountingLable.h"

#pragma mark - UILabelCounter

#ifndef kUILabelCounterRate
#define kUILabelCounterRate 3.0
#endif

@protocol UILableCounter <NSObject>

- (CGFloat)update:(CGFloat)t;

@end

@interface UILableCounterLiner : NSObject<UILableCounter>

@end

@interface UILabelCounterEaseIn : NSObject<UILableCounter>

@end

@interface UILabelCounterEaseOut : NSObject<UILableCounter>

@end

@interface UILabelCounterEaseInOut : NSObject<UILableCounter>

@end
@implementation UILableCounterLiner

- (CGFloat)update:(CGFloat)t
{
    return t;
}

@end

@implementation UILabelCounterEaseIn

- (CGFloat)update:(CGFloat)t
{
    return powf(t, kUILabelCounterRate);
}

@end

@implementation UILabelCounterEaseOut

- (CGFloat)update:(CGFloat)t
{
    return 1.0-powf((1.0-t), kUILabelCounterRate);
}

@end

@implementation UILabelCounterEaseInOut

- (CGFloat)update:(CGFloat)t
{
    t*=2;
    if (t<1)
    {
        return 0.5f*powf(t, kUILabelCounterRate);
    }
    else
    {
        return 0.5f*(2.0f-powf(2.0-t, kUILabelCounterRate));
    }
}

@end

#pragma mark - UIConutingLable

@interface HYCountingLable ()
@property CGFloat startingValue;
@property CGFloat destinationValue;
@property NSTimeInterval progress;
@property NSTimeInterval lastUpdate;
@property NSTimeInterval totalTime;
@property CGFloat easingRate;

@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) id<UILableCounter>counter;
@end

@implementation HYCountingLable

- (void)countForm:(CGFloat)startValue to:(CGFloat)endValue
{
    if (self.animationDuration == 0.0f)
    {
        self.animationDuration = 2.0f;
    }
    [self countForm:startValue to:endValue withDuration:self.animationDuration];
}

- (void)countForm:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration
{
    self.startingValue = startValue;
    self.destinationValue = endValue;
    
    [self.timer invalidate];
    self.timer = nil;
    if (duration == 0.0)
    {
        [self setTextValue:endValue];
        [self runCompletionBlock];
        return;
    }
    self.easingRate = 3.0f;
    self.progress = 0;
    self.totalTime = duration;
    self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];
    if (self.format==nil)
    {
        self.format = @"%f";
    }
    switch (self.method)
    {
        case HYLableCountingMethodLinear:
            self.counter = [[UILableCounterLiner alloc]init];
            break;
        case HYLableCountingMethodEaseIn:
            self.counter = [[UILabelCounterEaseIn alloc]init];
            break;
        case HYLableCountingMethodEaseOut:
            self.counter = [[UILabelCounterEaseOut alloc]init];
            break;
        case HYLableCountingMethodEaseInOut:
            self.counter = [[UILabelCounterEaseInOut alloc]init];
            break;
        default:
            break;
    }
    
    CADisplayLink *timer= [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    timer.frameInterval =2;
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    self.timer = timer;
}

-(float)roundFloat:(float)price{
    return roundf(price);
}

- (void) countFormaCurrentValueTo:(CGFloat)endValue
{
    [self countForm:[self currantValue] to:endValue];
}
- (void)countFormaCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration
{
    [self countForm:[self currantValue] to:endValue withDuration:duration];
}
- (void)countFromZeroTo:(CGFloat)endValue
{
    [self countForm:0.0f to:endValue];
}
- (void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration
{
    [self countForm:0.0f to:endValue withDuration:duration];
}

#pragma mark - 数字改变
- (void)updateValue:(NSTimer*)timer
{
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    self.progress += now-self.lastUpdate;
    self.lastUpdate = now;
    if (self.progress >= self.totalTime)
    {
        [self.timer invalidate];
        self.timer = nil;
        self.progress = self.totalTime;
    }
    [self setTextValue:[self currantValue]];
    if (self.progress == self.totalTime)
    {
        [self runCompletionBlock];
        self.text = [NSString stringWithFormat:@"%@%@",self.unit,[NSString getValueStr:self.oldMoney]];
    }
}
// 数据处理
- (void)setTextValue:(CGFloat)value
{
    if (self.attributedFormatBlock != nil)
    {
        self.attributedText = self.attributedFormatBlock(value);
    }
    else if (self.formatBlock != nil)
    {
        self.text = self.formatBlock(value);
    }
    else
    {
        // check ifcounting with ints - cast to int
        if ([self.format rangeOfString:@"%(.*)d" options:NSRegularExpressionSearch].location != NSNotFound || [self.format rangeOfString:@"%(.*)i"].location != NSNotFound)
        {
            self.text = [NSString stringWithFormat:self.format,(int)value];
        }
        else
        {
            //self.text = [NSString getValueStr:[NSString stringWithFormat:@"%f",value]];
             NSString *str = [NSString stringWithFormat:self.format,value];
//            // 带千分位分隔符
            if (self.positiveFormat.length>0)
            {

                NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
                // 设置千分号分隔符
                formatter.numberStyle = NSNumberFormatterDecimalStyle;
                [formatter setPositiveFormat:self.positiveFormat];
                self.text = [NSString stringWithFormat:@"%@%@",self.unit,[NSString getValueStr:str]];
//                self.text = [NSString stringWithFormat:@"%@%@",self.unit,[formatter stringFromNumber:[NSNumber numberWithFloat:[str floatValue]]]];
            }
            else
            {
                self.text = [NSString stringWithFormat:@"%@%@",self.unit,[NSString getValueStr:self.text]];
               // self.text = [NSString stringWithFormat:@"%@%@",self.unit,str];
            }
        }
    }
}

- (void)setFormat:(NSString *)format
{
    _format = format;
    //  更新lable的展示样式
    [self setTextValue:self.currantValue];
    
}
- (void)runCompletionBlock
{
    if (self.completionBlock)
    {
        self.completionBlock();
        self.completionBlock = nil;
    }
}
- (CGFloat)currantValue
{
    if (self.progress >= self.totalTime)
    {
        return self.destinationValue;
    }
    CGFloat percent = self.progress/self.totalTime;
    CGFloat updateVal = [self.counter update:percent];
    return self.startingValue + (updateVal *(self.destinationValue-self.startingValue));
}
@end
