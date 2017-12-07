//
//  HYSaleDataView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCountingLable.h"

typedef void (^saleDataAction)(NSInteger index);
@interface HYSaleDataView : UIView

@property (nonatomic, strong)  HYCountingLable *dataLbl;
@property (nonatomic, copy)    saleDataAction complete;

+ (instancetype)createDataView:(UIViewController *)currentVC;
@end
