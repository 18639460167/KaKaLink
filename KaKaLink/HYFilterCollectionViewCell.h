//
//  HYFilterCollectionViewCell.h
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMessageModel.h"

@interface HYFilterCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *titleLbl;

- (void)bindMessageModel:(HYMessageModel *)model isOne:(BOOL)isFirst;

@end
