//
//  HYOrderSendEmailView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/9.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^sendList)(NSString *email);
@interface HYOrderSendEmailView : UIView

+ (void)createView:(sendList)compltet;


@end
