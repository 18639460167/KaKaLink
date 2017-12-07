//
//  HYPushItem.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/9.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYPushItem.h"

@implementation HYPushItem

- (id)initWithDic:(NSDictionary *)pushDic
{
    if (self = [super init])
    {
        self.title = @"KAKALink";
        self.action = nil;
        NSDictionary *bigDic =[pushDic objectForKey:@"aps"];
        if (pushDic == nil || (id)pushDic == [NSNull null] || bigDic == nil || (id)bigDic == [NSNull null])
        {
            return self;
        }
        self.badge = [[NSString trimnsNullasIntValue:[bigDic objectForKey:@"badge"]] integerValue];
        NSDictionary *dic = [bigDic objectForKey:@"alert"];
        self.content  =[NSString trimNSNullAsNoValue:[dic objectForKey:@"body"]];
        self.action = [[TSAction alloc]initWithDic:dic content:self.content];
    }
    return self;
}
- (void)setBadgeIfNeedUpdate
{
    [PushNumberModel shareModel].pushNumber = self.badge;
    [PushNumberModel setPadgeBadge];
}
+ (void)registerNoti:(NSString *)deviceToken backHandler:(void (^)(NSString *))complete
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:deviceToken forKey:@"device_token"];
    [HYHttpClient doPost:@"/push/register.do"
                   param:param timeInterVal:10.0 callback:^(HYHttpsResponse *response)
     {
         BACK(^{
             MAIN((^{
                 if (response.mStatus==HY_HTTP_FAILED) {
                     complete(LS(@"Disconnect_Internet"));
                     
                 }
                 else if (response.mStatus==HY_HTTP_UNLOGIN)
                 {
                     complete(SHOP_NO_LOGIN);
                 }
                 else if (response.mStatus==HY_HTTP_UNRIGHTMESSAGE)
                 {
                     id jsObject=response.mResult;
                     complete([NSString trimNSNullAsNoValue:[jsObject objectForKey:@"errmsg"]]);
                 }
                 else
                 {
                     complete(REQUEST_SUCCESS);
                 }
             }));
         });
     }];
}
@end
