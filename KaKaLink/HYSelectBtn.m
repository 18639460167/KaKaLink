//
//  HYSelectBtn.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSelectBtn.h"

@implementation HYSelectBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)buttonFrame:(CGRect)frame title:(NSString *)title logoName:(NSString *)imageName
{
    HYSelectBtn *btn = [[HYSelectBtn alloc]initWithFrame:frame title:title logoName:imageName];
    return btn;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title logoName:(NSString *)imageName
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectZero];
        image.image = IMAGE_NAME(imageName);
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(WScale*17.5, WScale*17.5));
        }];
        UILabel *myLable = [UILabel createCenterLbl:title fontSize:10 textColor:[UIColor sixFourColor] fatherView:self];
        [myLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(image.mas_bottom).offset(WScale*3);
            make.height.mas_equalTo(WScale*10);
        }];
    }
    return self;
}

@end
