//
//  HYShopMessage.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"
#import "HYShopListModel.h"
@interface HYShopMessage : HYModel

@property (nonatomic, copy) NSString *bank_account_name;
@property (nonatomic, copy) NSString *bank_account_number;
@property (nonatomic, copy) NSString *bank_branck_name;
@property (nonatomic, copy) NSString *bank_trunk_name;
@property (nonatomic, copy) NSString *contact_name; // 联系人
@property (nonatomic, copy) NSString *contact_email;
@property (nonatomic, copy) NSString *contact_phone;
@property (nonatomic, copy) NSString *shop_id;      // id
@property (nonatomic, copy) NSString *servicePhone; // 客服电话
@property (nonatomic, copy) NSString *current_unid; // 当前单位
@property (nonatomic, copy) NSString *current_sign; // 货币单位
@property (nonatomic, copy) NSString *yw_username; // 云旺账号
@property (nonatomic, assign) BOOL isCanDish; // 是否可以点菜
@property (nonatomic, strong) NSMutableArray *shopListArray; // 商店列表

@property (nonatomic, copy) NSString *language; // 当前语言;

@property (nonatomic, copy) NSString *isChange;

+ (instancetype)sharedModel;

- (void)messageDic:(NSDictionary *)dic;

- (void)saveShopList;

- (NSMutableArray *)getShopListArray;

- (void)replaceShopMessage:(HYShopListModel *)model;



@end
