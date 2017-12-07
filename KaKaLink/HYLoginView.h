//
//  HYLoginView.h
//  TourGuidShop
//
//  Created by Black on 17/4/28.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYLoginViewController.h"

@interface HYLoginView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) HYLoginViewController *currentVC;
@property (nonatomic, strong) UITextField *userText;
@property (nonatomic, strong) UITextField *passText;
@property (nonatomic, copy) noParameterBlock handler;

//+ (instancetype)createView:(UIView *)fathView handler:(noParameterBlock)complete;

+ (void)createLoginView:(HYLoginViewController *)vc;


@end
