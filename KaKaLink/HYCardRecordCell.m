//
//  HYCardRecordCell.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardRecordCell.h"

@implementation HYCardRecordCell
@synthesize logoImage;
@synthesize nameLbl;
@synthesize convertLbl;
@synthesize timeLbl;
@synthesize statusLbl;
@synthesize moneyLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        logoImage = [HYStyle createImage:@"pay_place"];
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScale*60, HScale*60));
            make.left.equalTo(self).offset(WScale*15);
        }];
        
        statusLbl = [UILabel createRightLbl:LS(@"Settle_Finish") fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(WScale*-15);
            make.top.mas_equalTo(logoImage.mas_top);
            make.height.mas_equalTo(WScale*17);
            make.width.mas_equalTo(WScale*50);
        }];
        
        nameLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(logoImage.mas_top);
            make.height.mas_equalTo(WScale*15);
            make.left.equalTo(logoImage.mas_right).offset(WScale*8);
            make.right.equalTo(statusLbl.mas_left).offset(WScale*-8);
        }];
        
        CGFloat width = [HYStyle getWidthWithTitle:LS(@"Redeem_Code") font:12];
        UILabel *converTitLbl = [UILabel createLbl:LS(@"Redeem_Code") fontSize:12 textColor:[UIColor sixFourColor] fatherView:self];
        [converTitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(logoImage.mas_right).offset(WScale*8);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(width);
        }];
        
        convertLbl = [UILabel createLbl:@"" fontSize:12 textColor:[UIColor colorWithHexString:@"#e99316"] fatherView:self];
        [convertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(converTitLbl.mas_right).offset(4);
            make.right.equalTo(self).offset(WScale*-10);
            make.height.mas_equalTo(WScale*12);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
//        width = [HYStyle getWidthWithTitle:@"2017-08-19 12:07:55.00" font:12]+WScale*5;
        timeLbl = [UILabel createLbl:@"" fontSize:12 textColor:[UIColor sixFourColor] fatherView:self];
        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(logoImage.mas_bottom);
            make.height.mas_equalTo(WScale*12);
            make.left.equalTo(logoImage.mas_right).offset(WScale*8);
            make.width.mas_equalTo(50);
        }];
        
        moneyLbl = [UILabel createRightLbl:@"" fontSize:15 textColor:[UIColor colorWithHexString:@"#e99316"] fatherView:self];
        [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(logoImage.mas_bottom);
            make.height.mas_equalTo(WScale*15);
            make.left.equalTo(timeLbl.mas_right).offset(WScale*8);
            make.right.mas_equalTo(WScale*-15);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor eOneColor]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.equalTo(self).offset(WScale*10);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)bindData:(id)model
{
    if ([model isKindOfClass:[HYCardVertifyModel class]])
    {
        convertLbl.textColor = [UIColor colorWithHexString:@"#ff001f"];
        moneyLbl.textColor = [UIColor colorWithHexString:@"#ff001f"];
        HYCardVertifyModel *verModel = (HYCardVertifyModel*)model;
        nameLbl.text = verModel.title;
        statusLbl.text = verModel.orderStatus;
        timeLbl.text = verModel.verticationDateTime;
        convertLbl.text = verModel.qrCode;
        moneyLbl.text = [verModel.orderPrice addMoneyUnit];
        [logoImage sd_setImageWithURL:[NSURL URLWithString:verModel.picURL] placeholderImage:IMAGE_NAME(@"pay_place") options:SDWebImageAllowInvalidSSLCertificates];
        
        CGFloat width = [HYStyle getWidthWithTitle:verModel.orderStatus font:15];
        [statusLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(width);
        }];
        width = [HYStyle getWidthWithTitle:verModel.verticationDateTime font:12];
        [timeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(width);
        }];
    }
    else if ([model isKindOfClass:[HYCardSettleBatchDetailModel class]])
    {
        convertLbl.textColor = [UIColor colorWithHexString:@"#e99316"];
        moneyLbl.textColor = [UIColor colorWithHexString:@"#e99316"];
        HYCardSettleBatchDetailModel *batchModel = (HYCardSettleBatchDetailModel *)model;
        nameLbl.text = batchModel.title;
        timeLbl.text = batchModel.settlementDate;
        moneyLbl.text = MONEY_ADD_UNIT(batchModel.settlementPrice);
        statusLbl.text = LS(@"Settle_Finish");
        
        convertLbl.text = batchModel.bacthno; 
        CGFloat width = [HYStyle getWidthWithTitle:statusLbl.text font:15];
        [statusLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(width);
        }];
        width = [HYStyle getWidthWithTitle:timeLbl.text font:12];
        [timeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(width);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
