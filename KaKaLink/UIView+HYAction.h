//
//  UIView+HYAction.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HYAction)

+ (instancetype)createView:(UIColor *)bgColor superView:(UIView *)superView;

+ (instancetype)createLineView:(CGFloat)left superView:(UIView *)superView;

- (void)drawClearView:(CGRect)rect;

@end
