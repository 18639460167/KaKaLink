//
//  NotifiMessageModel.m
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/13.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import "NotifiMessageModel.h"
#import "NSString+Extensions.h"

@implementation NotifiMessageModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.content = [NSString trimNSNullAsNoValue:[dic objectForKey:@"f_body"]];
        self.messageID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"f_guid"]];
        self.applyID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"f_localizedArguments"]];
        if ([[dic objectForKey:@"f_is_read"] isEqual:[NSNull null]]||[dic objectForKey:@"f_is_read"]==nil)
        {
            self.isRead=NO;
        }
        else
        {
            self.isRead = [[dic objectForKey:@"f_is_read"] boolValue];
        }
        if ([[dic objectForKey:@"f_action_key"] isEqual:[NSNull null]] || [dic objectForKey:@"f_action_key"]==nil)
        {
            self.messageType = 0;
        }
        else
        {
            self.messageType = [[dic objectForKey:@"f_action_key"] integerValue];
        }
        self.timeMessage = [NSString trimNSNullASTimeValue:[dic objectForKey:@"f_timestamp"]];
    }
    return self;
}

@end
