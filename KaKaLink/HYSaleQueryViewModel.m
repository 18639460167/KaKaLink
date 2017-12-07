//
//  HYSaleQueryViewModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSaleQueryViewModel.h"

@implementation HYSaleQueryViewModel
@synthesize orderListArray;
@synthesize orderTotal;
@synthesize pageIndex;
@synthesize total_count;
@synthesize total_settle_amount;
@synthesize total_trans_amount;

- (instancetype)init
{
    if (self = [super init])
    {
        pageIndex = 20;
        orderTotal = 0;
        self.total_settle_amount =@"0";
        self.total_trans_amount = @"0";
        self.settle_status = @"";
        orderListArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (BOOL)canLoadMore
{
    if ((pageIndex+1)*20>=orderTotal)
    {
        return NO;
    }
    return YES;
}

#pragma mark- 加载数据
- (void)loadNewLostStart:(NSString *)startTime endTime:(NSString *)endTime handler:(backHandler)complete
{
    pageIndex = 0;
    [self getQueryListOrderStart:startTime endTime:endTime handler:complete];
}
- (void)loadMoreStart:(NSString *)startTime endTime:(NSString *)endTime handler:(backHandler)complete
{
    if ((pageIndex+1)*20>=orderTotal)
    {
        complete(LS(@"Not_More"));
    }
    else
    {
        pageIndex ++;
        [self getQueryListOrderStart:startTime endTime:endTime handler:complete];
    }
}

- (void)getQueryListOrderStart:(NSString *)startTime endTime:(NSString *)endTime handler:(backHandler)complete
{
     NSMutableDictionary*param = [[NSMutableDictionary alloc]init];
    [param setObject:startTime forKey:@"startDate"];
    [param setObject:endTime forKey:@"endDate"];
    [param setObject:self.settle_status forKey:@"settle_status"];
    [param setObject:[NSString stringWithFormat:@"%d",(int)pageIndex] forKey:@"page"];
    [param setObject:@"20" forKey:@"size"];
    [HYHttpClient doPost:@"/settlement/trans/query.json" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                id jsObject=response.mResult;
                if (response.mStatus == HY_HTTP_OK)
                {
                    id result = [jsObject objectForKey:@"result"];
                    if ([result isKindOfClass:[NSDictionary class]])
                    {
                        if (![[result objectForKey:@"page"] isEqual:[NSNull null]])
                        {
                            NSString *page = [NSString trimnsNullasIntValue:[result objectForKey:@"page"]];
                            pageIndex=[page integerValue];
                        }
                        else
                        {
                            pageIndex=0;
                        }
                        if (pageIndex == 0)
                        {
                            [orderListArray removeAllObjects];
                        }
                        if (![[result objectForKey:@"total_count"] isEqual:[NSNull null]])
                        {
                            NSString *total = [NSString trimnsNullasIntValue:[result objectForKey:@"total_count"]];
                            orderTotal=[total integerValue];
                        }
                        else
                        {
                            orderTotal=0;
                        }
                        self.total_trans_amount = [NSString trimnsNullasIntValue:[result objectForKey:@"total_trans_amount"]];
                        self.total_settle_amount = [NSString trimNSNullAsZero:[result objectForKey:@"total_settle_amount"]];
                        id list = [result objectForKey:@"list"];
                        if ([list isKindOfClass:[NSArray class]])
                        {
                            for (NSDictionary *dic in list)
                            {
                                HYTransModel *model = [HYTransModel createWithDic:dic];
                                [orderListArray addObject:model];
                            }
                        }
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

#pragma mark －订单提交
+ (void)sendOrderList:(NSString *)startTime endTime:(NSString *)endTime email:(NSString *)email settleStatus:(NSString *)status handler:(backHandler)complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:startTime forKey:@"startDate"];
    [param setObject:endTime forKey:@"endDate"];
    [param setObject:email forKey:@"email"];
    [param setObject:status forKey:@"settle_status"];
    [HYHttpClient doPost:@"/settlement/trans/mail/send.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN(^{
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
                    id jsObject = response.mResult;
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        NSString *myCode = [NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errcode"]];
                        int value = [myCode intValue];
                        if (value == 4006)
                        {
                            complete(@"操作太频繁");
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
            });
            
        });
    }];
}
@end
