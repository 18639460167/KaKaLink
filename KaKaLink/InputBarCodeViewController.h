//
//  InputBarCodeViewController.h
//  TutwoShop
//
//  Created by 章叶飞 on 16/1/5.
//  Copyright © 2016年 Tutwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSuperViewController.h"
#define TRIM(string) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

@interface InputBarCodeViewController : HYSuperViewController

@property (nonatomic, copy) BOOL(^clickHandler)(NSString *barCode);

@end
