//
//  HYLoginViewModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/5.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYLoginViewModel.h"
#import "DefineHeard.h"
#import "PushNumberModel.h"
#import "HYShopMessage.h"
#import "HYAccountService.h"

@implementation HYLoginViewModel

/**
 *  用户登录
 *
 */
+ (void)loginWithUserName:(NSString *)userName withPassword:(NSString *)password withComplete:(HYHandler)complete
{
    NSMutableDictionary*param = [[NSMutableDictionary alloc]init];
    [param setObject:password forKey:@"shop_psw"];
    [param setObject:userName forKey:@"shop_id"];
    [param setObject:@"1" forKey:@"device_type"];
    NSString *token = @"";
    if (USER_DEFAULT(SHOP_DEVICE_TOKEN))
    {
        token = USER_DEFAULT(SHOP_DEVICE_TOKEN);
    }
    [param setObject:token forKey:@"device_token"];
    [HYHttpClient noHeadPost:@"/sso/login.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                id jsObject=response.mResult;
                NSLog(@"==%@",response.mResult);
                if (response.mStatus==HY_HTTP_FAILED)
                {
                    complete(LS(@"Disconnect_Internet"));
                }
               else  if (response.mStatus == HY_HTTP_OK)
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
                            NSDictionary *dic = [accountInfo objectForKey:@"customerServiceEntity"];
                            
                            [HYShopMessage sharedModel].servicePhone = [NSString trimNSNullAsNoValue:[dic objectForKey:[NSString getPhone]]];
                            SET_USER_DEFAULT([HYShopMessage sharedModel].servicePhone, HY_SERVICE_PHONE);
                            SYN_USER_DEFAULT;
                            id shopList  = [accountInfo objectForKey:@"mShopList"];
                            [HYShopMessage sharedModel].shopListArray = [NSMutableArray new];
                            for (NSDictionary *sdic in shopList)
                            {
                                HYShopListModel *model = [[HYShopListModel alloc]initWithDic:sdic];
                                [[HYShopMessage sharedModel].shopListArray  addObject:model];
                            }
                            [[HYShopMessage sharedModel] saveShopList];
                           
                            NSString *number = [NSString trimnsNullasIntValue:[result objectForKey:@"unReadMsgCount"]];
                            [PushNumberModel shareModel].pushNumber = [number integerValue];
                            complete(REQUEST_SUCCESS);
                        }
                        else
                        {
                            complete(LS(@"Disconnect_Internet"));
                        }
                    }
                }

                else
                {
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
                    }
                    else
                    {
                        complete(LS(@"Disconnect_Internet"));
                    }
                }

            }));
        });
    }];
}

/**
 *  退出登录
 *
 */
+ (void)userLogoutWithCompleteBlock:(HYHandler)complete
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [HYHttpClient doPost:@"/sso/logout.do" param:param timeInterVal:10 callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
        if (response.mStatus==HY_HTTP_FAILED)
        {
            complete(SHOP_NO_LOGIN);
        }
        else if (response.mStatus==HY_HTTP_UNRIGHTMESSAGE)
        {
            complete(SHOP_NO_LOGIN);
        }
        else
        {
            complete(SHOP_NO_LOGIN);
        }
        }));
    });
}];
}
@end
