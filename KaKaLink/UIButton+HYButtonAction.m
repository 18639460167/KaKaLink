//
//  UIButton+HYButtonAction.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "UIButton+HYButtonAction.h"
#import "DefineHeard.h"
#import "HYStyle.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UIButton (HYButtonAction)

- (void)setBtnTitle:(NSString *)title sizeFont:(CGFloat)font sizeColor:(UIColor *)sizeColor action:(void (^)())actionHandler
{
    [self setTitle:title forState:0];
    self.titleLabel.font = FONTSIZE(font);
    [self setTitleColor:sizeColor forState:0];
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if (actionHandler)
        {
            actionHandler();
        }
    }];
}

- (void)buttonStatus:(NSString *)title
{
    [self setTitle:title forState:0];
    self.titleLabel.font = FONTSIZE(15);
    [self setTitleColor:[UIColor nineSixColor] forState:0];
    [self setTitleColor:[UIColor subjectColor] forState:UIControlStateSelected];
}
- (void)setLayerBtn:(NSString *)title fontName:(NSString *)fontName sizeFont:(CGFloat)font sizeColor:(UIColor *)sizeColor backColor:(UIColor *)backColor
{
    [self setTitle:title forState:0];
    self.titleLabel.font = FONTSIZE(font);
    [self setTitleColor:sizeColor forState:0];
    self.layer.cornerRadius = WScale*4;
    self.backgroundColor = backColor;
}

+ (instancetype)createBtnWithbgColor:(UIColor *)bgColor title:(NSString *)title textColor:(UIColor *)textColor font:(CGFloat)font handler:(noParameterBlock)complete
{
    UIButton *button = [UIButton buttonWithType:0];
    button.titleLabel.font = FONTSIZE(font);
    [button setTitleColor:textColor forState:0];
    [button setTitle:title forState:0];
    button.backgroundColor = bgColor;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (complete)
        {
            complete();
        }
    }];
    return button;
}

- (void)racIsEnable:(UITextField *)phoneTxt textLength:(NSInteger)lenght passTxt:(UITextField *)passTxt passLength:(NSInteger)passLength backColor:(UIColor *)backColor
{
    RACSignal *oldPassSingal = [phoneTxt.rac_textSignal map:^id(NSString *text) {
        return @(text.length >= lenght);
    }];
    RACSignal *newPassSignal = [passTxt.rac_textSignal map:^id(NSString *text) {
        return @(text.length >= passLength);
    }];
    
    [[RACSignal combineLatest:@[oldPassSingal,newPassSignal] reduce:^id(NSNumber *usernameValid , NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }]
     subscribeNext:^(NSNumber *loginBtnSingal) {
         self.enabled = [loginBtnSingal boolValue];
         if ([loginBtnSingal boolValue])
         {
             self.backgroundColor = backColor;
         }
         else
         {
             self.backgroundColor = RGB(210, 210, 210);
         }
     }];
}

- (void)racIsEnable:(UITextField *)nameTxt cNameTxt:(UITextField *)cNameText backColor:(UIColor *)backColor borderColor:(UIColor *)borderColor
{
    RACSignal *oldPassSingal = [nameTxt.rac_textSignal map:^id(NSString *text) {
        return @(text.length >= 1);
    }];
    RACSignal *newPassSignal = [cNameText.rac_textSignal map:^id(NSString *text) {
        return @(text.length >= 1);
    }];
    
    [[RACSignal combineLatest:@[oldPassSingal,newPassSignal] reduce:^id(NSNumber *usernameValid,NSNumber *cNameValid){
        return @([usernameValid boolValue] && [cNameValid boolValue]);
    }]
     subscribeNext:^(NSNumber *loginBtnSingal) {
         self.enabled = [loginBtnSingal boolValue];
         if ([loginBtnSingal boolValue])
         {
             self.backgroundColor = backColor;
             self.layer.borderColor = borderColor.CGColor;
             [self setTitleColor:borderColor forState:0];
         }
         else
         {
             self.backgroundColor = RGB(210, 210, 210);
             self.layer.borderColor = RGB(210, 210, 210).CGColor;
             [self setTitleColor:WHITE_COLOR forState:0];
         }
     }];

}

/**
 *  验证码按钮
 */

- (void)racVertifyBtn:(UITextField *)verTxt
{
    RACSignal *oldPassSingal = [verTxt.rac_textSignal map:^id(NSString *text) {
        return @(text.length >= 11);
    }];
    
    [[RACSignal combineLatest:@[oldPassSingal] reduce:^id(NSNumber *usernameValid){
        return @([usernameValid boolValue]);
    }]
     subscribeNext:^(NSNumber *loginBtnSingal) {
         self.enabled = [loginBtnSingal boolValue];
         if ([loginBtnSingal boolValue])
         {
             self.layer.borderColor = [UIColor subjectColor].CGColor;
             [self setTitleColor:[UIColor subjectColor] forState:0];
             self.backgroundColor = [UIColor whiteColor];
         }
         else
         {
             [self setTitleColor:[UIColor whiteColor] forState:0];
             self.layer.borderColor = RGB(210, 210, 210).CGColor;
             self.backgroundColor = RGB(210, 210, 210);
         }
     }];
}


+ (instancetype)createLayerBtn:(NSString *)title titColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor layerColor:(UIColor *)layerColor font:(CGFloat)font btnAction:(void(^)())complete
{
    UIButton *button = [UIButton buttonWithType:0];
    [button setTitle:title forState:0];
    [button setTitleColor:titleColor forState:0];
    button.backgroundColor = bgColor;
    button.layer.cornerRadius = WScale*4;
    button.layer.borderWidth = 0.5;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = layerColor.CGColor;
    button.titleLabel.font = FONTSIZE(font);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (complete)
        {
            complete();
        }
    }];
    return button;
}

+ (instancetype)createNoLayerBtn:(NSString *)title titColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor font:(CGFloat)font btnAction:(void(^)())complete
{
    UIButton *button = [UIButton buttonWithType:0];
    [button setTitle:title forState:0];
    [button setTitleColor:titleColor forState:0];
    button.backgroundColor = bgColor;
    button.layer.cornerRadius = WScale*4;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = FONTSIZE(font);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (complete)
        {
            complete();
        }
    }];
    return button;
}

#pragma mark - 订单详情底部

+ (instancetype)crateTransBottomBtn:(UIViewController *)vc
{
    UIButton *button = [UIButton createBgImageBtn:[NSString stringWithFormat:@"%@%@",LS(@"Contact_Customer_Service"),READ_SERVICE_PHONE] font:15 bgColor:@"save_bg" height:HScale*40 btnAction:^{
        [HYStyle HYTelPhone:vc.view];
    }];
    [vc.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(vc.view).offset(HScale*-10);
        make.centerX.mas_equalTo(vc.view.mas_centerX);
        make.left.equalTo(vc.view).offset(WScale*12);
        make.height.mas_equalTo(HScale*40);
    }];
    return button;
}

+ (instancetype)createSendEmailBtn:(HYSaleQueryViewController *)vc
{
    UIButton *bottomBtn = [UIButton createBtnWithbgColor:[UIColor subjectColor] title:LS(@"Send_Order") textColor:WHITE_COLOR font:15 handler:^{
        [HYOrderSendEmailView createView:^(NSString *email) {
            [HYProgressHUD showLoading:@"" rootView:vc.view];
            [HYSaleQueryViewModel sendOrderList:vc.startTime endTime:vc.endTime email:email settleStatus:vc.viewModel.settle_status handler:^(NSString *status) {
                [HYProgressHUD hideLoading:vc.view];
                if ([status isEqualToString:REQUEST_SUCCESS])
                {
                    SET_USER_DEFAULT(email, SHOP_GETORDER_EMAIL);
                    SYN_USER_DEFAULT;
                    [HYProgressHUD showLoading:LS(@"Send_Success") time:ErrorInfo_ShowTime currentView:vc.view];
                }
                else
                {
                    if ( [status isEqualToString:@"操作太频繁"])
                    {
                        [HYProgressHUD showLoading:LS(@"Send_More") time:ErrorInfo_ShowTime currentView:vc.view];
                    }
                    else
                    {
                        [HYProgressHUD handlerDataError:status currentVC:vc handler:nil];
                    }
                }
            }];
        }];
        
    }];
    [vc.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(vc.view);
        make.height.mas_equalTo(HScale*50);
    }];
    return bottomBtn;
}

+ (instancetype)createBgImageBtn:(NSString *)title font:(CGFloat)font bgColor:(NSString *)bgName height:(CGFloat)height btnAction:(void (^)())complete
{
    UIButton *button = [UIButton buttonWithType:0];
    [button setTitle:title forState:0];
    [button setTitleColor:WHITE_COLOR forState:0];
    [button setBackgroundImage:IMAGE_NAME(bgName) forState:0];
    button.layer.cornerRadius = height/2;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = FONTSIZE(font);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (complete)
        {
            complete();
        }
    }];
    return button;
}


@end
