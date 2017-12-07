//
//  TSAction.h
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/9.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef enum
{
    TSActionType_Unknow = -1,
    TSActionType_Goods,  // 商品详情
    TSActionType_Url,   // 某个链接
    TSActionType_Apply // 订单详情
    
} TSActionType;

@interface TSAction : NSObject

@property (nonatomic, assign) TSActionType actionType;
@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, copy)   NSString *messageID; // 消息ID
@property (nonatomic, copy)   NSString *actionContent; // 提现ID
@property (nonatomic, copy)   NSString *messageTime; // 推送时间
@property (nonatomic, copy)   NSString *messageContent; //消息内容

- (TSAction *)doAction;

- (instancetype)initWithDic:(NSDictionary *)dic content:(NSString *)content;

@end
