//
//  UIButton+HYButtonAction.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYSaleQueryViewController;

@interface UIButton (HYButtonAction)

- (void)setBtnTitle:(NSString *)title sizeFont:(CGFloat)font sizeColor:(UIColor *)sizeColor action:(void(^)())actionHandler;

- (void)buttonStatus:(NSString *)title;

- (void)setLayerBtn:(NSString *)title fontName:(NSString *)fontName sizeFont:(CGFloat)font sizeColor:(UIColor *)sizeColor backColor:(UIColor *)backColor;

+ (instancetype)createBtnWithbgColor:(UIColor *)bgColor title:(NSString *)title textColor:(UIColor *)textColor font:(CGFloat)font handler:(noParameterBlock)complete;


/**
 *  按钮是否可点击
 *
 */
- (void)racIsEnable:(UITextField *)phoneTxt textLength:(NSInteger)lenght passTxt:(UITextField *)passTxt passLength:(NSInteger)passLength backColor:(UIColor *)backColor;





- (void)racIsEnable:(UITextField *)nameTxt cNameTxt:(UITextField *)cNameText backColor:(UIColor *)backColor borderColor:(UIColor *)borderColor;


/**
 *  验证码
 */

/**
 *  验证码
 */
- (void)racVertifyBtn:(UITextField *)verTxt;

+ (instancetype)createLayerBtn:(NSString *)title titColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor layerColor:(UIColor *)layerColor font:(CGFloat)font btnAction:(void(^)())complete;

+ (instancetype)createNoLayerBtn:(NSString *)title titColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor font:(CGFloat)font btnAction:(void(^)())complete;

/**
 *  创建订单底部按钮
 *
 *  @param vc <#vc description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)crateTransBottomBtn:(UIViewController *)vc;

+ (instancetype)createSendEmailBtn:(HYSaleQueryViewController *)vc;


+ (instancetype)createBgImageBtn:(NSString *)title font:(CGFloat)font bgColor:(NSString *)bgName height:(CGFloat)height btnAction:(void(^)())complete;

@end
