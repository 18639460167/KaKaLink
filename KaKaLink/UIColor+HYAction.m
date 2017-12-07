//
//  UIColor+HYAction.m
//  TourGuidShop
//
//  Created by Black on 17/6/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "UIColor+HYAction.h"

@implementation UIColor (HYAction)

/**
 *  十六进制转化为颜色
 *
 *  @param stringToConvert 十六进制
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)subjectColor
{
    return [UIColor colorWithHexString:@"#00aee5"];
}

+ (UIColor *)threeTwoColor
{
    return [UIColor colorWithHexString:@"#323232"];
}

+ (UIColor *)sixFourColor
{
    return [UIColor colorWithHexString:@"#646464"];
}

+ (UIColor *)fSixColor
{
    return [UIColor colorWithHexString:@"#f6f6f6"];
}

+ (UIColor *)eOneColor
{
    return [UIColor colorWithHexString:@"#e1e1e1"];
}

+ (UIColor *)fZeroColor
{
    return [UIColor colorWithHexString:@"#f0f0f0"];
}

+ (UIColor *)nineSixColor
{
    return [UIColor colorWithHexString:@"#969696"];
}

+ (UIColor *)bFourColor
{
    return [UIColor colorWithHexString:@"#b4b4b4"];
}

+ (UIColor *)eNineColor
{
    return [UIColor colorWithHexString:@"#e99316"];
}

@end
