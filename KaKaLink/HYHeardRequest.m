//
//  HYHeardRequest.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "HYHeardRequest.h"
#import "HYAccountService.h"

@implementation HYHeardRequest

+ (HYHeardRequest *)shareRequest:(NSURL *)url
{
    HYHeardRequest *shareModel;
    shareModel = [self requestWithURL:url];
    if ([[HYAccountService sharedService] getShopCredential])
    {
//        [shareModel addValue:[[HYAccountService sharedService]getUserName] forHTTPHeaderField:@"shopid"];
        [shareModel addValue:[[HYAccountService sharedService]getShopCredential] forHTTPHeaderField:@"accessToken"];
    }
    return shareModel;
}

@end
