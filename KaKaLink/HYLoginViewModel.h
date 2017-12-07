//
//  HYLoginViewModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/5.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYViewModel.h"

@interface HYLoginViewModel : HYViewModel
/**
 *  用户登录
 *
 *  @param userName 用户名字
 *  @param password 用户密码
 *  @param complete 返回结果
 */
+ (void)loginWithUserName:(NSString *)userName withPassword:(NSString *)password withComplete:(HYHandler)complete;
/**
 *  退出登录
 */
+ (void)userLogoutWithCompleteBlock:(HYHandler)complete;
@end
