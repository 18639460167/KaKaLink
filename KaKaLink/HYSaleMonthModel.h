//
//  HYSaleMonthModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYSaleMonthModel : HYModel

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *sale;
@property (nonatomic, copy) NSString *income;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
