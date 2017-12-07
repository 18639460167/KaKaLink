//
//  HYLiquidationRecordCell.m
//  TourGuidShop
//
//  Created by Black on 17/6/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYLiquidationRecordCell.h"

@implementation HYLiquidationRecordCell
@synthesize timeLbl;
@synthesize moneyLbl;

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
        
        UIImageView *logoImage = [HYStyle createImage:@"withdraw_success"];
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HYHeight(35), HYHeight(35)));
            make.left.equalTo(self).offset(WScale * 15);
        }];
        
        CGFloat width = [HYStyle getWidthWithTitle:LS(@"Liquidation_Finish") font:15];
        UILabel *statusLbl = [UILabel createLbl:LS(@"Liquidation_Finish") fontSize:15 textColor:[UIColor colorWithHexString:@"#e99316"] fatherView:self];
        [statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width+5, HScale*18));
            make.left.equalTo(logoImage.mas_right).offset(WScale*15);
            make.top.equalTo(self).offset(HScale*18);
        }];
        
        timeLbl = [UILabel createLbl:@"" fontSize:12 textColor:[UIColor bFourColor] fatherView:self];
        [self addSubview:timeLbl];
        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(statusLbl.mas_left);
            make.top.equalTo(statusLbl.mas_bottom).offset(HScale*10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(HScale*15);
        }];
        
        moneyLbl = [UILabel createRightLbl:@"" fontSize:18 textColor:[UIColor sixFourColor] fatherView:self];
        [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(WScale*-15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.top.equalTo(self);
            make.left.equalTo(timeLbl.mas_right).offset(WScale*8);
        }];
        
        UIImageView *lineImage =[HYStyle createImage:@""];
        lineImage.image= [HYStyle imageWithColor:[UIColor eOneColor] size:CGSizeMake(1.0, 1.0)];
        [self addSubview:lineImage];
        [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setModel:(HYSettleListModel *)model
{
    if (model)
    {
        CGFloat width = [HYStyle getWidthWithTitle:model.createTime font:12];
        [timeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
        }];
        timeLbl.text = model.createTime;
        moneyLbl.text = [NSString stringWithFormat:@"＋%@",model.amount];
    }
    _model = model;
}
- (void)cellAction:(UIViewController *)vc
{
    HYLiquidationDetailViewController *lVC = [[HYLiquidationDetailViewController alloc]init];
    lVC.settleModel = _model;
    [vc pushAction:lVC];
}

@end
