//
//  UILabel+HYLabelAction.h
//  KaKaLink
//
//  Created by Black on 17/7/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HYLabelAction)


+ (instancetype)createLbl:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color fatherView:(UIView *)fatherView;

+ (instancetype)createRightLbl:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color fatherView:(UIView *)fatherView;

+ (instancetype)createCenterLbl:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color fatherView:(UIView *)fatherView;

@end
