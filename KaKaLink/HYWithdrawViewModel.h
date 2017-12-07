//
//  HYWithdrawViewModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYViewModel.h"
#import "HYWithdrawModel.h"

@interface HYWithdrawViewModel : HYViewModel

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger withdrawTotal; // 提现条数
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *withdrawListArray;

@property (nonatomic, assign) BOOL isReuqestFail; // 是否请求失败

/**
 *  获取提现列表
 */
- (BOOL)canLoadMore;
- (void)loadNewList:(backHandler)complete;
- (void)loadMore:(backHandler)complete;


/**
 *  商户提现
 */

+ (void)shopWithdrawMoney:(NSString *)money pass:(NSString *)applyPass complete:(backHandler)handler;

/**
 *  提现详情
 */
+ (void)getWithdrawDetail:(NSString *)withdraw_id complete:(void(^)(NSString *status, HYWithdrawModel *model))handler;

@end
