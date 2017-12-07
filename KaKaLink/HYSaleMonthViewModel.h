//
//  HYSaleMonthViewModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYViewModel.h"
#import "HYSaleMonthModel.h"

@interface HYSaleMonthViewModel : HYViewModel

/**
 *  月交易记录
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间
 *  @param complete  返回结果
 */

+ (void)getMonthData:(NSString *)startDate endDate:(NSString *)endDate shopMid:(NSString *)shopMid handler:(void(^)(NSString *status,NSArray *dataArray))complete;

/**
 *  获取月交易信息
 */
+ (void)getMOnthMoney:(backHandler)complete;

@end
