//
//  HYCardSettleModel.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardSettleModel.h"

@implementation HYCardSettleModel

+ (instancetype)createWithDic:(NSDictionary *)dic
{
    HYCardSettleModel *model = [[HYCardSettleModel alloc]initWithDic:dic];
    return model;
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.cashBank = [NSString trimNSNullAsNoValue:[dic objectForKey:@"cashBank"]];
        self.categoryID = [NSString getPackage:[NSString trimNSNullAsNoValue:[dic objectForKey:@"categoryId"]]];;
        self.depositAccount = [NSString trimnsNullasIntValue:[dic objectForKey:@"depositAccount"]];
        self.hyOrderID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"hyOrderID"]];
        self.orderPrice = [NSString trimCardNSNullAsFloat:[dic objectForKey:@"orderPrice"]];
        self.orderSource = [NSString getOrderSource:[NSString trimNSNullAsNoValue:[dic objectForKey:@"orderSource"]]];
         self.orderStatus =  [NSString vertifyStatus:[[NSString trimNSNullAsNoValue:[dic objectForKey:@"orderStatus"]] integerValue]];
        self.otaPid = [NSString trimNSNullAsNoValue:[dic objectForKey:@"otaPid"]];
        self.otaPackageID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"otaPackageId"]];
        self.qrCode = [NSString trimNSNullAsNoValue:[dic objectForKey:@"qrCode"]];
        self.settleCycle = [NSString trimNSNullAsNoValue:[dic objectForKey:@"settleCycle"]];
        self.settleDatetime = [NSString trimCardNSNullAsTime:[dic objectForKey:@"settleDatetime"]];
        self.settlePrice = [NSString trimCardNSNullAsFloat:[dic objectForKey:@"settlePrice"]];
        self.verticationDateTime = [NSString trimCardNSNullAsTime:[dic objectForKey:@"verificationDateTime"]];
        self.title = [NSString trimNSNullAsNoValue:[dic objectForKey:@"title"]];
        self.qty = [NSString trimNSNullAsNoValue:[dic objectForKey:@"qty"]];
        self.unitPrice = [NSString trimCardNSNullAsFloat:[dic objectForKey:@"unitPrice"]];
        
        //  ,@"打款银行:",@"打款账户:"  ,self.cashBank,self.depositAccount
        self.titleArray = @[LS(@"Card_Number"),LS(@"Platform"),LS(@"Order_ID"),LS(@"Good_Name"),LS(@"Good_Class"),LS(@"Price"),LS(@"Number"),LS(@"Order_Total"),LS(@"Vertify_Total"),LS(@"Vertify_Time"),LS(@"Settlement_Circle"),LS(@"Settlement_Time")];
        self.messageArray = @[self.qrCode,self.orderSource,self.hyOrderID,self.title,self.categoryID,[self.unitPrice addMoneyUnit],self.qty,[self.orderPrice addMoneyUnit],[self.settlePrice addMoneyUnit],self.verticationDateTime,self.settleCycle,self.settleDatetime];
    }
    return self;
}


@end
