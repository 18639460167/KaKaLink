//
//  HYUserHelpModel.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/2.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYUserHelpModel.h"

@implementation HYUserHelpModel

- (instancetype)initWithQuestion:(NSString *)question answer:(NSString *)answer
{
    if (self = [super init])
    {
        self.question = question;
        self.answer  = answer;
    }
    return self;
}

@end
