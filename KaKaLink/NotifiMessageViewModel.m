//
//  NotifiMessageViewModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/5.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "NotifiMessageViewModel.h"

@implementation NotifiMessageViewModel
@synthesize pageIndex;
@synthesize messageTotal;
@synthesize pageSize;
@synthesize messageArray;

- (instancetype)init
{
    if (self = [super init])
    {
        pageSize = 15;
        messageTotal = 0;
        messageArray = [[NSMutableArray alloc]init];
    }
    return self;
}
/**
 *  加载更多
 *
 */
- (void)loadMore:(backHandler)complete
{
    if ((pageIndex+1)*pageSize>=messageTotal)
    {
        complete(LS(@"Not_More"));
    }
    else
    {
        pageIndex ++;
        [self getMessageList:complete];
    }
}
/**
 *  刷新
 *
 */
- (void)loadNewList:(backHandler)complete
{
    pageIndex = 0;
    [self getMessageList:complete];
}

- (void)getMessageList:(backHandler)complete
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:[NSString stringWithFormat:@"%d",(int)pageIndex] forKey:@"page"];
    [param setObject:[NSString stringWithFormat:@"%d",(int)pageSize] forKey:@"size"];
    [HYHttpClient doPost:@"/push/list.json" param:param timeInterVal:10.0 callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
        self.isRequestFaild = YES;
        if (response.mStatus==HY_HTTP_FAILED)
        {
            complete(LS(@"Disconnect_Internet"));
        }
        else if (response.mStatus==HY_HTTP_UNLOGIN){
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
        else
        {
            id jsObject = response.mResult;
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
                    [messageArray removeAllObjects];
                }
                if (![[result objectForKey:@"total_count"] isEqual:[NSNull null]])
                {
                    NSString *message = [NSString trimnsNullasIntValue:[result objectForKey:@"total_count"]];
                    messageTotal=[message integerValue];
                }
                else
                {
                    messageTotal=0;
                }
                id list = [result objectForKey:@"list"];
                if ([list isKindOfClass:[NSArray class]])
                {
                    for (NSDictionary *dic in list)
                    {
                        NotifiMessageModel *model = [[NotifiMessageModel alloc]initWithDic:dic];
                        [messageArray addObject:model];
                    }
                }
            }
            self.isRequestFaild = NO;
            complete(REQUEST_SUCCESS);
        }
            }));
        });
    }];
}

#pragma mark -标记消息已读
+ (void)handleMessage:(NSString *)messageID  handler:(backHandler)complete;
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:messageID forKey:@"msg_guid"];
    [HYHttpClient doPost:@"/push/setread.do" param:param timeInterVal:10.0 callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
        if (response.mStatus==HY_HTTP_FAILED)
        {
            complete(LS(@"Disconnect_Internet"));
        }
        else if (response.mStatus==HY_HTTP_UNLOGIN)
        {
            complete(SHOP_NO_LOGIN);
        }
        else if (response.mStatus==HY_HTTP_UNRIGHTMESSAGE)
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
        else
        {
            complete(REQUEST_SUCCESS);
        }
            }));
        });
    }];
}

+ (void)pushDelete:(NSString *)messageID handler:(backHandler)complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:messageID forKey:@"msg_guid"];
    [HYHttpClient doPost:@"/push/delete.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                if (response.mStatus==HY_HTTP_OK)
                {
                    complete(REQUEST_SUCCESS);
                }
                else if (response.mStatus==HY_HTTP_UNLOGIN)
                {
                    complete(SHOP_NO_LOGIN);
                }
                else if (response.mStatus==HY_HTTP_UNRIGHTMESSAGE)
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
                else
                {
                    complete(LS(@"Disconnect_Internet"));
                }
            }));
        });
    }];
}

@end
