//
//  HYAccountService.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "HYAccountService.h"
#import "sys/utsname.h"
//#import "YWManager.h"
#import "HYShopMessage.h"
#import "PushNumberModel.h"

@implementation HYAccountService

- (void)saveShopCredentialToken:(NSString *)credential
{
    SET_USER_DEFAULT(credential, @"ShopCredential");
    SYN_USER_DEFAULT;
}
- (NSString *)getShopCredential
{
    return USER_DEFAULT(@"ShopCredential");
}
+ (instancetype)sharedService
{
    static dispatch_once_t once;
    static HYAccountService *sharedService;
    dispatch_once(&once, ^{
        sharedService = [[self alloc]init];
        sharedService.isRegisterNotifi = NO;
    });
    return sharedService;
}
/**
 *  是否第一次登录
 *
 */
- (BOOL)checkVersion
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *verson = [[[NSBundle mainBundle]infoDictionary]objectForKey:key];
    NSString *saveVersion = USER_DEFAULT(key);
    if ([verson isEqualToString:saveVersion])
    {
        return NO;
    }
    else
    {
        SET_USER_DEFAULT(verson, key);
        SYN_USER_DEFAULT;
        return YES;
    }
}
#pragma  mark - 当前设备信息
- (void)saveDevice
{
    NSString *device = [self deviceString];
    SET_USER_DEFAULT(device, @"currentDevice");
    SYN_USER_DEFAULT;
}
- (NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone6 Plus";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone6S Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    return deviceString;
}
- (NSString*)getDeviceString
{
    NSString*currentDevice=USER_DEFAULT(@"currentDevice");
    return currentDevice;
}
#pragma mark - 用户信息
- (BOOL)isLogin
{
    if ([self getShopCredential]!=nil && ![[self getShopCredential]isEqualToString:@""])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)saveAccount:(NSString *)username andPassword:(NSString *)password
{
    SET_USER_DEFAULT(username, @"username");
    SET_USER_DEFAULT(password, @"password");
    SYN_USER_DEFAULT;
}
- (void)saveYWUserID:(NSString *)userID andYWPassword:(NSString *)YWPassword
{
    SET_USER_DEFAULT(userID, @"YWUserID");
    SET_USER_DEFAULT(YWPassword, @"YWPassword");
    SYN_USER_DEFAULT;
}
-(NSString*)getYWUserID
{
    return USER_DEFAULT(@"YWUserID");
}
-(NSString*)getYWPassword
{
    return USER_DEFAULT(@"YWPassword");
}
-(NSString*)getUserName
{
    return USER_DEFAULT(@"username");
}

-(NSString*)getPassword
{
    return USER_DEFAULT(@"password");
}

#pragma mark - 退出登录
- (void)logout
{
    [[HYShopMessage sharedModel] messageDic:[NSDictionary new]];
    [HYAccountService sharedService].isRegisterNotifi = NO;
    [PushNumberModel clearBageNumber];
    if ([self getShopCredential]!=nil)
    {
//        [[YWManager shareManager]exampleLogout];
    }
    NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults]dictionaryRepresentation];
    for (NSString *key in [defaultsDictionary allKeys])
    {
       
        if ([key isEqualToString:@"CFBundleShortVersionString"] || [key isEqualToString:SHOP_GETORDER_EMAIL] || [key isEqualToString:SHOP_IS_FIRSTLOGIN] || [key isEqualToString:SHOP_CAMERA_OPEN])
        {
           
        }
        else
        {
            REMOVE_USER_DEFAULT(key);
            SYN_USER_DEFAULT;
        }
    }
}

@end
