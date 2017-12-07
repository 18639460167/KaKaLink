//
//  HYAccountService.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HYAccountService : NSObject

@property (nonatomic, assign) BOOL isRegisterNotifi; // 判断是否注册
@property (nonatomic, assign) BOOL isSearch; // 判断是否搜索
+ (instancetype)sharedService;
- (void)saveShopCredentialToken:(NSString*)credential;

- (BOOL)isLogin;

- (void)logout;

- (void)saveAccount:(NSString*)username andPassword:(NSString*)password;

- (void)saveDevice;

- (NSString*)getShopCredential;

- (NSString*)getUserName;

- (NSString*)getPassword;

- (NSString*)getDeviceString;

//- (void)changeLoginStatus;
- (BOOL)checkVersion;
- (void)saveYWUserID:(NSString*)userID andYWPassword:(NSString*)YWPassword;
- (NSString*)getYWUserID;
- (NSString*)getYWPassword;

/**
 *  是否显示引导页
 */

@end
