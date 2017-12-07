//
//  HYLoadingView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^loadBack)(void);

@interface HYLoadingView : UIView

+ (void)showLoading:(NSString *)message;

+ (void)showLoading:(NSString *)message animationDuration:(CGFloat)duration;

+ (void)showLoading:(NSString *)message handler:(loadBack)complete;

+ (void)showLoading:(NSString *)message height:(CGFloat)heigth handler:(loadBack)complete;

@end
