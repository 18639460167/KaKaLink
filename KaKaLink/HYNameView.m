//
//  HYNameView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYNameView.h"

@interface HYNameView()
{
    UILabel *nameLbl;
    UIImageView *editImage;
}
@end

@implementation HYNameView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        nameLbl = [UILabel createLbl:@"" fontSize:15 textColor:WHITE_COLOR fatherView:self];
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.mas_equalTo(WScale*54/2);
        }];
    }
    return self;
}

- (void)setName:(NSString *)name
{
    _name = name;
   CGFloat width = [HYStyle getWidthWithTitle:name font:15];
    if (width>SCREEN_WIDTH-WScale*135)
    {
        width = SCREEN_WIDTH-WScale*135;
    }
    nameLbl.text = name;
    [nameLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(width);
    }];
}
@end
