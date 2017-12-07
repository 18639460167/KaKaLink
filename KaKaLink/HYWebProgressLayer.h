//
//  HYWebProgressLayer.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface HYWebProgressLayer : CAShapeLayer

+ (instancetype)layerWithFrame:(CGRect)frame;

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
