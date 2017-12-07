//
//  HYCheckMessageView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTransViewModel;

@interface HYCheckMessageView : UIView

@property (nonatomic, strong) UILabel * mUnitLbl;
@property (nonatomic, strong) UILabel *numberLbl;
@property (nonatomic, strong) UILabel *moneyLbl;
@property (nonatomic, strong) UILabel *nUnitLbl;

- (void)bindModel:(HYTransViewModel *)model;

@end
