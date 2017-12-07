//
//  HYSettleListModel.h
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYSettleListModel : HYModel

@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *mID;
@property (nonatomic, copy) NSString *settlement_id;
@property (nonatomic, copy) NSString *title;

+ (instancetype)createWithDic:(NSDictionary *)dic;

@end
