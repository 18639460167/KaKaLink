//
//  HYSettleDetailViewModel.h
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYSettleDetailViewModel : HYModel

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSMutableArray *transArray;
@property (nonatomic, copy) NSString *settlement_ID; // 清算ID

@property (nonatomic, assign) BOOL requestFail;

- (void)loadNewSettleList:(HYHandler)complete;

- (void)loadMoreSettleList:(HYHandler)complete;

@end
