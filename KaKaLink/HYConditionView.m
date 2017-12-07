//
//  HYConditionView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYConditionView.h"


@interface HYConditionView()
{
    UIImageView *logoImage;
    UILabel *iconLbl;
}

@end

@implementation HYConditionView

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
        logoImage  = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(WScale*22.5, WScale*22.5));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        iconLbl = [UILabel createCenterLbl:@"" fontSize:15 textColor:[UIColor subjectColor] fatherView:self];
        iconLbl.adjustsFontSizeToFitWidth = YES;
        [iconLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logoImage.mas_bottom).offset(WScale*5);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(WScale*15);
        }];
    }
    return self;
}

/**
 *  修改文本图标
 */
- (void)changeMessage:(NSString *)title
{
    iconLbl.text = title;
    if ([title isEqualToString:@"0"])
    {
        logoImage.image = IMAGE_NAME(@"today");
        iconLbl.text = LS(@"Today");
    }
    else if ([title isEqualToString:@"1"])
    {
        logoImage.image = IMAGE_NAME(@"befor");
        iconLbl.text = LS(@"Before");
    }
    else
    {
        logoImage.image = IMAGE_NAME(@"all");
        iconLbl.text = LS(@"All");
    }
}

@end
