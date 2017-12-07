//
//  NSString+ModelExtension.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/31.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "NSString+ModelExtension.h"

@implementation NSString (ModelExtension)

#pragma mark --卡券类型--
+ (NSArray *)cardCouponsTpe
{
    NSArray*dicArray = @[@{
                             @"title" : LS(@"All"),
                             @"id"    : @"0"
                             },
                         @{
                             @"title" : LS(@"Gourment_Meal"),
                             @"id"    : @"1014"
                             },
                         @{
                             @"title" : LS(@"Delicacy_Vouchers"),
                             @"id"    : @"1015"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Three"),
                             @"id"    : @"1010"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Four"),
                             @"id"    : @"1008"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Five"),
                             @"id"    : @"1007"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Six"),
                             @"id"    : @"1009"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Seven"),
                             @"id"    : @"1013"
                             },

                         @{
                             @"title" : LS(@"Card_Category_Eight"),
                             @"id"    : @"1016"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Nine"),
                             @"id"    : @"1002"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Ten"),
                             @"id"    : @"1003"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Eleven"),
                             @"id"    : @"1004"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Twelve"),
                             @"id"    : @"1005"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Thirteen"),
                             @"id"    : @"1006"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Fourteen"),
                             @"id"    : @"1011"
                             },
                         @{
                             @"title" : LS(@"Card_Category_Fifteen"),
                             @"id"    : @"1012"
                             }];
    return dicArray;
}

+ (NSString *)getPackage:(NSString *)message
{
    NSString *cardTitle = @"";
    NSArray *dataArray = [self cardCouponsTpe];
    for (NSDictionary *dic in dataArray)
    {
        NSString *ID = [dic objectForKey:@"id"];
        if ([ID isEqualToString:message])
        {
            cardTitle = [dic objectForKey:@"title"];
        }
    }
    return cardTitle;
}

#pragma mark --订单状态--
+ (NSString *)getOrderSource:(NSString *)message
{
    NSString *orderSource = @"";
    if ([message isEqualToString:@"1"])
    {
        orderSource = LS(@"Public_Comment");
    }
    else if ([message isEqualToString:@"2"])
    {
        orderSource = LS(@"Alipay");
    }
    else if ([message isEqualToString:@"3"])
    {
        orderSource = LS(@"TaoBao");
    }
    else
    {
        orderSource = @"";
    }
    return orderSource;
}

+ (NSString *)vertifyStatus:(NSInteger)value
{
    NSString * orderStatus = @"";
    if (value == 501)
    {
        orderStatus = LS(@"Wirte_Off");
    }
    else
    {
        orderStatus = LS(@"Not_Written_Off");
    }
//    switch (value)
//    {
//        case 102:
//        {
//            orderStatus = @"占位成功";
//        }
//            break;
//        case 103:
//        {
//            orderStatus = @"占位失败";
//        }
//            break;
//        case 202:
//        {
//            orderStatus = @"清位成功";
//        }
//            break;
//        case 203:
//        {
//            orderStatus = @"清位成功";
//        }
//            break;
//        case 301:
//        {
//            orderStatus = @"确认中";
//        }
//            break;
//        case 302:
//        {
//            orderStatus = @"确认成功";
//        }
//            break;
//        case 303:
//        {
//            orderStatus = @"确认失败";
//        }
//            break;
//        case 401:
//        {
//            orderStatus = @"取消中";
//        }
//            break;
//        case 404:
//        {
//            orderStatus = @"部分取消成功";
//        }
//            break;
//        case 405:
//        {
//            orderStatus = @"部分取消失败";
//        }
//            break;
//        case 501:
//        {
//            orderStatus = @"已核销";
//        }
//            break;
//        case 601:
//        {
//            orderStatus = LS(@"Settle_Finish");
//        }
//            break;
//            
//        default:
//        {
//            orderStatus = @"";
//        }
//            break;
//    }
    return orderStatus;
}


@end
