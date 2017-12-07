//
//  HYCardVerifyTableViewCell.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYCardVerifyTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *messageLbl;

- (void)bindData:(NSString *)title message:(NSString *)message;

@end
