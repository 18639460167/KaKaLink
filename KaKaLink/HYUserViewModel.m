//
//  HYUserViewModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYUserViewModel.h"
#import "HYAccountService.h"
#import "HYHeardRequest.h"

@implementation HYUserViewModel

#pragma  mark - 获取商户信息

+ (void)getShopUserMessage:(HYHandler)complete
{
    [HYHttpClient doPost:@"/account/info.json" param:nil timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                id jsObject=response.mResult;
                if (response.mStatus == HY_HTTP_OK)
                {
                    id result = [jsObject objectForKey:@"result"];
                    if ([result isKindOfClass:[NSDictionary class]])
                    {
                        [[HYAccountService sharedService] saveShopCredentialToken:[NSString trimNSNullAsNoValue:[result objectForKey:@"accessToken"]]];
                        id accountInfo = [result objectForKey:@"accountInfo"];
                        
                        if ([accountInfo isKindOfClass:[NSDictionary class]])
                        {
                            id infoDic = [accountInfo objectForKey:@"accountInfo"];
                            [[HYShopMessage sharedModel] messageDic:infoDic];
                            NSDictionary *dic = [result objectForKey:@"customerServiceEntity"];
                            [HYShopMessage sharedModel].servicePhone = [NSString trimNSNullAsNoValue:[dic objectForKey:[NSString getPhone]]];
                            id shopList  = [accountInfo objectForKey:@"mShopList"];
                            for (NSDictionary *sdic in shopList)
                            {
                                HYShopListModel *model = [[HYShopListModel alloc]initWithDic:sdic];
                                [[HYShopMessage sharedModel].shopListArray addObject:model];
                            }
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
                }
                else if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN);
                }
                else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                    complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
                }
                else
                {
                    complete(LS(@"Disconnect_Internet"));
                }
            }));
        });
    }];
}
#pragma mark - 获取商店列表
+ (void)getShopList:(HYHandler)complete
{
    [HYHttpClient doPost:@"/account/shop/list.json" param:nil timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
        if (response.mStatus == HY_HTTP_OK)
        {
            id jsObject=response.mResult;
            id result = [jsObject objectForKey:@"result"];
            if ([result isKindOfClass:[NSArray class]])
            {
                NSMutableArray *shopListArray = [[NSMutableArray alloc]init];
                for (NSDictionary *dic in result)
                {
                    HYShopListModel *model = [[HYShopListModel alloc]initWithDic:dic];
                    [shopListArray addObject:model];
                }
                SET_USER_DEFAULT(shopListArray, SHOP_NAME_LIST);
                SYN_USER_DEFAULT;
                complete(REQUEST_SUCCESS);
            }
            else
            {
                complete(LS(@"Disconnect_Internet"));
            }
        }
        else if (response.mStatus == HY_HTTP_UNLOGIN)
        {
            complete(SHOP_NO_LOGIN);
        }
        else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
        {
            id jsObject=response.mResult;
            complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
        }
        else
        {
            complete(LS(@"Disconnect_Internet"));
        }
            }));
        });
    }];
}

#pragma mark -交易密码监测
+ (void)checkTransPass:(HYHandler)complete
{
    [HYHttpClient doPost:@"/account/password/trans/check.do" param:nil timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                if (response.mStatus == HY_HTTP_OK)
                {
                    complete(REQUEST_SUCCESS);
                }
                else if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN);
                }
                else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                   
                    id jsObject=response.mResult;
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        NSString *errcode = [NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errcode"]];
                        int code = [errcode intValue];
                        if (code == 1003)
                        {
                            complete(SHOP_TRADE_NO_PASS);
                        }
                        else
                        {
                            complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
                        }
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

+ (void)setTransPass:(NSString *)pass handler:(HYHandler)complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:pass forKey:@"trans_psw"];
    [HYHttpClient doPost:@"/account/password/trans/set.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                NSLog(@"==%@",response.mResult);
                if (response.mStatus == HY_HTTP_OK)
                {
                    complete(REQUEST_SUCCESS);
                }
                else if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN);
                }
                else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                    id jsObject=response.mResult;
                    complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
                }
                else
                {
                    complete(LS(@"Disconnect_Internet"));
                }
            }));
        });
    }];
}

#pragma mark - 云旺注册
+ (void)registerYWUser:(HYHandler)complete
{
    [HYHttpClient doPost:@"/sso/yw/reg.do" param:nil timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN(^{
        if (response.mStatus == HY_HTTP_OK)
        {
            id result =[response.mResult objectForKey:@"result"];
            if ([result isKindOfClass:[NSDictionary class]])
            {
                SET_USER_DEFAULT([result objectForKey:@"username"], YW_OWN_USER);
                SYN_USER_DEFAULT;
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
            });
            
        });
    }];
}

#pragma mark - 手机绑定
+ (void)getNotifyCodePhone:(NSString *)phone handler:(HYHandler)complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:phone forKey:@"phone"];
    [param setObject:[NSString getPhone] forKey:@"country_code"];
    [HYHttpClient doPost:@"/account/notify/code.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                if (response.mStatus == HY_HTTP_OK)
                {
                    complete(REQUEST_SUCCESS);
                }
                else if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN);
                }
                else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                    id jsObject=response.mResult;
                    complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]] );
                }
                else
                {
                    complete(LS(@"Disconnect_Internet"));
                }
            }));
        });

    }];
}

+ (void)notifyCodeBind:(NSString *)notidyCode handler:(HYHandler)complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:notidyCode forKey:@"code"];
    [HYHttpClient doPost:@"/account/notify/verify.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                if (response.mStatus == HY_HTTP_OK)
                {
                    complete(REQUEST_SUCCESS);
                }
                else if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN);
                }
                else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                    id jsObject=response.mResult;
                    complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]] );
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
