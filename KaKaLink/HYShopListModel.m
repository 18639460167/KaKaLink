//
//  HYShopListModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYShopListModel.h"

@implementation HYShopListModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.mid = [NSString trimNSNullAsNoValue:[dic objectForKey:@"mid"]];
        self.title = [NSString trimNSNullAsNoValue:[dic objectForKey:@"title"]];
        self.qrCode  = [NSString trimNSNullAsNoValue:[dic objectForKey:@"qrcode"]];
        self.summary = [NSString trimNSNullAsNoValue:[dic objectForKey:@"summary"]];
        self.logoUrl = [NSString trimNSNullAsNoValue:[dic objectForKey:@"logo_url"]];
        self.notice = [NSString trimNSNullAsNoValue:[dic objectForKey:@"notice"]];
    }
    return self;
}
- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.mid = [coder decodeObjectForKey:@"mid"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.qrCode = [coder decodeObjectForKey:@"qrCode"];
        self.summary = [coder decodeObjectForKey:@"summary"];
        self.logoUrl = [coder decodeObjectForKey:@"logoUrl"];
        self.notice = [coder decodeObjectForKey:@"notice"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder

{
    [coder encodeObject:self.mid forKey:@"mid"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.qrCode forKey:@"qrCode"];
    [coder encodeObject:self.summary forKey:@"summary"];
    [coder encodeObject:self.logoUrl forKey:@"logoUrl"];
    [coder encodeObject:self.notice forKey:@"notice"];
}
@end
