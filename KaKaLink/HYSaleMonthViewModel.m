//
//  HYSaleMonthViewModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSaleMonthViewModel.h"

@implementation HYSaleMonthViewModel

+ (void)getMonthData:(NSString *)startDate endDate:(NSString *)endDate shopMid:(NSString *)shopMid handler:(void(^)(NSString *status,NSArray *dataArray))complete
{
    NSString *startYear = @"";
    NSString *startMonth = @"";
    NSString *endYear = @"";
    NSString *endMonth = @"";
    NSArray *startArray = [startDate componentsSeparatedByString:@"-"];
    if (startArray.count>=2)
    {
        startYear = startArray[0];
        startMonth = startArray[1];
    }
    NSArray *endArray = [endDate componentsSeparatedByString:@"-"];
    if (endArray.count>=2)
    {
        endYear = endArray[0];
        endMonth = endArray[1];
    }
    startMonth = [NSString stringWithFormat:@"%d",[startMonth intValue]];
    endMonth = [NSString stringWithFormat:@"%d",[endMonth intValue]];
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:startYear forKey:@"startYear"];
    [param setObject:startMonth forKey:@"startMonth"];
    [param setObject:endYear forKey:@"endYear"];
    [param setObject:endMonth forKey:@"endMonth"];
    [param setObject:shopMid forKey:@"mid"];
    [HYHttpClient doPost:@"/settlement/month/stats.json" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                if (response.mStatus==HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN,nil);
                }
                else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                    id jsObject=response.mResult;
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]],nil);
                    }
                    else
                    {
                        complete(LS(@"Disconnect_Internet"),nil);
                    }
                }
                else if(response.mStatus == HY_HTTP_OK)
                {
                    id jsObject = response.mResult;
                    id result = [jsObject objectForKey:@"result"];
                    if ([result isKindOfClass:[NSArray class]])
                    {
                        NSMutableArray *modelArray = [NSMutableArray new];
                        for (NSDictionary *dic in result)
                        {
                            HYSaleMonthModel *model = [[HYSaleMonthModel alloc]initWithDic:dic];
                            [modelArray addObject:model];
                        }
                        complete(REQUEST_SUCCESS,modelArray);
                    }
                    else
                    {
                        complete(LS(@"Disconnect_Internet"),nil);
                    }
                }
                else
                {
                     complete(LS(@"Disconnect_Internet"),nil);
                }
            }));
        });

    }];
}

+ (void)getMOnthMoney:(backHandler)complete
{
    [HYHttpClient doPost:@"/settlement/stats.json" param:nil timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                if (response.mStatus==HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN);
                }
                else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                    id jsObject=response.mResult;
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
                    }
                    else
                    {
                        complete(LS(@"Disconnect_Internet"));
                    }
                }
                else if(response.mStatus == HY_HTTP_OK)
                {
                    id jsObject = response.mResult;
                    id result = [jsObject objectForKey:@"result"];
                    if ([result isKindOfClass:[NSDictionary class]])
                    {
                        NSString *monthIcome = [NSString trimNSNullAsZero:[result objectForKey:@"current_month_income"]];
                        NSString *account = [NSString trimNSNullAsFloatZero:[result objectForKey:@"account_balance"]];
                        SET_USER_DEFAULT(monthIcome, SALE_MONTH_INCOME);
                        SET_USER_DEFAULT(account, SALE_ACCOUNT_BALANCE);
                        complete(REQUEST_SUCCESS);
                    }
                    else
                    {
                        complete(LS(@"Disconnect_Internet"));
                    }
                }
                else
                {
                    complete(LS(@"Disconnect_Internet"));
                }
            }));
        });

    }];
}
@end
