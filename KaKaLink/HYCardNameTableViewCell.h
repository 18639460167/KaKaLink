//
//  HYCardNameTableViewCell.h
//  KaKaLink
//
//  Created by 张帅 on 2017/11/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYCardNameTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *titleLbl;

- (void)bindName:(NSString *)title goodName:(NSString *)name;

@end
