//
//  NotifiMessageViewModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/5.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYViewModel.h"
#import "NotifiMessageModel.h"
@interface NotifiMessageViewModel : HYViewModel

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger messageTotal;// 消息条数
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *messageArray; // 消息数组

@property (nonatomic, assign) BOOL isRequestFaild; // 是否请求失败

/**
 *  获取消息列表
 *
 */
- (void)loadNewList:(backHandler)complete;
- (void)loadMore:(backHandler)complete;

/**
 *  设置消息为已读
 */
+ (void)handleMessage:(NSString *)messageID  handler:(backHandler)complete;

/**
 *  消息删除
 */
+ (void)pushDelete:(NSString *)messageID handler:(backHandler)complete;

@end
