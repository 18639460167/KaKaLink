//
//  UITextField+Length.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Length)

- (void)controlLength:(NSInteger)legth;

+ (instancetype)createTxt:(NSString *)place font:(CGFloat)font textColor:(UIColor *)txtColor delegate:(id)cDelete;
@end
