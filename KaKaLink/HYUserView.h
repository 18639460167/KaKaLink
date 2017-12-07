//
//  HYUserView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYUserView : UIView

@property (nonatomic, strong) UILabel *alertLbl;
@property (nonatomic, strong) UILabel *messsageLbl;

- (void)bindData:(NSString *)title;
@end
