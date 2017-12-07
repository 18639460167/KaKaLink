//
//  HYSettingView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^setAction)(void);
@interface HYSettingView : UIView

+ (void)createViewInView:(UIView *)view action:(setAction)complete;

@end
