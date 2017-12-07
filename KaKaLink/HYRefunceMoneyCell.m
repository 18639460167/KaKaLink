//
//  HYRefunceMoneyCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYRefunceMoneyCell.h"

@implementation HYRefunceMoneyCell
@synthesize moneyLbl;

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
        moneyLbl  = [UILabel createRightLbl:@"" fontSize:18 textColor:[UIColor threeTwoColor] fatherView:self];
        [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(self).offset(-WScale*25);
        }];
        
        UIImageView *image = [UIImageView new];
        image.image = IMAGE_NAME(@"check_line");
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.mas_equalTo(1);
            make.left.equalTo(self).offset(WScale*25);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
    return self;
}

@end
