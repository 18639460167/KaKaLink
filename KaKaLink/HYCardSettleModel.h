//
//  HYCardSettleModel.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HYCardSettleModel : NSObject

@property (nonatomic, copy) NSString *cashBank;
@property (nonatomic, copy) NSString *categoryID;
@property (nonatomic, copy) NSString *depositAccount;
@property (nonatomic, copy) NSString *hyOrderID;
@property (nonatomic, copy) NSString *orderPrice;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *orderSource;
@property (nonatomic, copy) NSString *otaPid; //  商品ID
@property (nonatomic, copy) NSString *qrCode;
@property (nonatomic, copy) NSString *settleCycle;
@property (nonatomic, copy) NSString *settleDatetime;
@property (nonatomic, copy) NSString *settlePrice;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *unitPrice; // 价格
@property (nonatomic, copy) NSString *qty; // 数量
@property (nonatomic, copy) NSString *verticationDateTime;
@property (nonatomic, copy) NSString *otaPackageID; // 套餐ID

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *messageArray;

+ (instancetype)createWithDic:(NSDictionary *)dic;

@end
