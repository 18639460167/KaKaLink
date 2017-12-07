//
//  HYOrderTableViewCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYOrderTableViewCell.h"
#import "HYShopMessage.h"

@implementation HYOrderTableViewCell
@synthesize logoImage;
@synthesize moneyLbl;
@synthesize monthLbl;
@synthesize hourceLbl;
@synthesize nameLbl;
@synthesize statusLbl;
@synthesize settleLbl;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}1
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        logoImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(WScale*35, WScale*35));
            make.left.equalTo(self).offset(WScale*24);
        }];
        
        nameLbl = [UILabel createLbl:@"" fontSize:15 textColor:BLACK_COLOR fatherView:self];
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(HScale *15);
            make.left.equalTo(logoImage.mas_right).offset(WScale *20);
            make.height.mas_equalTo(HScale*20);
            make.width.mas_equalTo(WScale*100);
        }];
        
        monthLbl = [UILabel createLbl:@"" fontSize:10 textColor:[UIColor nineSixColor] fatherView:self];
        [monthLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(logoImage.mas_right).offset(WScale *20);
            make.height.mas_equalTo(HScale*15);
            make.width.mas_equalTo(WScale*220/2);
            make.top.equalTo(nameLbl.mas_bottom).offset(HScale *8);
        }];
        
        moneyLbl = [UILabel createRightLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(monthLbl.mas_right).offset(WScale*15);
            make.height.mas_equalTo(HScale*40/2);
            make.bottom.mas_equalTo(monthLbl.mas_bottom);
            make.right.equalTo(self).offset(WScale*-24);
        }];
        
        statusLbl = [UILabel createCenterLbl:@"" fontSize:9 textColor:[UIColor colorWithHexString:@"#ff001f"] fatherView:self];
        statusLbl.layer.cornerRadius = WScale*4;
        statusLbl.layer.borderWidth = WScale*1;
        statusLbl.layer.borderColor = [UIColor colorWithHexString:@"#ff001f"].CGColor;
        statusLbl.adjustsFontSizeToFitWidth = YES;
        [statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WScale*44);
            make.height.mas_equalTo(HScale*15);
            make.centerY.mas_equalTo(nameLbl.mas_centerY);
            make.left.equalTo(nameLbl.mas_right).offset(WScale*5);
        }];
        
        settleLbl = [UILabel createCenterLbl:@"" fontSize:9 textColor:[UIColor colorWithHexString:@"#ff001f"] fatherView:self];
        settleLbl.layer.cornerRadius = WScale*4;
        settleLbl.layer.borderWidth = WScale*1;
        settleLbl.layer.borderColor = [UIColor colorWithHexString:@"#ff001f"].CGColor;
        settleLbl.hidden = YES;
        settleLbl.adjustsFontSizeToFitWidth = YES;
        [settleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(HScale*15);
            make.centerY.mas_equalTo(nameLbl.mas_centerY);
            make.left.equalTo(statusLbl.mas_right).offset(WScale*5);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor colorWithHexString:@"#f0f0f0"]];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setTransModel:(HYTransModel *)transModel
{
    if (transModel)
    {
        [self bindModel:transModel];
    }
    _transModel = transModel;
}

- (void)bindModel:(HYTransModel *)model
{
    self.nameLbl.text = model.trans_title;
    moneyLbl.text = [NSString stringWithFormat:@"%@ %@",READ_SHOP_SIGN,model.settle_amount];
    monthLbl.text = model.payTime;
    settleLbl.hidden = YES;
    [logoImage sd_setImageWithURL:[NSURL URLWithString:model.payment_channel_icon] placeholderImage:[UIImage imageNamed:@"pay_place"] options:SDWebImageAllowInvalidSSLCertificates];
    
    UIColor *textColor = [UIColor colorWithHexString:@"#e99316"];
    NSString *text = LS(@"Done");
    switch (model.finishStatus)
    {
        case HYFinishStatus_Success:
        {
            moneyLbl.textColor = BLACK_COLOR;
            moneyLbl.textColor = [UIColor threeTwoColor];
            settleLbl.hidden = NO;
            nameLbl.textColor  =BLACK_COLOR;
            if (model.settleStatus == HYSettleStatus_Success)
            {
                settleLbl.text = LS(@"Settle_Finish");
                settleLbl.textColor = [UIColor colorWithHexString:@"#e99316"];
                settleLbl.layer.borderColor = [UIColor colorWithHexString:@"#e99316"].CGColor;
                moneyLbl.textColor = [UIColor threeTwoColor];
                
            }
            else
            {
                settleLbl.text = LS(@"Settlf_Fail");
                settleLbl.textColor = [UIColor colorWithHexString:@"#fd655b"];
                   settleLbl.layer.borderColor = [UIColor colorWithHexString:@"#fd655b"].CGColor;
                moneyLbl.textColor = [UIColor colorWithHexString:@"#fd655b"];
            }
        }
            break;
        case HYFinishStatus_Progress:
        {
            moneyLbl.textColor = [UIColor nineSixColor];
            nameLbl.textColor = [UIColor nineSixColor];
            textColor = [UIColor colorWithHexString:@"#fd655b"];
            text = LS(@"Procress");
        }
            break;
        case HYFinishStatus_RefundEd:
        {
            moneyLbl.textColor = [UIColor nineSixColor];
            nameLbl.textColor = [UIColor nineSixColor];
            textColor = [UIColor colorWithHexString:@"#00aee5"];
            text = LS(@"Refunded");
        }
            break;
            
        default:
            break;
    }
    
    statusLbl.textColor  =textColor;
    statusLbl.layer.borderColor = textColor.CGColor;
    statusLbl.text = text;
    
    CGFloat staWidth = [HYStyle getWidthWithTitle:statusLbl.text font:9];
    if (staWidth < WScale *44)
    {
        staWidth = WScale*44;
    }
    else
    {
        staWidth = staWidth + WScale*5;
    }
    [statusLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(staWidth);
    }];
    
    if (settleLbl.hidden == NO)
    {
        CGFloat setWidth = [HYStyle getWidthWithTitle:settleLbl.text font:9];
        if (setWidth < WScale *44)
        {
            setWidth = WScale*44;
        }
        else
        {
            setWidth = setWidth + WScale*5;
        }
        staWidth += setWidth;
        [settleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(setWidth);
        }];
    }
    
    CGFloat titleWidth = [HYStyle getWidthWithTitle:nameLbl.text font:15];
    if (titleWidth>(SCREEN_WIDTH-WScale*105-staWidth)) {
        titleWidth = (SCREEN_WIDTH-WScale*105-staWidth);
    }
    [nameLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titleWidth);
    }];
}

- (void)cellAction:(UIViewController *)vc
{
    HYTransDerailViewController *dVC = [[HYTransDerailViewController alloc]init];
    dVC.transModel = _transModel;
    [vc pushAction:dVC];
}
@end
