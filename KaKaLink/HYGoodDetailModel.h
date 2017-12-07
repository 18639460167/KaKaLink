//
//  HYGoodDetailModel.h
//  KaKaLink
//
//  Created by 张帅 on 2017/11/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYGoodDetailModel : NSObject

@property (nonatomic, copy) NSString * dishCount;
@property (nonatomic, copy) NSString * dishName;
@property (nonatomic, copy) NSString * dishPicUrl;
@property (nonatomic, strong) NSArray *goodsArray; //商品详情数组

@property (nonatomic, assign) CGFloat numberWidth; // 数量长度

+ (instancetype)createDic:(NSDictionary *)dic;

@end
