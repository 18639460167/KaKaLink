//
//  HYSelectShopView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/4.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYShopMessage.h"

typedef void (^shopModel)(NSString *title,NSString *mid);
@interface HYSelectShopView : UIView

+ (void)createViewInY:(CGFloat)y arrowImage:(UIImageView *)arrow handler:(shopModel)complete;

@end
