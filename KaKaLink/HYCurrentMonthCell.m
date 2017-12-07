//
//  HYCurrentMonthCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCurrentMonthCell.h"
@interface HYCurrentMonthCell()

@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UILabel *monthLbl;
@property (nonatomic, strong) UILabel *moneyLbl;

@end

@implementation HYCurrentMonthCell
@synthesize timeLbl;
@synthesize moneyLbl;
@synthesize monthLbl;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        timeLbl = [UILabel createCenterLbl:@"" fontSize:15 textColor:[UIColor sixFourColor] fatherView:self];
        timeLbl.layer.cornerRadius = HScale*25/2;
        timeLbl.layer.borderWidth = 0.5;
        timeLbl.layer.borderColor = [UIColor sixFourColor].CGColor;
        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(WScale*25);
            make.size.mas_equalTo(CGSizeMake(WScale*80, HScale*25));
        }];
        
        moneyLbl = [UILabel createRightLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.equalTo(self).offset(WScale*-25);
            make.left.equalTo(timeLbl.mas_right).offset(WScale*10);
            make.height.mas_equalTo(HScale*20);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor eOneColor]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
            make.left.equalTo(self).offset(WScale*25);
        }];
    }
    return self;
}


- (void)bindData:(HYSaleMonthModel *)data
{
    timeLbl.text = data.time;
    moneyLbl.text = [data.sale addMoneyUnit];
}

@end
