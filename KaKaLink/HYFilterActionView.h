//
//  HYFilterActionView.h
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYFilterActionView : UIView

+ (void)createFilterView:(UIViewController *)vc timeID:(NSString *)timeID payID:(NSString *)payID complate:(void(^)(NSString *payID,NSString *timeID))complete;

@end
