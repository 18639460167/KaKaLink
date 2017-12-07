//
//  HYCardRecordCell.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYCardVertifyModel;
@interface HYCardRecordCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *convertLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UILabel *statusLbl;
@property (nonatomic, strong) UILabel *moneyLbl;

- (void)bindData:(id)model;

@end
