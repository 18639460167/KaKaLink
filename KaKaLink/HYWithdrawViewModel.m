//
//  HYWithdrawViewModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYWithdrawViewModel.h"

@implementation HYWithdrawViewModel
@synthesize pageIndex;
@synthesize withdrawTotal;
@synthesize withdrawListArray;
@synthesize pageSize;

- (instancetype)init
{
    if (self = [super init])
    {
        pageSize = 20;
        withdrawTotal = 0;
        withdrawListArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (BOOL)canLoadMore
{
    if ((pageIndex+1)*pageSize>=withdrawTotal)
    {
        return NO;
    }
    return YES;
}

/**
 *  加载更多
 */
- (void)loadMore:(backHandler)complete
{
    if (withdrawTotal<pageIndex*pageSize)
    {
        complete(@"");
    }
    else
    {
        pageIndex ++;
        [self getWithdrawList:complete];
    }
}
/**
 *  加载新数据
 *
 */
- (void)loadNewList:(backHandler)complete
{
    pageIndex = 0;
    [self getWithdrawList:complete];
}

#pragma mark - 数据加载
- (void)getWithdrawList:(backHandler)complete
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:[NSString stringWithFormat:@"%d",(int)pageIndex] forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%d",(int)pageSize] forKey:@"size"];
    [HYHttpClient doPost:@"/withdraw/list.json" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
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
                            [withdrawListArray removeAllObjects];
                        }
                        if (![[result objectForKey:@"total_count"] isEqual:[NSNull null]])
                        {
                            NSString *withTo = [NSString trimnsNullasIntValue:[result objectForKey:@"total_count"]];
                            withdrawTotal=[withTo integerValue];
                        }
                        else
                        {
                            withdrawTotal=0;
                        }
                        id list = [result objectForKey:@"list"];
                        if ([list isKindOfClass:[NSArray class]])
                        {
                            for (NSDictionary *dic in list)
                            {
                                HYWithdrawModel *model = [[HYWithdrawModel alloc]initWithDic:dic];
                                [withdrawListArray addObject:model];
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

#pragma mark - 用户提现

+ (void)shopWithdrawMoney:(NSString *)money pass:(NSString *)applyPass complete:(backHandler)handler
{
    NSMutableDictionary*param = [[NSMutableDictionary alloc]init];
    [param setObject:money forKey:@"amount"];
    [param setObject:applyPass forKey:@"trans_password"];
    
    [HYHttpClient doPost:@"/withdraw/apply.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
        id jsObject=response.mResult;
        NSLog(@"%@",jsObject);
        if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
        {
            if ([jsObject isKindOfClass:[NSDictionary class]])
            {
                handler([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);

            }
            else
            {
                handler(LS(@"Disconnect_Internet"));
            }
        }
        else if (response.mStatus == HY_HTTP_UNLOGIN)
        {
            handler(SHOP_NO_LOGIN);
        }
        else if (response.mStatus==HY_HTTP_OK)
        {
            handler(REQUEST_SUCCESS);
        }
        else
        {
            handler(LS(@"Disconnect_Internet"));
        }
            }));
        });
    }];
}

#pragma mark - 订单详情

+ (void)getWithdrawDetail:(NSString *)withdraw_id complete:(void (^)(NSString *, HYWithdrawModel *))handler
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:withdraw_id forKey:@"withdraw_id"];
    [HYHttpClient doPost:@"/withdraw/detail.json" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                id jsObject=response.mResult;
                NSLog(@"%@",jsObject);
                if (response.mStatus == HY_HTTP_UNRIGHTMESSAGE)
                {
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        handler([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]],nil);
                    }
                    else
                    {
                        handler(LS(@"Disconnect_Internet"),nil);
                    }
                }
                else if (response.mStatus == HY_HTTP_UNLOGIN)
                {
                    handler(SHOP_NO_LOGIN,nil);
               
                }
                else if (response.mStatus==HY_HTTP_OK)
                {
                    if ([jsObject isKindOfClass:[NSDictionary class]])
                    {
                        HYWithdrawModel *model = [[HYWithdrawModel alloc]initWithDic:jsObject];
                        handler(REQUEST_SUCCESS,model);
                    }
                    else
                    {
                        handler(LS(@"Disconnect_Internet"),nil);
                    }
                }
                else
                {
                    handler(LS(@"Disconnect_Internet"),nil);
                }
            }));
        });
    }];
}
@end
