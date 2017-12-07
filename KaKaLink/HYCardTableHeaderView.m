//
//  HYCardTableHeaderView.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardTableHeaderView.h"

@implementation HYCardTableHeaderView
@synthesize moneyLbl;
@synthesize numberLbl;

+ (instancetype)createHederView:(NSString *)title textColor:(UIColor *)textColor fatherView:(UIView *)fatherView
{
    HYCardTableHeaderView *headerView = [[HYCardTableHeaderView alloc]initWithFrame:CGRectMake(0, NAV_HEIGT, SCREEN_WIDTH, HScale*45) hederView:title textColor:textColor];
    [fatherView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fatherView);
        make.height.mas_offset(HScale*45);
        make.top.equalTo(fatherView).offset(NAV_HEIGT);
    }];
    return headerView;
}
- (instancetype)initWithFrame:(CGRect)frame hederView:(NSString *)title textColor:(UIColor *)textColor
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =[UIColor colorWithHexString:@"#f0f0f0"];
        
        UIView *titleView = [HYStyle createView:WHITE_COLOR];
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(HScale*25);
        }];
        
        CGFloat width = [HYStyle getWidthWithTitle:title font:12];
        UILabel *titleLbl = [UILabel createLbl:@"" fontSize:12 textColor:[UIColor sixFourColor] fatherView:titleView];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(titleView);
            make.left.equalTo(titleView).offset(WScale*15);
            make.width.mas_equalTo(width);
        }];
        width = [HYStyle getWidthWithTitle:@"" font:12];
        moneyLbl = [UILabel createRightLbl:@"" fontSize:12 textColor:textColor fatherView:titleView];
        [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(titleView);
            make.right.equalTo(titleView).offset(WScale*-15);
            make.width.mas_equalTo(width);
        }];

        NSString *message = [NSString stringWithFormat:@"%@，%@", LS(@"Pen"),LS(@"Total")];
        width = [HYStyle getWidthWithTitle:message font:12];
        UILabel *unitLbl =[UILabel createRightLbl:message fontSize:12 textColor:[UIColor sixFourColor] fatherView:titleView];
        [unitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(titleView);
            make.right.mas_equalTo(moneyLbl.mas_left);
            make.width.mas_equalTo(width);
        }];
       
        numberLbl =  [UILabel createCenterLbl:@"" fontSize:12 textColor:textColor fatherView:titleView];
        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(titleView);
            make.width.mas_equalTo(WScale*12);
            make.right.mas_equalTo(unitLbl.mas_left).offset(-2);
        }];
        
        message = LS(@"Liquidationed");
        if ([title isEqualToString:@"已核销"])
        {
            message = LS(@"Vertify");
        }
        UILabel *setLbl = [UILabel createRightLbl:message fontSize:12 textColor:[UIColor sixFourColor] fatherView:titleView];
        [setLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(titleView);
            make.right.mas_equalTo(numberLbl.mas_left);
            make.left.equalTo(titleLbl.mas_right).offset(2);
        }];
        
    }
    return self;
}

- (void)reloadData:(id)model
{
    if ([model isKindOfClass:[HYCardVertifyViewModel class]])
    {
        HYCardVertifyViewModel *mModel = (HYCardVertifyViewModel *)model;
        [self realodData:[NSString stringWithFormat:@"%ld",(long)mModel.total_count] totalAmount:mModel.totalAmount];
    }
    else if ([model isKindOfClass:[HYCardSettleBatchModel class]])
    {
        HYCardSettleBatchModel *batchModel = (HYCardSettleBatchModel *)model;
        if ([batchModel isRequestFail])
        {
            [self realodData:[NSString stringWithFormat:@"%ld",(long)batchModel.total_count] totalAmount:batchModel.totalAmount];
        }
        else
        {
            [self realodData:[NSString stringWithFormat:@"%@",batchModel.totalCount] totalAmount:batchModel.totalamount];
        }
        
    }
}

- (void)realodData:(NSString *)number totalAmount:(NSString *)amount
{
    CGFloat width = [HYStyle getWidthWithTitle:number font:12]+3;
    numberLbl.text = number;
    [numberLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(width);
    }];
    
    amount = MONEY_ADD_UNIT(amount);
    width = [HYStyle getWidthWithTitle:amount font:12];
    moneyLbl.text = amount;
    [moneyLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(width);
    }];
}

@end
