//
//  HYSaleQueryViewController.h
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSuperViewController.h"

@interface HYSaleQueryViewController : HYSuperViewController

@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) HYSaleQueryViewModel *viewModel;

@end
