//
//  HYUserHelpModel.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/2.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYModel.h"

@interface HYUserHelpModel : HYModel

@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;


- (instancetype)initWithQuestion:(NSString *)question answer:(NSString *)answer;
@end
