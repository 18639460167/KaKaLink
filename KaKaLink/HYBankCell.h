//
//  HYBankCell.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBankCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *mssageLbl;


- (void)bindData:(NSString *)title message:(NSString *)message;
@end
