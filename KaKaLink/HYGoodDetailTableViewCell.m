//
//  HYGoodDetailTableViewCell.m
//  KaKaLink
//
//  Created by 张帅 on 2017/11/13.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYGoodDetailTableViewCell.h"

@implementation HYGoodDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.numberLbl = [UILabel createRightLbl:@"" fontSize:15 textColor:[UIColor colorWithHexString:@"#e99316"] fatherView:self];
        [self.numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(HYWidth(-20));
            make.width.mas_equalTo(20);
        }];
        self.nameLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor colorWithHexString:@"#e99316"] fatherView:self];
        [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(HYWidth(20));
            make.right.equalTo(self.numberLbl.mas_left).offset(HYWidth(-8));
        }];
    }
    return self;
}

- (void)bindData:(HYGoodDetailModel *)model indexRow:(NSInteger)row
{
    if (row == 0)
    {
        self.nameLbl.textColor = [UIColor eNineColor];
        self.numberLbl.textColor = [UIColor eNineColor];
        self.nameLbl.text = LS(@"Goods_Name");
        self.numberLbl.text = LS(@"Goods_Number");
        CGFloat width = [HYStyle getWidthWithTitle:self.numberLbl.text font:15];
        [self.numberLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
        }];
    }
    else
    {
        self.nameLbl.textColor = [UIColor threeTwoColor];
        self.numberLbl.textColor = [UIColor threeTwoColor];
        self.nameLbl.text = model.dishName;
        self.numberLbl.text = model.dishCount;
        [self.numberLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(model.numberWidth);
        }];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
