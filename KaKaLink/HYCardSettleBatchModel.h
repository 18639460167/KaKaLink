//
//  HYCardSettleBatchModel.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCardSettleBatchModel : NSObject

@property (nonatomic, copy) NSString *batchno; // 批次
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *finishcount;
@property (nonatomic, copy) NSString *finishtime;
@property (nonatomic, copy) NSString *batchID;
@property (nonatomic, copy) NSString *settlementtype;
@property (nonatomic, copy) NSString *settlementterm;
@property (nonatomic, copy) NSString *totalCount;
@property (nonatomic, copy) NSString *totalamount;


@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger total_count;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, strong) NSMutableArray *settleModelArray;

@property (nonatomic, assign) BOOL isRequestFail;// 是否请求失败

+ (instancetype)initWithDic:(NSDictionary *)dic;

- (void)loadNewList:(HYHandler)complete;
- (void)loadMore:(HYHandler)complete;


@end
