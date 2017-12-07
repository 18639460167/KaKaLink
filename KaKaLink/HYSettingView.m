//
//  HYSettingView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSettingView.h"

@interface HYSettingView()

@property (nonatomic, copy) setAction block;

@end

@implementation HYSettingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)createViewInView:(UIView *)view action:(setAction)complete
{
    CGFloat width = [HYStyle getWidthWithTitle:LS(@"setting") font:12];
    if (width<WScale*25)
    {
        width = WScale*25;
    }
    HYSettingView *setView = [[HYSettingView alloc]initWithFrame:CGRectMake(WScale*15, HScale*40, width+5, HScale*38) action:complete];
    [view addSubview:setView];
}

- (instancetype)initWithFrame:(CGRect)frame action:(setAction)complete
{
    if (self = [super initWithFrame:frame])
    {
        self.block = complete;
        
        UIImageView *setImage = [HYStyle createImage:@"user_setting"];
        [self addSubview:setImage];
        [setImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(HScale*20, HScale*20));
        }];
        
        UILabel *setLbl = [UILabel createCenterLbl:LS(@"setting") fontSize:12 textColor:WHITE_COLOR fatherView:self];
        [setLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(setImage.mas_bottom).offset(HScale*4);
        }];
        
        UIButton *actionBtn = [UIButton buttonWithType:0];
        [[actionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (complete)
            {
                complete();
            }
        }];
        [self addSubview:actionBtn];
        [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    return self;
}



@end
