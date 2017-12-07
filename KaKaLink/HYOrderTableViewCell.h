//
//  HYOrderTableViewCell.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTransModel.h"

@interface HYOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *monthLbl;
@property (nonatomic, strong) UILabel *hourceLbl;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *moneyLbl;
@property (nonatomic, strong) UILabel *statusLbl;
@property (nonatomic, strong) UILabel *settleLbl;

@property (nonatomic, strong) HYTransModel *transModel;

- (void)cellAction:(UIViewController *)vc;


@end
