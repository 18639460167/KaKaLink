//
//  HYSettingUserCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSettingUserCell.h"
#import "HYBankViewController.h"
#import "HYQrCodeViewController.h"
@interface HYSettingUserCell()
{
    UIImageView *logoImage;
    UILabel *messageLbl;
}
@end
@implementation HYSettingUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [HYStyle createView:[UIColor fSixColor]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1);
        }];
        
        UIView *oneView = [HYStyle createView:WHITE_COLOR];
        [self addSubview:oneView];
        [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.right.equalTo(lineView.mas_left);
        }];
        
        UIImageView *oneImage = [UIImageView new];
        oneImage.image = IMAGE_NAME(@"bank");
        [oneView addSubview:oneImage];
        [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(WScale*25, HScale*18));
            make.centerY.mas_equalTo(oneView.mas_centerY);
            make.left.equalTo(oneView).offset(WScale*115/2);
        }];
        UILabel *oneLbl = [UILabel createLbl:LS(@"Bank_Card") fontSize:15 textColor:[UIColor sixFourColor] fatherView:oneView];
        [oneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(oneView.mas_centerY);
            make.left.equalTo(oneImage.mas_right).offset(WScale*5);
            make.right.equalTo(oneView).offset(WScale*-8);
            make.height.mas_equalTo(HScale*18);
        }];
        
        
        UIView *twoView = [HYStyle createView:WHITE_COLOR];
        [self addSubview:twoView];
        [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.left.equalTo(lineView.mas_right);
        }];
        
        UIImageView *twoImage = [UIImageView new];
        twoImage.image = IMAGE_NAME(@"code");
        [twoView addSubview:twoImage];
        [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(WScale*25, HScale*25));
            make.centerY.mas_equalTo(twoView.mas_centerY);
            make.left.equalTo(twoView).offset(WScale*115/2);
        }];
        UILabel *twoLbl = [UILabel createLbl:LS(@"Qr_Code") fontSize:15 textColor:[UIColor sixFourColor] fatherView:twoView];
        [twoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(twoView.mas_centerY);
            make.left.equalTo(twoImage.mas_right).offset(WScale*5);
            make.right.equalTo(twoView).offset(WScale*-8);
            make.height.mas_equalTo(HScale*18);
        }];
        self.bankButton = [UIButton buttonWithType:0];
        self.bankButton.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
        [self.bankButton addTarget:self action:@selector(bankAction) forControlEvents:UIControlEventTouchUpInside];
        [oneView addSubview:self.bankButton];
        [self.bankButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(oneView);
        }];
        
        self.codeButton = [UIButton buttonWithType:0];
        self.codeButton.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
        [self.codeButton addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
        [twoView addSubview:self.codeButton];
        [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(twoView);
        }];
    }
    return self;
}
- (void)bankAction
{
    if (self.currentVC)
    {
        [self.currentVC.navigationController pushViewController:[HYBankViewController new] animated:YES];
    }
}

- (void)codeAction
{
    if (self.currentVC)
    {
        [self.currentVC.navigationController pushViewController:[HYQrCodeViewController new] animated:YES];
    }
}


@end
