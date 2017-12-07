//
//  HYUserViewModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYViewModel.h"


@interface HYUserViewModel : HYViewModel

/**
 *  获取商户商店列表
 */

+ (void)getShopList:(HYHandler)complete;

/**
 *  获取商户信息
 */
+ (void)getShopUserMessage:(HYHandler)complete;

/**
 *  交易密码监测
 */
+ (void)checkTransPass:(HYHandler)complete;

/**
 *  设置交易密码
 */
+ (void)setTransPass:(NSString *)pass handler:(HYHandler)complete;

/**
 *  云旺账号注册
 */
+ (void)registerYWUser:(HYHandler)complete;

/**
 *  获取验证啊
 */
+ (void)getNotifyCodePhone:(NSString *)phone handler:(HYHandler)complete;

/**
 *  绑定手机
 */
+ (void)notifyCodeBind:(NSString *)notidyCode handler:(HYHandler)complete;

@end
