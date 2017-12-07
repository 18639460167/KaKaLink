//
//  HYSettleDetailViewModel.m
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSettleDetailViewModel.h"

@implementation HYSettleDetailViewModel

@synthesize totalCount;
@synthesize pageIndex;
@synthesize transArray;
@synthesize requestFail;

- (instancetype)init
{
    if (self = [super init])
    {
        self.totalCount = 0;
        self.pageIndex = 0;
        requestFail = NO;
        self.transArray = [NSMutableArray new];
        self.settlement_ID = @"";
        
    }
    return self;
}

- (void)loadNewSettleList:(HYHandler)complete
{
    self.totalCount = 0;
    self.pageIndex = 0;
    self.transArray = [NSMutableArray new];
    [self getSettleList:complete];
}
- (void)loadMoreSettleList:(HYHandler)complete
{
    if ((pageIndex + 1)*PAGESIZE >= self.totalCount)
    {
        complete(LS(@"Not_More"));
    }
    else
    {
        self.pageIndex ++;
        [self getSettleList:complete];
    }
}

#pragma mark - 数据处理

- (void)getSettleList:(HYHandler)complete
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:[NSString stringWithFormat:@"%d",(int)pageIndex] forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%d",PAGESIZE] forKey:@"size"];
    [param setObject:self.settlement_ID forKey:@"settlement_id"];
    
    [HYHttpClient doPost:@"/settlement/detail.json" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                requestFail = YES;
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
                            [transArray removeAllObjects];
                        }
                        if (![[result objectForKey:@"total_count"] isEqual:[NSNull null]])
                        {
                            NSString *withTo = [NSString trimnsNullasIntValue:[result objectForKey:@"total_count"]];
                            totalCount=[withTo integerValue];
                        }
                        else
                        {
                            totalCount=0;
                        }
                        id list = [result objectForKey:@"list"];
                        if ([list isKindOfClass:[NSArray class]])
                        {
                            for (NSDictionary *dic in list)
                            {
                                HYTransModel *model = [HYTransModel createWithDic:dic];
                                [transArray addObject:model];
                            }
                        }
                        requestFail = NO;
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


@end
