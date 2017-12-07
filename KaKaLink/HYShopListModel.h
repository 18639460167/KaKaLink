//
//  HYShopListModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYShopListModel : HYModel<NSCoding>

@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *qrCode;

// dish
@property (nonatomic, copy) NSString *summary; // 副标题
@property (nonatomic, copy) NSString *logoUrl;

@property (nonatomic, copy) NSString *notice; // 商铺公告

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
