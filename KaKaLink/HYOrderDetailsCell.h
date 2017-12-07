//
//  HYOrderDetailsCell.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYOrderDetailsCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *messageLbl;

- (void)bindData:(NSString *)title message:(NSString *)message;

@end
