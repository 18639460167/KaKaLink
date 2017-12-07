//
//  HYCommonViewModel.m
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCommonViewModel.h"

@implementation HYCommonViewModel

+ (void)commonPaymentChannel:(void (^)(NSString *, NSMutableArray *))complete
{
    [HYHttpClient doPost:@"/common/payment_channel/list.json" param:nil timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
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
                            HYMessageModel *model = [HYMessageModel createDic:dic];
                            [modelArray addObject:model];
                        }
                        HYMessageModel *mModel = [HYMessageModel createDic:[NSDictionary new]];
                        mModel.title = LS(@"All");
                        mModel.tID = @"0";
                        mModel.isSelect = true;
                        [modelArray insertObject:mModel atIndex:0];
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

@end
