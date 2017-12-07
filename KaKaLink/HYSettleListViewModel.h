//
//  HYSettleListViewModel.h
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYSettleListViewModel : HYModel

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSMutableArray *settleArray;

@property (nonatomic, assign) BOOL requestFail;

- (void)loadNewSettleList:(HYHandler)complete;

- (void)loadMoreSettleList:(HYHandler)complete;
@end
