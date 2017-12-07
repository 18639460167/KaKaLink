//
//  UIAlertView+HYAlertAction.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^alertAction)(NSInteger index);
@interface UIAlertView (HYAlertAction)<UIAlertViewDelegate>

+ (void)HYAlertTitle:(NSString *)message alertAction:(alertAction)handler;

@end
