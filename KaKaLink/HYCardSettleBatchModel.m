//
//  HYCardSettleBatchModel.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardSettleBatchModel.h"

@implementation HYCardSettleBatchModel
@synthesize pageSize;
@synthesize pageIndex;
@synthesize settleModelArray;
@synthesize total_count;
@synthesize totalAmount;

+ (instancetype)initWithDic:(NSDictionary *)dic
{
    HYCardSettleBatchModel *model = [[HYCardSettleBatchModel alloc]initWithDic:dic];
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        pageSize = 20;
        pageIndex = 0;
        total_count = 0;
        totalAmount = @"0";
        settleModelArray = [NSMutableArray new];
        
        self.batchno = [NSString trimNSNullAsNoValue:[dic objectForKey:@"batchno"]];
        self.createtime = [NSString trimCardNSNullAsTime:[dic objectForKey:@"createtime"]];
        self.finishcount = [NSString trimnsNullasIntValue:[dic objectForKey:@"finishcount"]];
        self.finishtime = [NSString trimCardNSNullAsTime:[dic objectForKey:@"finishtime"]];
        self.batchID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"id"]];
        self.settlementterm = [NSString trimnsNullasIntValue:[dic objectForKey:@"settlementterm"]];
        self.totalCount = [NSString trimnsNullasIntValue:[dic objectForKey:@"totalcount"]];
        self.settlementtype = [NSString trimNSNullAsNoValue:[dic objectForKey:@"settlementtype"]];
        self.totalamount = [NSString trimCardNSNullAsFloat:[dic objectForKey:@"totalamount"]];
        
    }
    return self;
}

- (void)loadNewList:(HYHandler)complete
{
    pageIndex = 0;
    total_count = 0;
    settleModelArray = [NSMutableArray new];
    totalAmount = @"0";
    [self getVertifyList:complete];
}

- (void)loadMore:(HYHandler)complete
{
    if ((pageIndex+1)*pageSize>=[self.totalCount intValue])
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
    [param setObject:self.batchno forKey:@"bacthNo"];
    [param setObject:[NSString stringWithFormat:@"%ld",(long)pageIndex] forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    NSString *sign = [NSString stringWithFormat:@"%@%@",self.batchno,SHOP_CODE];
    sign = [sign md5];
    [param setObject:sign forKey:@"sign"];
    [HYHttpClient doCardPost:@"/settlement/batch/batchDetail.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
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
//                        self.total_count = [[NSString trimnsNullasIntValue:[result objectForKey:@"totalCount"]] integerValue];
//                        self.totalAmount = [NSString trimCardNSNullAsFloat:[result objectForKey:@"totalAmount"]];
                        if (pageIndex == 0)
                        {
                            [self.settleModelArray removeAllObjects];
                        }
                        id list = [result objectForKey:@"list"];
                        if ([list isKindOfClass:[NSArray class]])
                        {
                            for (NSDictionary *dic in list)
                            {
                                HYCardSettleBatchDetailModel *model = [HYCardSettleBatchDetailModel createWithDic:dic];
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
