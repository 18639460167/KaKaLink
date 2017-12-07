//
//  HYCheckMessageView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCheckMessageView.h"

@interface HYCheckMessageView()
@end

@implementation HYCheckMessageView
@synthesize mUnitLbl;
@synthesize numberLbl;
@synthesize moneyLbl;
@synthesize nUnitLbl;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *bgImage = [UIImageView new];
        bgImage.image = IMAGE_NAME(@"check_data");
        [self addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor whiteColor]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(WScale*1.5, HScale*15));
            make.top.equalTo(self).offset(HScale*30);
        }];
        
        nUnitLbl = [UILabel createCenterLbl:LS(@"All_Volue_Orders") fontSize:15 textColor:WHITE_COLOR fatherView:self];
        [nUnitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lineView.mas_centerY);
            make.left.equalTo(self).offset(WScale*8);
            make.right.equalTo(lineView.mas_left).offset(-WScale*8);
            make.height.mas_equalTo(HScale*20);
        }];
        
        mUnitLbl = [UILabel createCenterLbl:[NSString stringWithFormat:@"%@ / %@",LS(@"Total_Sale"),READ_SHOP_SIGN] fontSize:15 textColor:WHITE_COLOR fatherView:self];
        [mUnitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lineView.mas_centerY);
            make.right.equalTo(self).offset(-WScale*8);
            make.left.equalTo(lineView.mas_right).offset(-WScale*8);
            make.height.mas_equalTo(HScale*20);
        }];
        
        numberLbl = [UILabel createCenterLbl:@"0" fontSize:24 textColor:WHITE_COLOR fatherView:self];
        numberLbl.adjustsFontSizeToFitWidth = YES;
        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_equalTo(WScale*5);
            make.top.equalTo(nUnitLbl.mas_bottom).offset(HScale*8);
            make.height.mas_equalTo(HScale*27);
            make.centerX.mas_equalTo(nUnitLbl.mas_centerX);
            
        }];
        
        moneyLbl = [UILabel createCenterLbl:@"0" fontSize:24 textColor:WHITE_COLOR fatherView:self];
        moneyLbl.adjustsFontSizeToFitWidth = YES;
        [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).mas_equalTo(-WScale*5);
            make.centerX.mas_equalTo(mUnitLbl.mas_centerX);
            make.top.equalTo(nUnitLbl.mas_bottom).offset(HScale*8);
            make.height.mas_equalTo(HScale*27);
        }];
        
        UIView *linew = [HYStyle createView:[UIColor whiteColor]];
        [self addSubview:linew];
        [linew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(HScale *10);
        }];
        
    }
    return self;
}

- (void)bindModel:(HYTransViewModel *)model
{
    self.moneyLbl.text = model.total_settle_amout;
    self.numberLbl.text = model.totalCount;
}

@end
