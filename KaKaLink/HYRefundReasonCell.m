//
//  HYRefundReasonCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYRefundReasonCell.h"
@interface HYRefundReasonCell()
{
    UIImageView *logoImage;
    UILabel *reasonLbl;
}
@end

@implementation HYRefundReasonCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        logoImage = [[UIImageView alloc]initWithFrame:CGRectZero];
//        logoImage.image = IMAGE_NAME(@"check_reason");
        logoImage.layer.cornerRadius = HScale*15/2;
        logoImage.layer.borderWidth = 0.5;
        logoImage.layer.borderColor = [UIColor eOneColor].CGColor;
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(HScale*15, HScale*15));
            make.left.equalTo(self).offset(WScale*25);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        reasonLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor sixFourColor] fatherView:self];
        [reasonLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.left.equalTo(logoImage.mas_right).offset(WScale*5);
        }];
    }
    return self;
}

- (void)bindData:(NSNumber *)isSel reason:(NSString *)reason
{
    reasonLbl.text = reason;
    if ([isSel boolValue])
    {
        logoImage.backgroundColor = [UIColor subjectColor];
    }
    else
    {
        logoImage.backgroundColor = [UIColor fZeroColor];
    }
}

@end
