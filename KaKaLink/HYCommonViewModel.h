//
//  HYCommonViewModel.h
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCommonViewModel : NSObject

/**
 *  获取支付通道列表
 *
 *  @param complete 返回结果
 */
+ (void)commonPaymentChannel:(void(^)(NSString *status,NSMutableArray *modelArray))complete;

@end
