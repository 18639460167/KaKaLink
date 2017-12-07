//
//  HYUserView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYUserView.h"

@implementation HYUserView
@synthesize messsageLbl;
@synthesize alertLbl;

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
        alertLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [alertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(WScale*12.5);
            make.width.mas_equalTo(WScale*100);
        }];
        
        messsageLbl = [UILabel createRightLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [messsageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(WScale*-12.5);
            make.left.equalTo(alertLbl.mas_right).offset(WScale*8);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor eOneColor]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.equalTo(self).offset(WScale*12.5);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)bindData:(NSString *)title
{
    self.alertLbl.text = title;
    CGFloat width = [HYStyle getWidthWithTitle:title font:15];
    [alertLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(width);
        make.left.equalTo(self).offset(WScale*12.5);
    }];
}

@end
