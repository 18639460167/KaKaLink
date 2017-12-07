//
//  HYProgressHUD.h
//  TourGuide
//
//  Created by 步刊 徐 on 15/9/14.
//  Copyright © 2015年 步刊 徐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HYProgressHUD : NSObject


@property(nonatomic,retain) UIView*mHudView;
@property(nonatomic,retain) UIActivityIndicatorView *indicatior;

+(void)show;
+(void)dismiss;

+ (void)showLoading:(NSString *)message rootView:(UIView *)rootView;
+ (void)hideLoading:(UIView *)cuttentView;
+ (void)handlerError:(NSString *)errorMessage currentVC:(UIViewController *)vc loginHandler:(noParameterBlock)handler;

+ (void)handlerDataError:(NSString *)errorMessage currentVC:(UIViewController *)vc handler:(noParameterBlock)handler;

+ (void)showLoading:(NSString *)message time:(NSInteger)delay currentView:(UIView *)currentView;

+ (void)showLoading:(NSString *)message currentView:(UIView *)currentView handler:(noParameterBlock)handler;

@end
