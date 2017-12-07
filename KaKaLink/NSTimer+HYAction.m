//
//  NSTimer+HYAction.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "NSTimer+HYAction.h"

@implementation NSTimer (HYAction)

- (void)pause
{
    if (!self.isValid)
    {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume
{
    if (!self.isValid)
    {
        return;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time
{
    if (!self.isValid)
    {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

+ (NSTimer *)hy_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)(NSTimer *))block
{
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(timeFired:) userInfo:block repeats:yesOrNo];
}

+ (void)timeFired:(NSTimer *)timer
{
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block)
    {
        block(timer);
    }
}

@end
