//
//  HYCardVertifyViewModel.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardVertifyViewModel.h"

@implementation HYCardVertifyViewModel
@synthesize pageSize;
@synthesize pageIndex;
@synthesize vertifyModelArray;
@synthesize total_count;
@synthesize cardtype;
@synthesize totalAmount;
@synthesize couponType;

- (instancetype)init
{
    if (self = [super init])
    {
        pageSize = 20;
        pageIndex = 0;
        total_count = 0;
        cardtype = cardType_All;
        totalAmount = @"0";
        couponType = @"0";
        vertifyModelArray = [NSMutableArray new];
        
    }
    return self;
}

- (void)loadNewList:(HYHandler)complete
{
    pageIndex = 0;
    total_count = 0;
    totalAmount = @"0";
    vertifyModelArray = [NSMutableArray new];
    [self getVertifyList:complete];
}

- (void)loadMore:(HYHandler)complete
{
    if ((pageIndex+1)*pageSize>=total_count)
    {
        if (complete)
        {
            complete(LS(@"Not_More"));
        }
    }
    else
    {
        pageIndex ++;
        [self getVertifyList:complete];
    }
}
- (void)getVertifyList:(HYHandler)complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSString *oid = (NSString*)READ_USER_MESSAGE(SHOP_ID);
    [param setObject:oid forKey:@"oid"];
    [param setObject:[NSString stringWithFormat:@"%ld",(long)pageIndex] forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [param setObject:couponType forKey:@"couponType"];
    NSString *sign = [NSString stringWithFormat:@"%@%@",oid,SHOP_CODE];
    sign = [sign md5];
    [param setObject:sign forKey:@"sign"];
    [HYHttpClient doCardPost:@"/verification/list/verificationList.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                self.isRequestFail = YES;
                if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN);
                }
                else if (response.mStatus == HY_HTTP_OK)
                {
                    id jsObject=response.mResult;
                    id result = [jsObject objectForKey:@"result"];
                    if ([result isKindOfClass:[NSDictionary class]])
                    {
                        NSString *page = [NSString trimnsNullasIntValue:[result objectForKey:@"page"]];
                        self.pageIndex = [page integerValue];
                        self.total_count = [[NSString trimnsNullasIntValue:[result objectForKey:@"totalCount"]] integerValue];
                        self.totalAmount = [NSString trimCardNSNullAsFloat:[result objectForKey:@"totalAmount"]];
                        if (pageIndex == 0)
                        {
                            [self.vertifyModelArray removeAllObjects];
                        }
                        id list = [result objectForKey:@"list"];
                        if ([list isKindOfClass:[NSArray class]])
                        {
                            for (NSDictionary *dic in list)
                            {
                                HYCardVertifyModel *model = [HYCardVertifyModel createWithDic:dic];
                                [self.vertifyModelArray addObject:model];
                            }
                        }
                        self.isRequestFail = NO;
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

#pragma mark - 核销
+ (void)cardVerification:(NSString *)qrCode withComplete:(void (^)(id, NSString *))complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:qrCode forKey:@"qrCode"];
    NSString *sign = [NSString stringWithFormat:@"%@%@",qrCode,SHOP_CODE];
    sign = [sign md5];
    [param setObject:sign forKey:@"sign"];

    [HYHttpClient doCardPost:@"/verification/action/verification.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                id jsObject=response.mResult;
                if ([response.errcode isEqualToString:@"3"])
                {
                    complete(nil,LS(@"Voucher_Had_Verificated"));
                }
                else if ([response.errcode isEqualToString:@"4"])
                {
                    complete(nil,LS(@"Card_Expired"));
                }
                else if ([response.errcode isEqualToString:@"5"])
                {
                    complete(nil,LS(@"Ticket_Not_Confirmed"));
                }
                else
                {
                    if (response.mStatus == HY_HTTP_UNLOGIN)
                    {
                        complete(nil, SHOP_NO_LOGIN);
                    }
                    else if (response.mStatus == HY_HTTP_OK)
                    {
                        id result = [jsObject objectForKey:@"result"];
                        if ([result isKindOfClass:[NSDictionary class]])
                        {
                            HYCardVertifyModel *model = [HYCardVertifyModel createWithDic:result];
                            complete(model,REQUEST_SUCCESS);
                        }
                        else
                        {
                            complete(nil, LS(@"Disconnect_Internet"));
                        }
                    }
                    else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                    {
                        complete(nil, [NSString stringWithFormat:@"%@%@ %@",LS(@"Card_Number"),qrCode,LS(@"Not_Find")]);
                    }
                    else
                    {
                        complete(nil, LS(@"Disconnect_Internet"));
                    }
                }
            }));
        });
    }];
}

#pragma mark - 核销详情

+ (void)verificationDetail:(NSString *)hyorderID withComplete:(void (^)(id, NSString *))complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:hyorderID forKey:@"hyOrderID"];
    NSString *sign = [NSString stringWithFormat:@"%@%@",hyorderID,SHOP_CODE];
    sign = [sign md5];
    [param setObject:sign forKey:@"sign"];
    NSLog(@"==%@",param);
    [HYHttpClient doCardPost:@"/verification/list/verificationOrderDetail.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
        NSLog(@"请求详情==%@",response.mResult);
        if (response.mStatus == HY_HTTP_UNLOGIN)
        {
            complete(nil,SHOP_NO_LOGIN);
        }
        else if(response.mStatus == HY_HTTP_OK)
        {
            id result = [response.mResult objectForKey:@"result"];
            if ([result isKindOfClass:[NSDictionary class]])
            {
                HYCardVertifyModel *model = [HYCardVertifyModel createWithDic:result];
                complete(model,REQUEST_SUCCESS);
            }
            else
            {
                complete(nil, LS(@"Disconnect_Internet"));
            }
        }
        else
        {
             complete(nil, LS(@"Disconnect_Internet"));
        }
            }));
        });
    }];
}

#pragma mark --商品详情--
+ (void)cardGoodsDetail:(NSString *)otapid otaPackageID:(NSString *)otaPackageID withComplete:(void (^)(id, NSString *))complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:otapid forKey:@"otaPid"];
    NSString *sign = [NSString stringWithFormat:@"%@%@",otapid,SHOP_CODE];
    sign = [sign md5];
    [param setObject:sign forKey:@"sign"];
    [HYHttpClient doCardPost:@"/verification/query/getProductInfo.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                NSLog(@"==%@",response.mResult);
                if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    complete(nil,SHOP_NO_LOGIN);
                }
                else if (response.mStatus == HY_HTTP_OK)
                {
                    id jsObject=response.mResult;
                    id result = [jsObject objectForKey:@"result"];
                    if ([result isKindOfClass:[NSDictionary class]])
                    {
                        NSString *tileMessage = [NSString trimNSNullAsNoValue:[result objectForKey:@"foodPkgDetail"]];
                        if (![tileMessage isEqualToString:@""])
                        {
                            NSData *jsonData = [tileMessage dataUsingEncoding:NSUTF8StringEncoding];
                            NSError *error;
                            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
                            if (error)
                            {
                                complete(nil,LS(@"Disconnect_Internet"));
                            }
                            else
                            {
                                NSArray *array = (NSArray *)jsonObject;
                                HYGoodsListModel *listModel = [HYGoodsListModel createWithDic:[NSDictionary new]];
                                for (NSDictionary *dic in array)
                                {
                                    HYGoodsListModel *model = [HYGoodsListModel createWithDic:dic];
                                    if ([model.otaPackageID isEqualToString:otaPackageID])
                                    {
                                        listModel = model;
                                        break;
                                    }
                                }
                                complete(listModel,REQUEST_SUCCESS);
                            }
                        }
                        else
                        {
                            complete(nil,LS(@"Disconnect_Internet"));
                        }
                    }
                    else
                    {
                        complete(nil,LS(@"Disconnect_Internet"));
                    }
                }
                else
                {
                    complete(nil,LS(@"Disconnect_Internet"));
                }
                
            }));
        });
    }];
}


@end
