//
//  HYGoodDetailModel.m
//  KaKaLink
//
//  Created by 张帅 on 2017/11/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYGoodDetailModel.h"

@implementation HYGoodDetailModel

+ (instancetype)createDic:(NSDictionary *)dic
{
    HYGoodDetailModel *model = [[HYGoodDetailModel alloc]initWithDic:dic];
    return model;
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.dishName = [NSString trimNSNullAsNoValue:[dic objectForKey:@"dishName"]];
        self.dishCount = [NSString trimnsNullasIntValue:[dic objectForKey:@"dishCount"]];
        self.dishPicUrl = [NSString trimNSNullAsNoValue:[dic objectForKey:@"dishPicUrl"]];
        
        self.numberWidth = [HYStyle getWidthWithTitle:self.dishCount font:15];
    }
    return self;
}

@end
