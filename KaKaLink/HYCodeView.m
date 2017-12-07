//
//  HYCodeView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/31.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCodeView.h"

@implementation HYCodeView
@synthesize bgImage;
@synthesize coedImage;
@synthesize titleLbl;
@synthesize numberLbl;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        bgImage = [HYStyle createImage:@""];
        bgImage.backgroundColor = WHITE_COLOR;
        bgImage.userInteractionEnabled = YES;
        bgImage.layer.borderWidth = 0.5;
        bgImage.layer.borderColor = [UIColor sixFourColor].CGColor;
        [self addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
        titleLbl = [UILabel createCenterLbl:@"" fontSize:18 textColor:[UIColor threeTwoColor] fatherView:bgImage];
        titleLbl.adjustsFontSizeToFitWidth = YES;
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(bgImage);
            make.top.equalTo(bgImage).offset(HScale*30);
            make.height.mas_equalTo(HScale*20);
        }];
        
        coedImage = [HYStyle createImage:@""];
        [bgImage addSubview:coedImage];
        [coedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgImage.mas_centerX);
            make.top.equalTo(titleLbl.mas_bottom).offset(HScale*47/2);
            make.size.mas_equalTo(CGSizeMake(HScale*340/2, HScale*340/2));
        }];
        
        numberLbl = [UILabel createRightLbl:@"" fontSize:14 textColor:[UIColor nineSixColor] fatherView:self];
        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self).offset(WScale*-8);
            make.bottom.equalTo(self).offset(HScale*-6);
            make.height.mas_equalTo(HScale*16);
        }];
    }
    return self;
}

- (void)bindModel:(HYShopListModel *)model
{
    titleLbl.text = model.title;
    [UIImage qrImageWithString:model.qrCode size:HScale*170 iconImage:IMAGE_NAME(@"qrcode_logo") completion:^(UIImage *image) {
        coedImage.image = image;
    }];
}

@end
