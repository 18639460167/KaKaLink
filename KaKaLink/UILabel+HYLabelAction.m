//
//  UILabel+HYLabelAction.m
//  KaKaLink
//
//  Created by Black on 17/7/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "UILabel+HYLabelAction.h"

@implementation UILabel (HYLabelAction)

+ (instancetype)createLbl:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color fatherView:(UIView *)fatherView
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = FONTSIZE(size);
    label.textColor = color;
    label.text = title;
    if (fatherView)
    {
        [fatherView  addSubview:label];
    }
    return label;
}

+ (instancetype)createRightLbl:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color fatherView:(UIView *)fatherView
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = FONTSIZE(size);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentRight;
    label.text = title;
    if (fatherView)
    {
        [fatherView  addSubview:label];
    }
    return label;
}

+ (instancetype)createCenterLbl:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color fatherView:(UIView *)fatherView
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = FONTSIZE(size);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    if (fatherView)
    {
        [fatherView  addSubview:label];
    }
    return label;
}
@end
