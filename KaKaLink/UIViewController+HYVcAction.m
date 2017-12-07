//
//  UIViewController+HYVcAction.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "UIViewController+HYVcAction.h"
#import "HYLoginViewController.h"
#import "HYSearchViewController.h"
#import "NavigationViewController.h"
#import "DefineHeard.h"

@implementation UIViewController (HYVcAction)

- (void)loginAction
{
    HYLoginViewController *vc = [[HYLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated: YES];
}
- (void)pushAction:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)presentSearchView
{
    HYSearchViewController *loginVC = [[HYSearchViewController alloc]init];
    NavigationViewController *navigationVC = [[NavigationViewController alloc] initWithRootViewController:loginVC];
    navigationVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:navigationVC animated:YES completion:nil];
}
/**
 *  登录成功回调
 */
- (void)loginSuccessHandler:(void (^)(void))complete
{
    HYLoginViewController *loginVC = [[HYLoginViewController alloc]init];
    loginVC.loginHandler = ^(){
        if (complete)
        {
            complete();
        }
    };
    NavigationViewController *navigationVC = [[NavigationViewController alloc] initWithRootViewController:loginVC];
    navigationVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:navigationVC animated:YES completion:nil];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    HYLoginViewController *loginVC = [[HYLoginViewController alloc]init];
//    NavigationViewController *navigationVC = [[NavigationViewController alloc] initWithRootViewController:loginVC];
//    loginVC.loginHandler=^(){
//        if (complete)
//        {
//            complete();
//        }
//    };
//    navigationVC.modalPresentationStyle = UIModalPresentationCustom;
//    [window.rootViewController presentViewController:navigationVC animated:YES completion:nil];
}
/**
 *  tab切换
 */
- (void)tabbarChange:(NSInteger)index
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    UITabBarController *tabViewController = (UITabBarController *)window.rootViewController;
    [tabViewController setSelectedIndex:index];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/**
 *  创建发送email按钮
 */
- (void)createSendEmialBtn
{
    
}
@end
