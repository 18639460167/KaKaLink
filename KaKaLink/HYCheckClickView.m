//
//  HYCheckClickView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/4.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCheckClickView.h"

@interface HYCheckClickView()
{
    UIImageView *arrorImage;
}
@end
@implementation HYCheckClickView
@synthesize clickShopLbl;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self  = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        self.layer.cornerRadius = WScale*20;
        self.layer.masksToBounds = YES;
        
        arrorImage = [[UIImageView alloc]init];
        arrorImage.image = IMAGE_NAME(@"arrow");
        [self addSubview:arrorImage];
        [arrorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScale*12, HScale*12));
            make.left.equalTo(self).mas_equalTo(WScale*11);
        }];
        clickShopLbl = [UILabel createLbl:LS(@"Select_Shop") fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [clickShopLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(arrorImage.mas_right).offset(WScale*10);
            make.right.equalTo(self).offset(-WScale*10);
        }];
        HYWeakSelf;
        HYStrongSelf;
        UIButton *selectBtn = [UIButton buttonWithType:0];
        [[selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            CGFloat height = HScale*47+20;
            if (IS_IPHONEX)
            {
                height = HScale*47+44;
            }
            [HYSelectShopView createViewInY:height arrowImage:arrorImage handler:^(NSString *title, NSString *mid) {
                clickShopLbl.text = title;
                if (sSelf.selectShopModel)
                {
                    sSelf.selectShopModel(title,mid);
                }
            }];
        }];
        [self addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)loadDataShopList
{
    NSString *str = LS(@"Select_Shop");
    if([[HYShopMessage sharedModel] getShopListArray].count==1)
    {
        HYShopListModel *demol = [[HYShopMessage sharedModel] getShopListArray][0];
        str = demol.title;
    }
    clickShopLbl.text = str;
}
@end
