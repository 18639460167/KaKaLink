//
//  HYCardVerifyTableViewCell.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardVerifyTableViewCell.h"

@implementation HYCardVerifyTableViewCell
@synthesize messageLbl;
@synthesize titleLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        titleLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(WScale*15);
            make.width.mas_equalTo(WScale*80);
        }];
        
        messageLbl = [UILabel createRightLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(WScale*-15);
            make.left.equalTo(titleLbl.mas_right).offset(WScale*-8);
        }];
        
        [UIView createLineView:15 superView:self];
    }
    return self;
}

- (void)bindData:(NSString *)title message:(NSString *)message
{
    titleLbl.text = title;
    messageLbl.text = message;
    CGFloat width = [HYStyle getWidthWithTitle:title font:15];
    [titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(width);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
