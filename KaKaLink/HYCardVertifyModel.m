//
//  HYCardVertifyModel.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardVertifyModel.h"

@implementation HYCardVertifyModel
@synthesize vertifyMessageArray;
@synthesize vertifyTitleArray;

+ (instancetype)createWithDic:(NSDictionary *)dic
{
    HYCardVertifyModel *model = [[HYCardVertifyModel alloc]initWithDic:dic];
    return model;
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.qrCode = [NSString trimNSNullAsNoValue:[dic objectForKey:@"qrCode"]];
        self.orderPrice = [NSString trimCardNSNullAsFloat:[dic objectForKey:@"orderPrice"]];
        self.otaPid = [NSString trimNSNullAsNoValue:[dic objectForKey:@"otaPid"]];
        self.otaPackageID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"otaPackageId"]];
        self.verticationDateTime = [NSString trimCardNSNullAsTime:[dic objectForKey:@"verificationDateTime"]];
        self.title = [NSString trimNSNullAsNoValue:[dic objectForKey:@"title"]];
        self.categoryID = [NSString getPackage:[NSString trimNSNullAsNoValue:[dic objectForKey:@"categoryId"]]];
        self.orderSource = [NSString getOrderSource:[NSString trimNSNullAsNoValue:[dic objectForKey:@"orderSource"]]];
        self.orderStatus =  [NSString vertifyStatus:[[NSString trimNSNullAsNoValue:[dic objectForKey:@"orderStatus"]] integerValue]];
        self.qty = [NSString trimNSNullAsNoValue:[dic objectForKey:@"qty"]];
        self.unitPrice = [NSString trimCardNSNullAsFloat:[dic objectForKey:@"unitPrice"]];
        
        self.hyOrderID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"hyOrderID"]];
        
        self.picURL = [NSString trimNSNullAsNoValue:[dic objectForKey:@"picURL"]];
        
        vertifyMessageArray = @[self.qrCode,self.orderSource,self.hyOrderID,self.title,self.categoryID,[self.unitPrice addMoneyUnit],self.qty,[self.orderPrice addMoneyUnit],self.verticationDateTime];
        vertifyTitleArray = @[LS(@"Card_Number"),LS(@"Platform"),LS(@"Order_ID"),LS(@"Good_Name"),LS(@"Good_Class"),LS(@"Price"),LS(@"Number"),LS(@"Order_Total"),LS(@"Vertify_Time")];
        
    }
    return self;
}

@end
