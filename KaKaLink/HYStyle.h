//
//  HYStyle.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/22.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ORIGINAL_MAX_WIDTH 640.0f
typedef void (^AlertViewButtonClickedHandler)(UIView *alertView, NSInteger buttonIndex);

@interface ActionSheet : UIActionSheet <UIActionSheetDelegate>
{
}

- (id)initWithTitle:(NSString *)title buttonClickHandler:(AlertViewButtonClickedHandler)handler cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property (nonatomic, copy) AlertViewButtonClickedHandler buttonClickedHandler;

@end

typedef void (^noParameterBlock)(void);

typedef void (^HYHandler)(id value);


@interface HYStyle : NSObject


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  宽度固定，lable自适应高度
 *
 *  @param width lable宽度
 *  @param title 文本
 *  @param font  字体大小
 *
 *  @return 文本高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(CGFloat)font;

/**
 *  根据文本，lable宽度自适应
 *
 *  @param title 文本
 *  @param font  字体大小
 *
 *  @return 文本宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(CGFloat)font;

/**
 *  比较时间
 *
 *  @param startDate 开始时间
 *  @param endDate   结束时间 
 */
+ (void)compareDate:(NSString *)startDate endDate:(NSString *)endDate handler:(void(^)(NSString *status))action;
/**
 *  客服电话
 *
 *  @param currentView 当前试图
 */
+ (void)HYTelPhone:(UIView *)currentView;

/**
 *  生成二维码
 */
+ (UIImage *)getCodeImage:(CGSize)make codeStr:(NSString *)codeStr;

/**
 *  请求错误处理
 */
+ (void)handlerError:(NSString *)message;

/**
 *  数据处理登录回调
 *
 */
+ (void)handlerError:(NSString *)message currentVc:(UIViewController *)vc loginHandler:(void(^)(void))complete;

+ (void)showAlert:(NSString *)message;

+ (UIButton *)createRightBtn:(NSString *)title action:(void(^)(void))action;


/**
 *  设置返回按钮事件
 */
+ (void)setLeftBtnVC:(UIViewController *)vc action:(void(^)(void))action;
/**
 *  订单状态处理
 */


+ (NSString *)volueTime:(NSString *)time;

+ (NSString *)orderRefundReason:(NSString *)reason;

/**
 *  创建view
 */
+ (UIView *)createView:(UIColor *)backColor;
/**
 *  创建image
 */
+ (UIImageView *)createImage:(NSString *)imageName;

+ (UIImageView *)createImage:(NSString *)url placeName:(NSString *)placeName;


/**
 *  颜色生成图片
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage*) createImageWithColor:(UIColor*) color;


+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;


/**
 折线图时间数组

 @return 时间数组
 */
+ (NSArray *)dateTimeArray;

@end
