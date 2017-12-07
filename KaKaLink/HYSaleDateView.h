//
//  HYSaleDateView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^queryAction)(NSString *startDate,NSString *endDate);
@interface HYSaleDateView : UIView

@property (nonatomic, strong) UILabel *firstLbl;
@property (nonatomic, strong) UILabel *twoLbl;
@property (nonatomic, strong) UIButton *queryBtn ;
@property (nonatomic, copy)   queryAction queAction;

+ (instancetype)createDateView:(UIViewController *)vc;
@end
