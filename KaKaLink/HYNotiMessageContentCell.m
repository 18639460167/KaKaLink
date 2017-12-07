//
//  HYNotiMessageContentCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/7.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYNotiMessageContentCell.h"
@interface HYNotiMessageContentCell()
{
    UILabel *messageLbl;
}
@end

@implementation HYNotiMessageContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        messageLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor nineSixColor] fatherView:self];
        messageLbl.numberOfLines = 0;
        [messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(WScale*25);
            make.top.equalTo(self).offset(HScale*12.5);
        }];
        UIView *lineView = [HYStyle createView:[UIColor colorWithHexString:@"#f0f0f0"]];
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

- (void)bindData:(NSString *)data
{
    messageLbl.text = data;
}

@end
