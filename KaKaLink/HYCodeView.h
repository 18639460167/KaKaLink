//
//  HYCodeView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/31.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYShopListModel.h"

@interface HYCodeView : UIView

@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *coedImage;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *numberLbl;

- (void)bindModel:(HYShopListModel *)model;

@end
