//
//  HYCardTableHeaderView.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYCardTableHeaderView : UIView

@property (nonatomic, strong) UILabel *numberLbl;
@property (nonatomic, strong) UILabel *moneyLbl;
+ (instancetype)createHederView:(NSString *)title textColor:(UIColor *)textColor fatherView:(UIView *)fatherView;

- (void)realodData:(NSString *)number totalAmount:(NSString *)amount;

- (void)reloadData:(id)model;

@end
