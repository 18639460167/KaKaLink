//
//  HYSettingActionCell.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnTag)(NSInteger tap);
@interface HYSettingActionCell : UITableViewCell
@property (nonatomic, copy) btnTag complete;

@property (nonatomic, strong) UIViewController *currentVC;

@end
