//
//  NotifiMessageModel.h
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/13.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotifiMessageModel : NSObject

@property (nonatomic, copy) NSString *timeMessage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content; // body
@property (nonatomic, assign) NSInteger messageType; // 消息类型
@property (nonatomic, assign) BOOL isRead; // 是否已读 0未读 1已读
@property (nonatomic, copy) NSString *messageID; // 消息ID
@property (nonatomic, copy) NSString *applyID; // 支付ID

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
