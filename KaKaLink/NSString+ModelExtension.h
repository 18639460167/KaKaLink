//
//  NSString+ModelExtension.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/31.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ModelExtension)


/**
 获取卡券所有类型

 @return 卡券数组
 */
+ (NSArray *)cardCouponsTpe;
/**
 获取套餐类型

 @param message 套餐code
 @return 套餐名称
 */
+ (NSString *)getPackage:(NSString *)message;

+ (NSString *)getOrderSource:(NSString *)message;

+ (NSString *)vertifyStatus:(NSInteger)value;

@end
