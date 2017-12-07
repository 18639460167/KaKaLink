//
//  AppDelegate.m
//  KaKaLink
//
//  Created by Black on 17/6/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) TSAction *action;
@property (nonatomic, strong) UIAlertView *alertView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

//        [YWManager initYW];
    
    [NSThread sleepForTimeInterval:2];
    
    UIApplication *myApplication = [UIApplication sharedApplication];
    [myApplication setStatusBarHidden:NO];
    [myApplication setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo)
    {
        HYPushItem *pushItem = [[HYPushItem alloc]initWithDic:userInfo];
        self.action = [pushItem.action doAction];
        [pushItem setBadgeIfNeedUpdate];
    }
    [self registerPush];
    
    [self showMainVC];
    [self.window makeKeyAndVisible];
    [HYWelvomeView showAction:nil];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    return YES;
}


- (void)showMainVC
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    if ([[HYAccountService sharedService] getShopCredential])
    {
        HYTabBarViewController *nvc = [[HYTabBarViewController alloc]init];
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = nvc;
    }
    else
    {
        HYLoginViewController *loginVC = [[HYLoginViewController alloc]init];
        loginVC.isHome = YES;
        NavigationViewController *nav = [[NavigationViewController alloc]initWithRootViewController:loginVC];
        nav.modalPresentationStyle = UIModalPresentationCustom;
        self.window.rootViewController = nav;
    }
}
#pragma mark - 错误搜集
void uncaughtExceptionHandler(NSException *exception)
{
    NSArray  *callStack = [exception callStackSymbols];
    NSString *reason    = [exception reason];
    NSString *name      = [exception name];
    NSString *content   = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    NSLog(@"CRASH: %@", content);
}
#pragma mark- 注册通知
- (void)registerPush
{
    [PushNumberModel shareModel].pushNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    // 获取版本信息
    double verson = [[UIDevice currentDevice].systemVersion doubleValue];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (verson>=8.0f)
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
    }
    else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
#pragma clang diagnostic pop
}
#pragma mark - 收到推送通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    HYPushItem *pushItem = [[HYPushItem alloc]initWithDic:userInfo];
    [pushItem setBadgeIfNeedUpdate];
    if (self.alertView)
    {
        [self.alertView dismissWithClickedButtonIndex:self.alertView.cancelButtonIndex animated:YES];
    }
    if (application.applicationState == UIApplicationStateInactive)
    {
        // 程序在后台点击通知栏
        self.action = [pushItem.action doAction];
    }
    else if (application.applicationState == UIApplicationStateActive)
    {
        // 程序在前台
        self.action = pushItem.action;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:pushItem.title
                                                       message:pushItem.content delegate:self
                                             cancelButtonTitle:LS(@"Cancel") otherButtonTitles:LS(@"See details"), nil];
        [alert show];
        self.alertView = alert;
    }
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
#ifdef DEBUG
    NSLog(@"Registfail:%@",error);
#else
#endif
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token=@"";
    token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    SET_USER_DEFAULT(token, SHOP_DEVICE_TOKEN);
    SYN_USER_DEFAULT;
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    BOOL remoteNotificationsEnabled = YES;
    BOOL badgesEnabled = NO;
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        // iOS8+
        remoteNotificationsEnabled = [UIApplication sharedApplication].isRegisteredForRemoteNotifications;
        UIUserNotificationSettings *userNotificationSettings = [UIApplication sharedApplication].currentUserNotificationSettings;
        badgesEnabled = userNotificationSettings.types & UIUserNotificationTypeBadge;
        
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // iOS7 and below
        UIRemoteNotificationType enabledRemoteNotificationTypes = [UIApplication sharedApplication].enabledRemoteNotificationTypes;
        badgesEnabled = enabledRemoteNotificationTypes & UIRemoteNotificationTypeBadge;
#pragma clang diagnostic pop
    }
}

#pragma mark -Alert Handler
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        self.action = [self.action doAction];
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.alertView = nil;
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [PushNumberModel shareModel].pushNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
