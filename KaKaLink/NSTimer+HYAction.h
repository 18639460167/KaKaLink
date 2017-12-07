//
//  NSTimer+HYAction.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HYAction)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

+ (NSTimer *)hy_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block;

@end
