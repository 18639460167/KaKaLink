//
//  HYAlertView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/17.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HYAlertView : UIView

+ (void)alertShow:(NSString *)okMessage cancelMessage:(NSString *)cancel message:(NSString *)content imageName:(NSString *)name okOrange:(BOOL)isOK messageIsOrange:(BOOL)isOrange handler:(void(^)(void))complete;

+ (void)saveLogo:(void(^)(void))cancel okAction:(void(^)(void))complete;

@end
