//
//  HYGoodDetailTableViewCell.h
//  KaKaLink
//
//  Created by 张帅 on 2017/11/13.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYGoodDetailModel;

@interface HYGoodDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *numberLbl;

- (void)bindData:(HYGoodDetailModel *)model indexRow:(NSInteger)row;

@end
