//
//  HYFilterCollectionViewCell.m
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYFilterCollectionViewCell.h"

@implementation HYFilterCollectionViewCell
@synthesize centerView;
@synthesize logoImage;
@synthesize titleLbl;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.cornerRadius = WScale*4;
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
        
        centerView = [HYStyle createView:[UIColor clearColor]];
        [self addSubview:centerView];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(WScale*110);
        }];
        
        logoImage = [HYStyle createImage:@""];
        [centerView addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView);
            make.centerY.mas_equalTo(centerView.mas_centerY);
            make.width.mas_equalTo(HScale*20);
            make.height.mas_equalTo(HScale*20);
        }];
        
        titleLbl = [UILabel createCenterLbl:@"" fontSize:13 textColor:[UIColor threeTwoColor] fatherView:centerView];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView).offset(WScale*5+HScale*20);
            make.right.equalTo(centerView);
            make.top.bottom.equalTo(centerView);
        }];
    }
    return self;
}

- (void)bindMessageModel:(HYMessageModel *)model isOne:(BOOL)isFirst
{
    if (isFirst)
    {
        if (![model.icon_url isEqualToString:@""]) {
            [logoImage sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:[UIImage imageNamed:@"pay_place"] options:SDWebImageAllowInvalidSSLCertificates];
        }
    }
    else
    {
        if (![model.icon_url isEqualToString:@""])
        {
            logoImage.image = IMAGE_NAME(model.icon_url);
        }
       
    }
    titleLbl.text = model.title;
    if (model.isSelect)
    {
        self.layer.borderColor = [UIColor subjectColor].CGColor;
    }
    else
    {
        self.layer.borderColor = [UIColor colorWithHexString:@"#f0f0f0"].CGColor;
    }
    CGFloat titleWidth = [HYStyle getWidthWithTitle:model.title font:13];
    if ([model.icon_url isEqualToString:@""])
    {
        if (titleWidth > WScale*110)
        {
            titleWidth = WScale*110;
        }
        [centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(titleWidth);
        }];
        [logoImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView);
        }];
    }
    else
    {
        titleWidth = titleWidth+HScale*20+WScale*5;
        if (titleWidth > WScale*110)
        {
            titleWidth = WScale*110;
        }
        [centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(titleWidth);
        }];
        [logoImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(HScale*20);
        }];
        [titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView).offset(HScale*20+WScale*5);
        }];
    }
}

@end
