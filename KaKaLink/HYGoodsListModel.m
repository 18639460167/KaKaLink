//
//  HYGoodsListModel.m
//  KaKaLink
//
//  Created by 张帅 on 2017/11/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYGoodsListModel.h"

@implementation HYGoodsListModel

+ (instancetype)createWithDic:(NSDictionary *)dic
{
    HYGoodsListModel *model = [[HYGoodsListModel alloc]initWithDic:dic];
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.fooDishDetailDTOs = [NSMutableArray array];
        self.groupName = [NSString trimNSNullAsNoValue:[dic objectForKey:@"groupName"]];
        self.otaPackageID = [NSString trimNSNullAsNoValue:[dic objectForKey:@"otaPackageId"]];
        NSArray *modelArray = [NSString dataArrayWithStr:[dic objectForKey:@"foodDishDetailDTOs"]];
        int number = 0;
        for (NSDictionary *dic in modelArray)
        {
            HYGoodDetailModel *model = [HYGoodDetailModel createDic:dic];
            number = number + [model.dishCount intValue];
            [self.fooDishDetailDTOs addObject:model];
        }
        self.goodsNumber = [NSString stringWithFormat:@"%d",number];
    }
    return self;
}

@end
