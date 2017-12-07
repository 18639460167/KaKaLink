//
//  HYSettleListTableViewCell.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYSettleListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UILabel *numberLbl;
@property (nonatomic, strong) UILabel *moneyLbl;

- (void)bindModel:(id)model;
@end
