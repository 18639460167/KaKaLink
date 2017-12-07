//
//  HYOrderStatusCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYOrderStatusCell.h"

@implementation HYOrderStatusCell

@synthesize titleLbl;
@synthesize statusLbl;
@synthesize settleLbl;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        statusLbl = [UILabel createCenterLbl:@"" fontSize:10 textColor:[UIColor sixFourColor] fatherView:self];
        statusLbl.adjustsFontSizeToFitWidth = YES;
        statusLbl.layer.borderWidth = 1;
        statusLbl.layer.cornerRadius = WScale*4;
        [statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.equalTo(self).offset(-WScale*15);
            make.height.mas_equalTo(HScale*20);
            make.width.mas_equalTo(WScale*40);
        }];
        
        settleLbl = [UILabel createCenterLbl:@"" fontSize:10 textColor:[UIColor sixFourColor] fatherView:self];
        settleLbl.adjustsFontSizeToFitWidth = YES;
        settleLbl.layer.borderWidth = 1;
        settleLbl.layer.cornerRadius = WScale*4;
        settleLbl.hidden = YES;
        [settleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(HScale*20);
            make.right.equalTo(statusLbl.mas_left).offset(-WScale*6);
        }];
        titleLbl = [UILabel createLbl:LS(@"Trading_Status") fontSize:15 textColor:[UIColor sixFourColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(WScale*15);
            make.right.equalTo(self).offset(-WScale*100);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor fZeroColor]];
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

- (void)bindModel:(HYTransModel *)model
{
    settleLbl.hidden = YES;
    switch (model.finishStatus)
    {
        case HYFinishStatus_Success:
        {
            settleLbl.hidden = NO;
            if (model.settleStatus == HYSettleStatus_Success)
            {
                settleLbl.layer.borderColor = [UIColor colorWithHexString:@"#e99316"].CGColor;
                settleLbl.textColor = [UIColor colorWithHexString:@"#e99316"];
                settleLbl.text = LS(@"Settle_Finish");
            }
            else
            {
                settleLbl.layer.borderColor = [UIColor colorWithHexString:@"#fd655b"].CGColor;
                settleLbl.textColor = [UIColor colorWithHexString:@"#fd655b"];
                settleLbl.text = LS(@"Settlf_Fail");
            }
            statusLbl.layer.borderColor = [UIColor colorWithHexString:@"#e99316"].CGColor;
            statusLbl.textColor = [UIColor colorWithHexString:@"#e99316"];
            statusLbl.text = LS(@"Done");
        }
            break;
        case HYFinishStatus_Progress:
        {
            statusLbl.layer.borderColor = [UIColor colorWithHexString:@"#fd655b"].CGColor;
            statusLbl.textColor = [UIColor colorWithHexString:@"#fd655b"];
            statusLbl.text = LS(@"Procress");
            [settleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        }
            break;
        case HYFinishStatus_RefundEd:
        {
            statusLbl.text = LS(@"Refunded");
            statusLbl.layer.borderColor = [UIColor subjectColor].CGColor;
            statusLbl.textColor = [UIColor subjectColor];
            [settleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
        }
            break;
            
        default:
            break;
    }
    CGFloat width = [HYStyle getWidthWithTitle:statusLbl.text font:10]+5;
    if (width<WScale*40)
    {
        width = WScale*40;
    }
    else
    {
        width = width+WScale*4;
    }
    [statusLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    if (settleLbl.hidden == NO)
    {
        CGFloat sWidth = [HYStyle getWidthWithTitle:settleLbl.text font:10]+5;
        if (sWidth<WScale*40)
        {
            sWidth = WScale*40;
        }
        else
        {
            sWidth = sWidth+WScale*4;
        }
        width = width+sWidth+WScale*6;
        [settleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(sWidth);
        }];
    }
   [titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self).offset(-(WScale*24+width));
   }];

}

@end
