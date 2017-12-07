//
//  HYSaleDateView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSaleDateView.h"


@implementation HYSaleDateView
@synthesize firstLbl;
@synthesize twoLbl;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createDateView:(UIViewController *)vc
{
    HYSaleDateView *view = [[HYSaleDateView alloc]initWithFrame:CGRectZero createDateView:vc];
    [vc.view addSubview:view];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame createDateView:(UIViewController *)vc
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *logoImage = [HYStyle createImage:@"sale_date"];
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(WScale*20, HScale*17));
            make.top.equalTo(self);
        }];
        UILabel *titleLbl = [UILabel createCenterLbl:LS(@"Query_By_Date") fontSize:12 textColor:[UIColor bFourColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(logoImage.mas_bottom).offset(HScale*2);
            make.height.mas_equalTo(HScale*13);
        }];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *str = [formatter stringFromDate:date];
        
        
        UIView *oneView = [HYStyle createView:WHITE_COLOR];
        [self addSubview:oneView];
        [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLbl.mas_bottom).offset(HScale*11);
            make.height.mas_equalTo(HScale*30);
            make.left.equalTo(self).offset(WScale*34);
            make.width.mas_equalTo(WScale*252/2);
        }];
        
        UIImageView *oneImage = [HYStyle createImage:@"sale_arror"];
        [oneView addSubview:oneImage];
        [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneView).offset(-WScale*3);
           // make.centerY.mas_equalTo(oneView.mas_centerY);
            make.bottom.equalTo(oneView).offset(HScale*-1);
            make.size.mas_equalTo(CGSizeMake(WScale*8, HScale*19));
        }];
        
        firstLbl = [UILabel createCenterLbl:str fontSize:18 textColor:[UIColor bFourColor] fatherView:oneView];
        [firstLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(oneView);
            make.height.mas_equalTo(HScale*21);
            make.left.equalTo(oneImage.mas_right);
        }];
        
        UIButton *oneBtn = [UIButton buttonWithType:0];
        [[oneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [HYDatePickView showDatePicker:^(NSString *chooseDate) {
                firstLbl.text = chooseDate;
            }];
        }];
        [oneView addSubview:oneBtn];
        [oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(oneView);
        }];
        
        UIView *oneLine = [HYStyle createView:[UIColor bFourColor]];
        [self addSubview:oneLine];
        [oneLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneView.mas_bottom).offset(3);
            make.height.mas_equalTo(0.5);
            make.left.equalTo(self).offset(WScale*34);
            make.width.mas_equalTo(WScale*252/2);
        }];
        

        
        UIView *twoViw = [HYStyle createView:WHITE_COLOR];
        [self addSubview:twoViw];
        [twoViw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLbl.mas_bottom).offset(HScale*11);
            make.height.mas_equalTo(HScale*30);
            make.right.equalTo(self).offset(-WScale*34);
            make.width.mas_equalTo(WScale*252/2);
        }];
        
        UIImageView *twoImage = [HYStyle createImage:@"sale_arror"];
        [twoViw addSubview:twoImage];
        [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(twoViw).offset(WScale*3);
            make.bottom.equalTo(twoViw).offset(HScale*-1);
            make.size.mas_equalTo(CGSizeMake(WScale*8, HScale*19));
        }];
        
        twoLbl = [UILabel createCenterLbl:str fontSize:18 textColor:[UIColor bFourColor] fatherView:twoViw];
        [twoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(twoViw);
            make.height.mas_equalTo(HScale*21);
            make.right.equalTo(twoImage.mas_left);
        }];
        
        UIButton *twoBtn = [UIButton buttonWithType:0];
        [[twoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [HYDatePickView showDatePicker:^(NSString *chooseDate) {
                twoLbl.text = chooseDate;
            }];
        }];
        [twoViw addSubview:twoBtn];
        [twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(twoViw);
        }];
        
        
        UIView *twoLinw = [HYStyle createView:[UIColor bFourColor]];
        [self addSubview:twoLinw];
        [twoLinw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoViw.mas_bottom).offset(2);
            make.height.mas_equalTo(0.5);
            make.right.equalTo(self).offset(WScale*-34);
            make.width.mas_equalTo(WScale*252/2);
        }];
        
        
        CGFloat width = [HYStyle getWidthWithTitle:LS(@"Query") font:16]+HScale*15;
        if (width < WScale * HScale*90)
        {
            width = WScale * HScale*90;
        }
        UIButton *queryBtn = [UIButton createBgImageBtn:LS(@"Query") font:16 bgColor:@"query_bg" height:HScale*31 btnAction:^{
            [HYStyle compareDate:firstLbl.text endDate:twoLbl.text handler:^(NSString *status) {
                NSString *startTime = firstLbl.text;
                NSString *endTime = twoLbl.text;
                if ([status isEqualToString:@"exchange"])
                {
                    startTime = twoLbl.text;
                    endTime = firstLbl.text;
                }
                HYSaleQueryViewController *svc = [[HYSaleQueryViewController alloc]init];
                svc.startTime = startTime;
                svc.endTime = endTime;
                [vc pushAction:svc];
            }];
        }];
        [self addSubview:queryBtn];
        [queryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(width, HScale*31));
            make.top.equalTo(oneLine.mas_bottom).offset(HScale*12);
        }];
        
    }
    return self;
}

@end
