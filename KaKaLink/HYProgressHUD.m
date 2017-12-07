//
//  HYProgressHUD.m
//  TourGuide
//
//  Created by 步刊 徐 on 15/9/14.
//  Copyright © 2015年 步刊 徐. All rights reserved.
//

#import "HYProgressHUD.h"
#import "DefineHeard.h"
@implementation HYProgressHUD
@synthesize mHudView;
@synthesize indicatior;

+ (HYProgressHUD*)sharedView {
    static dispatch_once_t once;
    static HYProgressHUD *sharedView;
    dispatch_once(&once, ^ { sharedView = [[self alloc] init]; });
    return sharedView;
}
-(HYProgressHUD*)init{
    if (self=[super init]) {
        [self initIndicatorView];
        
    }

    return self;
}
-(void)initIndicatorView{

    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    mHudView.userInteractionEnabled=NO;
    mHudView=[UIView new];
    mHudView.backgroundColor=[UIColor clearColor];
    mHudView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [window addSubview:mHudView];
    mHudView.hidden=YES;
    indicatior=[[UIActivityIndicatorView alloc]init];
    indicatior.hidden=YES;
    indicatior.center=mHudView.center;
    indicatior.bounds=CGRectMake(0, 0, 30, 30);
//    indicatior.color=RGB(28, 166, 155);
    indicatior.color=RGB(51, 51, 51);
    [mHudView addSubview:indicatior];
    

}
+(void)show{
    [[self sharedView]showProgress];
}

+(void)dismiss{
    [[self sharedView]hideProgress];
}

-(void)showProgress{
   
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    mHudView.hidden=NO;
    indicatior.hidden=NO;
    [indicatior startAnimating];
    [window bringSubviewToFront:mHudView];
    

}

-(void)hideProgress{
    mHudView.hidden=YES;
    indicatior.hidden=YES;
    [indicatior stopAnimating];
    
}

+ (void)showLoading:(NSString *)message rootView:(UIView *)rootView
{
    if (rootView)
    {
        [MBProgressHUD hideAllHUDsForView:rootView animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:rootView animated:YES];
        hud.labelText = message;
    }
}

+ (void)hideLoading:(UIView *)cuttentView
{
    if (cuttentView)
    {
        [MBProgressHUD hideAllHUDsForView:cuttentView animated:YES];
    }
}
+ (void)handlerDataError:(NSString *)errorMessage currentVC:(UIViewController *)vc handler:(noParameterBlock)handler
{
    [self hideLoading:vc.view];
    if ([errorMessage isEqualToString:SHOP_NO_LOGIN])
    {
        if (vc)
        {
             [[HYAccountService sharedService] logout];
             [vc loginSuccessHandler:handler];
        }
        else
        {
            UIView *view = [self getCurrentView];
            [MBProgressHUD hideAllHUDsForView:view animated:YES];
        }
    }
    else
    {
        if ((![errorMessage isEqualToString:REQUEST_SUCCESS]) && (![errorMessage isEqualToString:@""])){
            [MBProgressHUD hideAllHUDsForView:vc.view animated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = errorMessage;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ErrorInfo_ShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:vc.view animated:YES];
            });
        }
    }
}

+ (void)handlerError:(NSString *)errorMessage currentVC:(UIViewController *)vc loginHandler:(noParameterBlock)handler
{
    [self hideLoading:vc.view];
    if ([errorMessage isEqualToString:SHOP_NO_LOGIN])
    {
        [[HYAccountService sharedService] logout];
        
        if (vc)
        {
            
            [vc loginSuccessHandler:^{
                if (handler)
                {
                    handler();
                }
            }];
        }
        else{
            UIView *view = [self getCurrentView];
            [MBProgressHUD hideAllHUDsForView:view animated:YES];
        }
        
    }
    else{
        if ([errorMessage isEqualToString:REQUEST_SUCCESS]){
            if (handler)
            {
                handler();
            }
        }
        else{
            if (![errorMessage isEqualToString:@""]){
                [MBProgressHUD hideAllHUDsForView:vc.view animated:YES];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.detailsLabelText = errorMessage;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ErrorInfo_ShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:vc.view animated:YES];
                });
            }
        }
    }

}

+ (void)showLoading:(NSString *)message time:(NSInteger)delay currentView:(UIView *)currentView
{
    if (currentView)
    {
        [MBProgressHUD hideAllHUDsForView:currentView animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = message;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:currentView animated:YES];
        });
    }
}
+ (void)showLoading:(NSString *)message currentView:(UIView *)currentView handler:(noParameterBlock)handler
{
    if (currentView)
    {
        [MBProgressHUD hideAllHUDsForView:currentView animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = message;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ErrorInfo_ShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:currentView animated:YES];
            if (handler)
            {
                handler();
            }
        });
    }
}

+ (UIView*)getCurrentView
{
    UIView *view = nil;
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (app.window.rootViewController.presentedViewController)
    {
        view = app.window.rootViewController.presentedViewController.view;
    }
    else
    {
        view = app.window.rootViewController.view;
    }
    return view;
}
@end
