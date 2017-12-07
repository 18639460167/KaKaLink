//
//  HYPushItem.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/9.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYViewModel.h"
#import "TSAction.h"
#import "MessageButton.h"
#import "PushNumberModel.h"

static NSString *const PushBadgeNotification = @"PushBadgeNotification";
@interface HYPushItem : HYViewModel

@property (nonatomic, assign) NSInteger badge;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, strong) TSAction *action;

- (void)setBadgeIfNeedUpdate;
- (instancetype)initWithDic:(NSDictionary *)pushDic;

// 注册通知
+ (void)registerNoti:(NSString *)deviceToken backHandler:(void(^)(NSString *))complete;
@end
