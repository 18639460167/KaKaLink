//
//  HYPassView.h
//  ZSAlert
//
//  Created by tenpastnine-ios-dev on 17/1/11.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^refundSuccess)(void);
@interface HYPassView : UIView

+ (void)createView:(NSString *)message money:(NSString *)money trans_id:(NSString *)trans_id handler:(refundSuccess)complete;
/**
 *  退款
 *
 */
+ (void)createView:(NSString *)message refubd_Type:(NSString *)refund_Type money:(NSString *)money refund_reason:(NSString *)reason trans_id:(NSString *)trans_id handler:(refundSuccess)complete;

/**
 *  提现
 */
+ (void)createView:(NSString *)message withdrawMoney:(NSString *)money handler:(refundSuccess)complete;

- (void)requestSuccess;
- (void)requestFaild;

@end
