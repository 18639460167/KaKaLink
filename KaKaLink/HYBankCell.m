//
//  HYBankCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYBankCell.h"

@implementation HYBankCell
@synthesize mssageLbl;
@synthesize titleLbl;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        titleLbl = [UILabel createLbl:READ_BANK_NAME fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(WScale*20);
            make.width.mas_equalTo(WScale*150);
        }];
        NSString *str = @"";
        if ([READ_BANK_NUMBER length]>=4)
        {
            str = [READ_BANK_NUMBER substringFromIndex:[READ_BANK_NUMBER length]-4 ];
        }
        mssageLbl = [UILabel createRightLbl:[NSString stringWithFormat:@"%@(%@)",LS(@"Tail_Number"),str] fontSize:15 textColor:[UIColor nineSixColor] fatherView:self];
        [mssageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(-WScale*20);
            make.left.equalTo(titleLbl.mas_right).offset(WScale*8);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor eOneColor]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.equalTo(self).offset(WScale*20);
        }];
    }
    return self;
}


- (void)bindData:(NSString *)title message:(NSString *)message
{
    CGFloat width = [HYStyle getWidthWithTitle:title font:15];
    
    titleLbl.text = title;
    mssageLbl.text = message;
    [titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(WScale*20);
        make.width.mas_equalTo(width);
    }];
}
@end
