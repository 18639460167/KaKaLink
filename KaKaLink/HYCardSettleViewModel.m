//
//  HYCardSettleViewModel.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardSettleViewModel.h"

@implementation HYCardSettleViewModel
@synthesize pageSize;
@synthesize pageIndex;
@synthesize settleModelArray;
@synthesize total_count;

- (instancetype)init
{
    if (self = [super init])
    {
        pageSize = 20;
        pageIndex = 0;
        total_count = 0;
        settleModelArray = [NSMutableArray new];
        
    }
    return self;
}

- (void)loadNewList:(HYHandler)complete
{
    pageIndex = 0;
    total_count = 0;
    settleModelArray = [NSMutableArray new];
    [self getVertifyList:complete];
}

- (void)loadMore:(HYHandler)complete
{
    if ((pageIndex+1)*pageSize>=total_count)
    {
        if (complete)
        {
            complete(LS(@"Not_More"));
        };
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
    NSString *sign = [NSString stringWithFormat:@"%@%@",oid,SHOP_CODE];
    sign = [sign md5];
    [param setObject:sign forKey:@"sign"];
    [HYHttpClient doCardPost:@"/settlement/batch/batchList.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
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
                            [self.settleModelArray removeAllObjects];
                        }
                        id list = [result objectForKey:@"list"];
                        if ([list isKindOfClass:[NSArray class]])
                        {
                            for (NSDictionary *dic in list)
                            {
                                HYCardSettleBatchModel *model = [HYCardSettleBatchModel initWithDic:dic];
                                [self.settleModelArray addObject:model];
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


@end
