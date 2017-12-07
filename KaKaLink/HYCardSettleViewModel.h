//
//  HYCardSettleViewModel.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCardSettleViewModel : NSObject

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger total_count;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, strong) NSMutableArray *settleModelArray;

@property (nonatomic, assign) BOOL isRequestFail;// 是否请求失败

- (void)loadNewList:(HYHandler)complete;
- (void)loadMore:(HYHandler)complete;



@end
