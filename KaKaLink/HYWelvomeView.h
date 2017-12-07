//
//  HYWelvomeView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^hideAction)(BOOL isFirst);

@interface HYWelvomeView : UIView

@property (nonatomic, copy) hideAction complete;

+ (void)showAction:(hideAction)handler;

@end
