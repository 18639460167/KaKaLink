//
//  HYLiquidationRecordCell.h
//  TourGuidShop
//
//  Created by Black on 17/6/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYSettleListModel;

@interface HYLiquidationRecordCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UILabel *moneyLbl;
@property (nonatomic, strong) HYSettleListModel *model;

- (void)cellAction:(UIViewController *)vc;

@end
