//
//  HYOrderDetailsCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYOrderDetailsCell.h"

@implementation HYOrderDetailsCell
@synthesize titleLbl;
@synthesize messageLbl;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        titleLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor sixFourColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.width.mas_equalTo(WScale*100);
        }];
        messageLbl = [UILabel createRightLbl:@"" fontSize:15 textColor:[UIColor sixFourColor] fatherView:self];
        [messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(titleLbl.mas_right).offset(WScale*8);
            make.right.equalTo(self).offset(WScale*-15);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor colorWithHexString:@"#f0f0f0"]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.equalTo(self).offset(WScale *20);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)bindData:(NSString *)title message:(NSString *)message
{
    titleLbl.font = FONTSIZE(15);
    messageLbl.font = FONTSIZE(15);
    titleLbl.text = title;
    messageLbl.text = message;
    CGFloat width = [HYStyle getWidthWithTitle:title font:15];
    
    [titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.mas_equalTo(width);
    }];
}


@end
