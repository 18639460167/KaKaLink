//
//  HYSaleQueryViewModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYViewModel.h"

@interface HYSaleQueryViewModel : HYViewModel

@property (nonatomic, assign) NSInteger orderTotal;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *orderListArray;
@property (nonatomic, copy) NSString *settle_status;

@property (nonatomic, assign) BOOL isRequestFail;

@property (nonatomic, copy) NSString *total_count;
@property (nonatomic, copy) NSString *total_trans_amount;
@property (nonatomic, copy) NSString *total_settle_amount;

- (void)loadNewLostStart:(NSString *)startTime endTime:(NSString*)endTime handler:(backHandler)complete;
- (void)loadMoreStart:(NSString *)startTime endTime:(NSString*)endTime handler:(backHandler)complete;
- (BOOL) canLoadMore;

/**
 *  发送订单
 */
+ (void)sendOrderList:(NSString *)startTime endTime:(NSString *)endTime email:(NSString *)email settleStatus:(NSString *)status handler:(backHandler)complete;
@end
