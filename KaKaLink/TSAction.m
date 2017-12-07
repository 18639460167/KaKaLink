//
//  TSAction.m
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/9.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import "TSAction.h"
#import "NSString+Extensions.h"
#import "HYStyle.h"
#import "HYNotimessageDetailViewController.h"

#define TRIM(string) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

@implementation TSAction

- (instancetype)initWithDic:(NSDictionary *)dic content:(NSString *)content
{
    if (self = [super init])
    {
        self.actionContent = @"";
        self.messageID = @"";
        self.messageTime = @"";
        self.messageContent = content;
        self.messageTime = [NSString getCurrentTime];
        self.actionType = [self getActionTypeWithStringActionType:[NSString trimNSNullAsNoValue:[dic objectForKey:@"action-loc-key"]]];
        if ([[dic objectForKey:@"loc-args"] isKindOfClass:[NSArray class]])
        {
            self.messageArray = [dic objectForKey:@"loc-args"];
        }
        if (self.messageArray.count>0)
        {
            self.actionContent  =self.messageArray[0];
            if (self.messageArray.count>1)
            {
                self.messageID = self.messageArray[1];
            }
        }
    }
    return self;
}

- (TSActionType)getActionTypeWithStringActionType:(NSString *)stringActionType
{
    stringActionType = TRIM(stringActionType).lowercaseString;
    TSActionType actionType = TSActionType_Unknow;
    if ([stringActionType isEqualToString:@"goods"])
    {
        actionType = TSActionType_Goods;
    }
    else if ([stringActionType isEqualToString:@"2001"])
    {
        actionType = TSActionType_Apply;
    }
    else if ([stringActionType isEqualToString:@"url"])
    {
        actionType = TSActionType_Url;
    }
    return actionType;
}

- (TSAction *)doAction
{
    return [self doAction:nil popToRootViewController:YES];
}
- (TSAction*)doAction:(UIViewController *)parentViewCOntroller popToRootViewController:(BOOL)popToRootViewController
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UITabBarController *tabBar = (UITabBarController *)appdelegate.window.rootViewController;
    if (![tabBar isKindOfClass:[UITabBarController class]])
    {
        return self;
    }
    UINavigationController *navController = tabBar.selectedViewController;
    if (![navController isKindOfClass:[UINavigationController class]])
    {
        return self;
    }
    if (self.actionType == TSActionType_Apply) // 体现详情
    {
        if ([self.actionContent isEqualToString:@""])
        {
            return nil;
        }
        HYNotimessageDetailViewController *wpVC = (HYNotimessageDetailViewController *)[self findController:navController class:[HYNotimessageDetailViewController class]];
        if (wpVC != nil && popToRootViewController)
        {
            [navController popToRootViewControllerAnimated:YES];
        }
        wpVC = [[HYNotimessageDetailViewController alloc]init];
        wpVC.messageID = self.messageID;
        wpVC.messageTime = self.messageTime;
        wpVC.content = self.messageContent;
        wpVC.messagetype = LS(@"Withdrawal");
        [navController pushViewController:wpVC animated:YES];
    }
    return nil;
}

- (UIViewController *)findController:(UIViewController *)parentViewController class:(Class)class
{
    return [self findController:parentViewController class:class needNew:NO];
}
- (UIViewController *)findController:(UIViewController *)parentViewController class:(Class)class needNew:(BOOL)needNew
{
    __block UIViewController *retController = nil;
    if (parentViewController)
    {
        [parentViewController.childViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             if ([obj isKindOfClass:class])
             {
                 retController = obj;
                 *stop = YES;
             }
             else
             {
                 retController = [self findController:obj class:class needNew:needNew];
                 if (retController)
                 {
                     *stop = YES;
                 }
             }
         }];
    }
    if (needNew && !retController)
    {
        retController = [class new];
    }
    return retController;
}

@end
