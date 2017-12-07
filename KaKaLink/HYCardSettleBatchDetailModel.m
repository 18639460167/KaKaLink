//
//  HYCardSettleBatchDetailModel.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/31.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardSettleBatchDetailModel.h"

@implementation HYCardSettleBatchDetailModel

+ (instancetype)createWithDic:(NSDictionary *)dic
{
    HYCardSettleBatchDetailModel *model = [[HYCardSettleBatchDetailModel alloc]initWithDic:dic];
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.bacthno = [NSString trimNSNullAsNoValue:[dic objectForKey:@"bacthno"]];
        self.billid = [NSString trimNSNullAsNoValue:[dic objectForKey:@"billid"]];
        self.categoryID = [NSString getPackage:[NSString trimNSNullAsNoValue:[dic objectForKey:@"categoryid"]]];
        self.createTime = [NSString trimCardNSNullAsTime:[dic objectForKey:@"createtime"]];
        self.hyorderID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"hyorderid"]];
        self.orderID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"orderid"]];
        self.otapID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"otapid"]];
        self.price = [NSString trimCardNSNullAsFloat:[dic objectForKey:@"price"]];
        self.settlementDate = [NSString trimCardNSNullAsTime:[dic objectForKey:@"sattlementdate"]];
        self.settlementPrice = [NSString trimCardNSNullAsFloat:[dic objectForKey:@"sattlementprice"]];
        self.settlementState = [NSString trimNSNullAsNoValue:[dic objectForKey:@"sattlementstate"]];
        self.settlementCurrency = [NSString trimNSNullAsNoValue:[dic objectForKey:@"settlementcurrency"]];
        self.settlementType = [NSString trimNSNullAsNoValue:[dic objectForKey:@"settlementtype"]];
        self.title = [NSString trimNSNullAsNoValue:[dic objectForKey:@"title"]];
        self.picURL = [NSString trimNSNullAsNoValue:[dic objectForKey:@"picURL"]];
        
        self.isRequestFail = YES;
    }
    return self;
}

#pragma mark - 清算详情

- (void)cardSettleDetail:(void (^)(id, NSString *))complete
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:self.hyorderID forKey:@"hyOrderID"];
    NSString *sign = [NSString stringWithFormat:@"%@%@",self.hyorderID,SHOP_CODE];
    sign = [sign md5];
    [param setObject:sign forKey:@"sign"];
    
    [HYHttpClient doCardPost:@"/settlement/batch/SettlementOrderDetail.do" param:param timeInterVal:REQUEST_TIME callback:^(HYHttpsResponse *response) {
        BACK(^{
            MAIN((^{
                self.isRequestFail = YES;
                NSLog(@"清算详情记录==%@",response.mResult);
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
                        HYCardSettleModel *model = [HYCardSettleModel createWithDic:result];
                        self.isRequestFail = NO;
                        complete(model,REQUEST_SUCCESS);
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
