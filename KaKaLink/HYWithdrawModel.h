//
//  HYWithdrawModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYWithdrawModel : HYModel

@property (nonatomic, copy) NSString *amount; // 金额
@property (nonatomic, copy) NSString *audit_reson; // 审计原因
@property (nonatomic, copy) NSString *audit_status; // 审计状态
@property (nonatomic, copy) NSString *audit_time; // 审计时间
@property (nonatomic, copy) NSString *create_time; // 创建时间
@property (nonatomic, copy) NSString *withdraw_id; // 提现id
@property (nonatomic, strong) NSArray *receipt_url; // 凭证链接

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
