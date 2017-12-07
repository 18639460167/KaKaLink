//
//  HYCheckSelectView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^checkSelHandler)(NSInteger section,NSString *selMessage);

@interface HYCheckSelectView : UIView

+ (void)createViewTd:(NSString *)tdStr time:(NSString *)time handler:(checkSelHandler)complete;

@end
