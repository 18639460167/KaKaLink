//
//  HYCheckActionView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/9.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCheckActionView.h"

@interface HYCheckActionView()
{
    HYConditionView *payTimeView;
    NSString *payTime;
    NSString *payWay;
    
    HYCheckClickView *clickView;
}

@property (nonatomic, strong) HYTransViewModel *transModel;

@end
@implementation HYCheckActionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)createView:(BDHomeViewController *)vc transModel:(HYTransViewModel *)model
{
    CGFloat height = -20;
    if (IS_IPHONEX)
    {
        height = 0;
    }
    HYCheckActionView *view = [[HYCheckActionView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, HScale*125+25) reateView:vc transModel:model];
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame reateView:(BDHomeViewController *)vc transModel:(HYTransViewModel *)model
{
    if (self = [super initWithFrame:frame])
    {
        self.transModel = model;
        HYWeakSelf;
        HYStrongSelf;
        self.backgroundColor = [UIColor whiteColor];
        clickView= [[HYCheckClickView alloc]initWithFrame:CGRectZero];
        clickView.selectShopModel = ^(NSString *title,NSString *mid){
            if (sSelf.actionSelectShop)
            {
                if ([title isEqualToString:LS(@"All")])
                {
                    mid = @"0";
                }
                vc.doneModel.mID = mid;
                vc.progressModel.mID = mid;
                vc.refundModel.mID = mid;
                sSelf.actionSelectShop(title,mid);
            }
        };
        [clickView loadDataShopList];
        [self addSubview:clickView];
        [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.equalTo(self).offset(40+HScale*2);
            make.height.mas_equalTo(HScale *40);
            make.left.equalTo(self).offset(12.5*WScale);
        }];
        payTimeView = [[HYConditionView alloc]initWithFrame:CGRectZero];
        [payTimeView changeMessage:payTime];
        [self addSubview:payTimeView];
        [payTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (SCREEN_HEIGHT==480)
            {
                make.bottom.equalTo(self.mas_bottom).offset(-HScale*6.5);
            }
            else
            {
                make.bottom.equalTo(self.mas_bottom).offset(-HScale*12.5);
            }
            make.left.equalTo(self).offset(WScale*15);
            make.size.mas_equalTo(CGSizeMake(WScale*40, WScale*43));
        }];
        
        HYSelectBtn *sxBtn = [HYSelectBtn buttonFrame:CGRectZero title:LS(@"Filter") logoName:@"sx"];
        [[sxBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            HYStrongSelf;
            [HYFilterActionView createFilterView:vc timeID:vc.doneModel.period  payID:vc.doneModel.channel complate:^(NSString *payID, NSString *timeID) {
                [payTimeView changeMessage:timeID];
                if (sSelf.actionHandler)
                {
                    vc.doneModel.period = timeID;
                    vc.doneModel.channel = payID;
                    vc.progressModel.period = timeID;
                    vc.progressModel.channel = payID;
                    vc.refundModel.period = timeID;
                    vc.refundModel.channel = timeID;
                    
                    sSelf.actionHandler(payID,timeID);
                }
            }];
        }];
        [self addSubview:sxBtn];
        [sxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-WScale*20);
            make.bottom.equalTo(self).offset(-HScale*10.5);
            CGFloat width = [HYStyle getWidthWithTitle:LS(@"Filter") font:10];
            if (width<WScale*35)
            {
                width = WScale*35;
            }
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(WScale*35);
        }];
        HYSelectBtn *searchBtn = [HYSelectBtn buttonFrame:CGRectZero title:LS(@"Search") logoName:@"search"];
        [[searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [vc presentSearchView];
        }];
        [self addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(sxBtn.mas_left).offset(-WScale*8);
            CGFloat width = [HYStyle getWidthWithTitle:LS(@"Search") font:10];
            if (width<WScale*35)
            {
                width = WScale*35;
            }
            make.width.mas_equalTo(width);
            make.bottom.equalTo(self).offset(-HScale*10.5);
            make.height.mas_equalTo(WScale*35);
        }];
    }
    return self;
}

- (void)reloadShopList
{
    [clickView loadDataShopList];
    [payTimeView changeMessage:self.transModel.period];
}
@end
