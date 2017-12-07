//
//  UIView+HYAction.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "UIView+HYAction.h"

@implementation UIView (HYAction)

- (void)drawClearView:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.5);
    CGContextFillRect(context, rect);
    
    CGContextClearRect(context, rect);
}

+ (instancetype)createView:(UIColor *)bgColor superView:(UIView *)superView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor = bgColor;
    if (superView)
    {
        [superView addSubview:view];
    }
    return view;
}

+ (instancetype)createLineView:(CGFloat)left superView:(UIView *)superView
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor eOneColor];
    if (superView)
    {
        [superView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(superView.mas_centerX);
            make.left.equalTo(superView).offset(left);
            make.bottom.equalTo(superView);
            make.height.mas_equalTo(0.5);
        }];
    }
    
    return lineView;
}
@end
