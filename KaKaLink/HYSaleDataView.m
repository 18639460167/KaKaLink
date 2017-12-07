//
//  HYSaleDataView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSaleDataView.h"

@implementation HYSaleDataView
@synthesize dataLbl;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createDataView:(UIViewController *)currentVC
{
    HYSaleDataView *view = [[HYSaleDataView alloc]initWithFrame:CGRectZero currentVC:currentVC];
    [currentVC.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currentVC.view).offset(-20);
        make.left.right.equalTo(currentVC.view);
        make.height.mas_equalTo(HScale*480);
    }];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame currentVC:(UIViewController *)vc
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *bgImage = [UIImageView new];
        bgImage.image = IMAGE_NAME(@"sale_bg");
        bgImage.userInteractionEnabled = YES;
        [self addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(self);
        }];
        
        UIImageView *circleImage = [UIImageView new];
        circleImage.image = IMAGE_NAME(@"sale_circle");
        circleImage.userInteractionEnabled = YES;
        [bgImage addSubview:circleImage];
        [circleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgImage.mas_centerX);
            make.top.equalTo(bgImage).offset(20+HScale*39);
            make.size.mas_equalTo(CGSizeMake(HScale*550/2, HScale*550/2));
        }];
        
        UIButton *dataBtn = [UIButton buttonWithType:0];
        [dataBtn setImage:IMAGE_NAME(@"sale_data") forState:0];
        [[dataBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [vc pushAction:[HYCurrentMonthViewController new]];
        }];
        [circleImage addSubview:dataBtn];
        [dataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(WScale*35, HScale*30));
            make.top.equalTo(circleImage).mas_equalTo(HScale*46);
            make.right.equalTo(circleImage).mas_equalTo(HScale*-15);
        }];
        
        UILabel *currentLbl = [UILabel createCenterLbl:LS(@"Current_Balance") fontSize:18 textColor:[UIColor threeTwoColor] fatherView:circleImage];
        [currentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(circleImage.mas_centerX);
            make.top.equalTo(circleImage).offset(HScale*95);
            make.left.equalTo(circleImage);
            make.height.mas_equalTo(WScale*19);
        }];
        
        dataLbl = [[HYCountingLable alloc] initWithFrame:CGRectZero];
        dataLbl.textAlignment = NSTextAlignmentCenter;
        dataLbl.font = FONTSIZE(30);
        dataLbl.textColor = [UIColor threeTwoColor];
        [circleImage addSubview:dataLbl];
        [dataLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(circleImage.mas_centerX);
            make.top.equalTo(currentLbl.mas_bottom).offset(HScale*17);
            make.left.equalTo(circleImage);
            make.height.mas_equalTo(HScale*69/2);
        }];
        dataLbl.unit = READ_SHOP_SIGN;
        //设置格式
        dataLbl.format = @"%.0f";
        //设置分隔符样式
        dataLbl.positiveFormat = @"###,##0";
        //设置变化范围及动画时间
//        NSString * str = READ_ACCOUNT_BALANCE;
        [dataLbl countForm:0 to:0 withDuration:0];
        CGFloat width = [HYStyle getWidthWithTitle:LS(@"Liquidation_Record") font:18]+HScale*15;
        if (width < WScale * 310/2)
        {
            width = WScale * 310/2;
        }
        UIButton *withdrawButton = [UIButton createBgImageBtn:LS(@"Liquidation_Record") font:18 bgColor:@"withdraw_bg" height:HScale*50 btnAction:^{
             [vc pushAction:[HYLiquidationRecordViewController new]];
        }];
        [bgImage addSubview:withdrawButton];
        [withdrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgImage.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(width, HScale*50));
            make.top.equalTo(circleImage.mas_bottom).offset(HScale*20);
        }];
        
    }
    return self;
}

@end
