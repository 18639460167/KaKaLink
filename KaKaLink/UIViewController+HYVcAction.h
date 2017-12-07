//
//  UIViewController+HYVcAction.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HYVcAction)

- (void)loginAction;

- (void)loginSuccessHandler:(void(^)(void))complete;

- (void)pushAction:(UIViewController *)vc;
- (void)popAction;


/**
 *  跳转到searchView
 */
- (void)presentSearchView;

/**
 *  tabbar切换
 */
- (void)tabbarChange:(NSInteger)index;


@end
