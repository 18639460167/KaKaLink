//
//  HYSelectOneCell.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYCardTypeModel;

@interface HYSelectOneCell : UITableViewCell


- (void)bindData:(NSNumber *)isSelect title:(NSString *)title;

- (void)bindModel:(HYCardTypeModel *)model;

@end
