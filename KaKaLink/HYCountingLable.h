//
//  HYCountingLable.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/9.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HYLableCountingMethod) {
    HYLableCountingMethodEaseInOut,
    HYLableCountingMethodEaseIn,
    HYLableCountingMethodEaseOut,
    HYLableCountingMethodLinear
};

typedef NSString* (^HYCountingLableFormatBlock)(CGFloat value);
typedef NSAttributedString* (^HYCountingLableAttributedFormatBlock)(CGFloat value);

@interface HYCountingLable : UILabel

@property (nonatomic, copy) NSString *oldMoney;
// 单位
@property (nonatomic, copy) NSString *unit;
// 数字类型
@property (nonatomic, copy) NSString *format;
//如果浮点需要千分位分隔符,须使用@"###,##0.00"进行控制样式
@property (nonatomic, copy) NSString *positiveFormat;
// 动画类型
@property (nonatomic, assign) HYLableCountingMethod method;
// 动画时间
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy)  HYCountingLableFormatBlock formatBlock;
@property (nonatomic, copy) HYCountingLableAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) void(^completionBlock)();

- (void)countForm:(CGFloat)startValue to:(CGFloat)endValue;
- (void)countForm:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (void)countFormaCurrentValueTo:(CGFloat)endValue;
- (void)countFormaCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (void)countFromZeroTo:(CGFloat)endValue;
- (void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (CGFloat)currantValue;
@end
