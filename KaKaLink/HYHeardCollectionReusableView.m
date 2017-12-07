//
//  HYHeardCollectionReusableView.m
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYHeardCollectionReusableView.h"

@implementation HYHeardCollectionReusableView
@synthesize titleLbl;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        titleLbl = [UILabel createLbl:@"" fontSize:13 textColor:[UIColor threeTwoColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(WScale*10);
            make.right.equalTo(self);
            make.bottom.equalTo(self).offset(HScale*-10);
            make.height.mas_equalTo(WScale*15);
        }];
    }
    return self;
}

@end
