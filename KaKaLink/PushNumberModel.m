//
//  PushNumberModel.m
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/15.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import "PushNumberModel.h"
#import "MessageButton.h"
#import "HYAccountService.h"

@implementation PushNumberModel

+ (instancetype)shareModel
{
    static dispatch_once_t predicate;
    static PushNumberModel *shareModel;
    dispatch_once(&predicate,^{
        shareModel = [[PushNumberModel alloc]init];
        shareModel.pushNumber = 0;
    });
    return shareModel;
}

+ (void)BageNumberDeauce
{
    if ([PushNumberModel shareModel].pushNumber>0)
    {
        [PushNumberModel shareModel].pushNumber--;
    }
    else
    {
        [PushNumberModel shareModel].pushNumber=0;
    }
    [[PushNumberModel shareModel] setAppleBadge];
}

+ (void)clearBageNumber
{
    [PushNumberModel shareModel].pushNumber =0;
    [[PushNumberModel shareModel] setAppleBadge];
}
+ (void)setPadgeBadge
{
    
    [[PushNumberModel shareModel] setAppleBadge];
}
- (void)setAppleBadge
{
    [MessageButton shareMessageButton].messageNumber = [PushNumberModel shareModel].pushNumber;
    [UIApplication sharedApplication].applicationIconBadgeNumber = [PushNumberModel shareModel].pushNumber;
}

@end
