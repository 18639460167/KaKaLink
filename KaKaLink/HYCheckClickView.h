//
//  HYCheckClickView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/4.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSelectShopView.h"

@interface HYCheckClickView : UIView

@property (nonatomic, strong) UILabel *clickShopLbl;
@property (nonatomic, copy) shopModel selectShopModel;

- (void)loadDataShopList;

@end
