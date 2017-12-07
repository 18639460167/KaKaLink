//
//  HYCardSettleBatchDetailModel.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/31.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCardSettleBatchDetailModel : NSObject

@property (nonatomic, copy) NSString *bacthno;
@property (nonatomic, copy) NSString *billid;
@property (nonatomic, copy) NSString *categoryID;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *hyorderID;
@property (nonatomic, copy) NSString *orderID;
@property (nonatomic, copy) NSString *otapID;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *settlementDate;
@property (nonatomic, copy) NSString *settlementPrice;
@property (nonatomic, copy) NSString *settlementState;
@property (nonatomic, copy) NSString *settlementCurrency;
@property (nonatomic, copy) NSString *settlementType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *picURL;

@property (nonatomic, assign) BOOL isRequestFail;

+ (instancetype)createWithDic:(NSDictionary *)dic;

- (void)cardSettleDetail:(void(^)(id model, NSString *status))complete;

@end
