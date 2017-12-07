//
//  HYTransViewModel.m
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYTransViewModel.h"

@implementation HYTransViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        self.orderListArray = [NSMutableArray new];
        self.orderTotal = 0;
        self.pageIndex = 0;
        self.finishStatus = HYFinishStatus_Success;
        self.mID = @"0";
        self.total_settle_amout = @"0";
        self.totalCount = @"0";
        self.channel = @"0";
        self.period = @"2"; // 默认全部
        
        
    }
    return self;
}

- (void)modelReloadData
{
    self.total_settle_amout = @"0";
    self.totalCount = @"0";
    self.mID = @"0";
    self.period = @"2";
    self.channel = @"0";
    self.isRequestFailed = NO;
    
    self.orderListArray = [NSMutableArray new];
}

- (void)loadNewOrderList:(HYHandler)complete
{
    self.pageIndex = 0;
    self.totalCount = @"0";
    self.total_settle_amout = @"0";
    self.orderListArray = [NSMutableArray new];
    [self getOrderlist:complete];
}
- (void)loadMoreOrder:(HYHandler)complete
{
    if ((self.pageIndex + 1) * PAGESIZE >= [self.totalCount integerValue])
    {
        if (complete)
        {
            complete(LS(@"Not_More"));
        }
        return;
    }
    else
    {
        self.pageIndex ++;
        [self getOrderlist:complete];
    }
}

#pragma mark - 数据处理

- (void)getOrderlist:(HYHandler)complete
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:self.channel forKey:@"channel"];
    [param setObject:[NSString stringWithFormat:@"%d",(int)self.pageIndex] forKey:@"page"];
    [param setObject:self.mID forKey:@"mid"];
    [param setObject:self.period forKey:@"period"];
    [param setObject:[HYModel getFinishString:self.finishStatus] forKey:@"finish_status"];
    [HYHttpClient doPost:@"/trans/list.json" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                self.isRequestFailed = YES;
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
                        if (![[result objectForKey:@"page"] isEqual:[NSNull null]])
                        {
                            NSString *page = [NSString trimnsNullasIntValue:[result objectForKey:@"page"]];
                            self.pageIndex=[page integerValue];
                        }
                        else
                        {
                            self.pageIndex=0;
                        }
                        if (self.pageIndex == 0)
                        {
                            [self.orderListArray removeAllObjects];
                        }
                        if (![[result objectForKey:@"total_count"] isEqual:[NSNull null]])
                        {
                            self.totalCount = [NSString trimnsNullasIntValue:[result objectForKey:@"total_count"]];
                        }
                        else
                        {
                            self.totalCount = @"0";
                        }
                        if (![[result objectForKey:@"total_settle_amount"] isEqual:[NSNull null]])
                        {
                            self.total_settle_amout = [NSString trimNSNullAsZero:[result objectForKey:@"total_settle_amount"]];
                        }
                        else
                        {
                            self.total_settle_amout = @"0";
                        }
                        id list = [result objectForKey:@"list"];
                        if ([list isKindOfClass:[NSArray class]])
                        {
                            for (NSDictionary *dic in list)
                            {
                                // 数据处理
                                
                                HYTransModel *model = [HYTransModel createWithDic:dic];
                                [self.orderListArray addObject:model];
                            }
                        }
                        self.isRequestFailed = NO;
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

#pragma mark - 获取订单详情

+ (void)getTransDetail:(NSString *)orderID handler:(void (^)(NSString *, HYTransModel *))complete
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:orderID forKey:@"trans_id"];
    [HYHttpClient doPost:@"/trans/detail.json" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                id jsObject=response.mResult;
                if (response.mStatus == HY_HTTP_OK)
                {
                    id result = [jsObject objectForKey:@"result"];
                    if ([result isKindOfClass:[NSDictionary class]])
                    {
                        HYTransModel *model = [HYTransModel createWithDic:result];
                        complete(REQUEST_SUCCESS,model);
                    }
                    else
                    {
                        complete(LS(@"Disconnect_Internet"),nil);
                    }
                }
                else if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN,nil);
                }
                else if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                    
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]],nil);
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

#pragma mark - 订单退款
+ (void)setOrderRefund:(NSString *)trans_id  refund_reason_type:(NSString *)type reason:(NSString *)reason  pass:(NSString *)pass handler:(HYHandler)complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:pass forKey:@"trans_password"];
    [param setObject:trans_id forKey:@"trans_id"];
    [param setObject:type forKey:@"refund_reason_type"];
    [param setObject:reason forKey:@"refund_reason"];
    [HYHttpClient doPost:@"/trans/refund.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                id jsObject=response.mResult;
                
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
                    
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
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

#pragma mark - 取消退款
+ (void)setCancelRefund:(NSString *)trans_id pass:(NSString *)pass handler:(HYHandler)complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:pass forKey:@"trans_password"];
    [param setObject:trans_id forKey:@"trans_id"];
    [HYHttpClient doPost:@"/trans/refund.cancel" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                id jsObject=response.mResult;
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
                    
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
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
