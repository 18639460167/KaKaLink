//
//  HYGoodsListModel.h
//  KaKaLink
//
//  Created by 张帅 on 2017/11/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYGoodsListModel : NSObject

@property (nonatomic, strong) NSMutableArray *fooDishDetailDTOs;
@property (nonatomic, copy)   NSString *groupName;
@property (nonatomic, copy)   NSString *otaPackageID; // 套餐ID
@property (nonatomic, copy)   NSString *goodsNumber;

+ (instancetype)createWithDic:(NSDictionary *)dic;


@end
