//
//  MessageButton.h
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/13.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnAction)(void);
@interface MessageButton : UIButton

@property (nonatomic, assign) NSInteger messageNumber;
@property (nonatomic, copy) btnAction myAction;

+ (MessageButton *)shareMessageButton;

+ (void)showInView:(UIView *)view btnAction:(btnAction)handler;

@end
