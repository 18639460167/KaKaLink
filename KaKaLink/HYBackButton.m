//
//  HYBackButton.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/22.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "HYBackButton.h"

@implementation HYBackButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)button:(CGRect)frame
{
    HYBackButton *backBtn = [[HYBackButton alloc]initWithFrame:frame];
    return backBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    UIImageView *imageview= [[UIImageView alloc]initWithFrame:CGRectZero];
    imageview.image = IMAGE_NAME(@"nav_back");
    [self addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WScale*13, WScale*19));
    }];
    
    UILabel *backLbl = [UILabel createLbl:LS(@"BACK") fontSize:16 textColor:[UIColor threeTwoColor] fatherView:self];
    backLbl.adjustsFontSizeToFitWidth = YES;
    [backLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageview.mas_centerY);
        make.left.equalTo(imageview.mas_right).offset(WScale*5);
        make.top.equalTo(self);
        make.right.equalTo(self);
    }];
}

@end
