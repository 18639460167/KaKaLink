//
//  HYMessageModel.h
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMessageModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *tID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelect;

+ (instancetype)createDic:(NSDictionary *)dic;

@end
