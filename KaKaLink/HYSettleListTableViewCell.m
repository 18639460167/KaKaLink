//
//  HYSettleListTableViewCell.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSettleListTableViewCell.h"

@implementation HYSettleListTableViewCell
@synthesize numberLbl;
@synthesize timeLbl;
@synthesize moneyLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImageView *arrorImage = [HYStyle createImage:@"settle_arror"];
        [self addSubview:arrorImage];
        [arrorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScale*8, HScale*15));
            make.right.equalTo(self).offset(WScale*-15);
        }];
        
        CGFloat width = [HYStyle getWidthWithTitle:@"2017-08-2300" font:15];
        timeLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor bFourColor] fatherView:self];
        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(WScale*15);
            make.width.mas_equalTo(width);
        }];
        
        width = (SCREEN_WIDTH-width-WScale*30-HScale*15-WScale*24)/2;
        
        numberLbl = [UILabel createCenterLbl:@"" fontSize:15 textColor:[UIColor colorWithHexString:@"#e99316"] fatherView:self];
        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(width);
            make.left.equalTo(timeLbl.mas_right).offset(WScale*8);
        }];
        
        moneyLbl = [UILabel createCenterLbl:@"" fontSize:15 textColor:[UIColor colorWithHexString:@"#e99316"] fatherView:self];
        [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(arrorImage.mas_left).offset(WScale*-8);
            make.left.equalTo(numberLbl.mas_right).offset(WScale*8);
        }];
        
        [UIView createLineView:WScale*15 superView:self];
    }
    return self;
}

- (void)bindModel:(id)model
{
    HYCardSettleBatchModel *batchModel = (HYCardSettleBatchModel *)model;
    NSArray *array = [batchModel.createtime componentsSeparatedByString:@" "];
    if (array.count>0)
    {
        timeLbl.text = array[0];
    }
    numberLbl.text = batchModel.totalCount;
    moneyLbl.text =  MONEY_ADD_UNIT(batchModel.totalamount);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
