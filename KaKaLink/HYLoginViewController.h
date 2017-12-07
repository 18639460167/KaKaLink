//
//  HYLoginViewController.h
//  TourGuidShop
//
//  Created by Black on 17/4/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSuperViewController.h"

@interface HYLoginViewController : HYSuperViewController

@property (nonatomic, strong) UIImageView *bgImage;

@property (nonatomic, assign) BOOL isHome;
@property (nonatomic, copy) void(^loginHandler)();

@end
