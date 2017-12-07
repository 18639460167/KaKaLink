//
//  HYShopMessage.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYShopMessage.h"
#import "DefineHeard.h"

@implementation HYShopMessage

+ (instancetype)sharedModel
{
    static dispatch_once_t once;
    static HYShopMessage *shareService;
    dispatch_once(&once, ^{
        shareService = [[self alloc]init];
        shareService.current_unid = @"";
    });
    return shareService;
}
// 赋值
- (void)messageDic:(NSDictionary *)dic
{
    self.bank_account_name = [NSString trimNSNullAsNoValue:[dic objectForKey:@"bank_account_name"]];
    self.bank_account_number = [NSString trimNSNullAsNoValue:[dic objectForKey:@"bank_account_number"]];
    self.bank_branck_name = [NSString trimNSNullAsNoValue:[dic objectForKey:@"bank_branch_name"]];
    self.bank_trunk_name = [NSString trimNSNullAsNoValue:[dic objectForKey:@"bank_trunk_name"]];
    self.contact_email = [NSString trimNSNullAsNoValue:[dic objectForKey:@"owner_email"]];
    self.contact_name = [NSString trimNSNullAsNoValue:[dic objectForKey:@"owner_name"]];
    self.contact_phone = [NSString trimNSNullAsNoValue:[dic objectForKey:@"owner_phone"]];
    self.shop_id = [NSString trimNSNullAsNoValue:[dic objectForKey:@"oid"]];
    self.servicePhone = [NSString trimNSNullAsNoValue:[dic objectForKey:@"servicePhone"]];
    self.current_sign = [NSString trimNSNullAsNoValue:[dic objectForKey:@"currency_sign"]];
    self.yw_username = [NSString trimNSNullAsNoValue:[dic objectForKey:@"yw_username"]];
    self.isCanDish = [self shopCanDish:[dic objectForKey:@"extra_func"]];
    
    BOOL couponEnable = NO;
    couponEnable = [[dic objectForKey:@"couponEnable"] boolValue];
    if (couponEnable)
    {
        SET_USER_DEFAULT(@"具有卡券功能", SHOP_COUPON_ENABLE);
    }
    else
    {
        SET_USER_DEFAULT(@"", SHOP_COUPON_ENABLE);
    }
    
    NSArray *bankArray = @[self.bank_branck_name,self.bank_trunk_name,self.bank_account_name,self.bank_account_number];
    NSString *notifyMessage = [NSString trimNSNullAsNoValue:[dic objectForKey:@"notify_phone"]];
    SET_USER_DEFAULT(notifyMessage, SHOP_IS_BINDMESSAGE);
    NSNumber *isDish = [NSNumber numberWithBool:self.isCanDish];
    
    SET_USER_DEFAULT(isDish, SHOP_DISH_IDINTIFIER);
    SET_USER_DEFAULT(bankArray, SHOP_BANK_MESSAGE);
    SET_USER_DEFAULT(self.yw_username, YW_OWN_USER);
    SET_USER_DEFAULT(self.current_sign, SHOP_MONEY_SIGN);
    SET_USER_DEFAULT(self.contact_name, SHOP_USER_NAME);
    SET_USER_DEFAULT(self.contact_email, SHOP_USER_EMAIL);
    SET_USER_DEFAULT(self.contact_phone, SHOP_USER_PHONE);
    SET_USER_DEFAULT(self.bank_account_name, SHOP_BANK_NAME);
    SET_USER_DEFAULT(self.bank_account_number, SHOP_BANK_NUMBER);
    SET_USER_DEFAULT(self.shop_id, SHOP_ID);
    SYN_USER_DEFAULT;
    self.current_unid = [NSString trimNSNullAsNoValue:[dic objectForKey:@"currency_unit"]];
    self.shopListArray = [NSMutableArray new];
}

#pragma mark - 获取商户列表
- (void)saveShopList
{
    NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:self.shopListArray];
    SET_USER_DEFAULT(encodemenulist, SHOP_NAME_LIST);
    SYN_USER_DEFAULT;
}

- (void)replaceShopMessage:(HYShopListModel *)model
{
    NSMutableArray *array = [[HYShopMessage sharedModel] getShopListArray];
    for (int i=0;i<array.count;i++)
    {
        HYShopListModel *shopModel  = array[i];
        if ([shopModel.mid isEqualToString: model.mid])
        {
            [array replaceObjectAtIndex:i withObject:model];
            NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:array];
            SET_USER_DEFAULT(encodemenulist, SHOP_NAME_LIST);
            SYN_USER_DEFAULT;
            break;
        }
    }

}
- (NSMutableArray *)getShopListArray
{
    
    NSData *data = USER_DEFAULT(SHOP_NAME_LIST);
    NSMutableArray *listArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return listArray;
}

- (BOOL)shopCanDish:(id)aData
{
    NSArray *array = [NSArray new];
    if ([aData isEqual:[NSNull null]] || aData == nil)
    {
        return NO;
    }
    else
    {
        if ([aData isKindOfClass:[NSArray class]])
        {
            array = aData;
            BOOL isHave = [array containsObject:SHOP_CAN_DISH];
            return isHave;
        }
        else
        {
            return NO;
        }
    }
}

@end
