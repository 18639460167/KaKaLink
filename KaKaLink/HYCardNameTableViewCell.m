//
//  HYCardNameTableViewCell.m
//  KaKaLink
//
//  Created by 张帅 on 2017/11/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardNameTableViewCell.h"

@implementation HYCardNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(WScale *15);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(20);
        }];
        
        UIImageView *arrorImage = [HYStyle createImage:@"good_detail"];
        [self addSubview:arrorImage];
        [arrorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScale*8, HScale*15));
            make.right.equalTo(self).offset(WScale*-15);
        }];
        
        self.nameLbl = [UILabel createRightLbl:@"" fontSize:15 textColor:[UIColor subjectColor] fatherView:self];
        [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.titleLbl.mas_right).offset(HYWidth(8));
            make.right.equalTo(arrorImage.mas_left).offset(HYWidth(-8));
        }];
        
        [UIView createLineView:WScale*15 superView:self];
    }
    return self;
}

- (void)bindName:(NSString *)title goodName:(NSString *)name
{
    self.titleLbl.text = title;
    self.nameLbl.text = name;
    CGFloat width = [HYStyle getWidthWithTitle:title font:15];
    [self.titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(width);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
