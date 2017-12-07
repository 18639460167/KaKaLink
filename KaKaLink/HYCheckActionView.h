//
//  HYCheckActionView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/9.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCheckSelectView.h"
#import "HYCheckClickView.h"
#import "HYTransViewModel.h"
#import "BDHomeViewController.h"
@interface HYCheckActionView : UIView

@property (nonatomic, copy) void(^actionHandler) (NSString *payID,NSString *timeID);

@property (nonatomic, copy) shopModel actionSelectShop;

+ (instancetype)createView:(BDHomeViewController *)vc transModel:(HYTransViewModel *)model;

- (void)reloadShopList;


@end
