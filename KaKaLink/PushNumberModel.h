//
//  PushNumberModel.h
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/15.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PushNumberModel : NSObject

@property (nonatomic, assign) NSInteger pushNumber;

+ (instancetype)shareModel;

+ (void)clearBageNumber; // 角标清零
+ (void)BageNumberDeauce; // 角标减少
+ (void)setPadgeBadge;

@end
