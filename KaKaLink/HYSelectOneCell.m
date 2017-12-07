//
//  HYSelectOneCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSelectOneCell.h"

@interface HYSelectOneCell()
{
    UILabel *titleLbl;
    UIImageView *logoImage;
}

@end

@implementation HYSelectOneCell

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
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(WScale*(200-8)-HScale*15);
            make.size.mas_equalTo(CGSizeMake(HScale*15, HScale*15));
        }];
        
        titleLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor sixFourColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(WScale*8);
            make.top.bottom.equalTo(self);
            make.right.equalTo(logoImage.mas_left).offset(-WScale*5);
        }];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectZero];
        lineView.backgroundColor = [UIColor fSixColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)bindData:(NSNumber *)isSelect title:(NSString *)title
{
    BOOL isSel = [isSelect boolValue];
    if (isSel)
    {
        logoImage.image = IMAGE_NAME(@"check_sel");
    }
    else
    {
        logoImage.image = IMAGE_NAME(@"check_unsel");
    }
    titleLbl.text = title;
}

- (void)bindModel:(HYCardTypeModel *)model
{
    if (model.isSelect)
    {
        logoImage.image = IMAGE_NAME(@"check_sel");
    }
    else
    {
         logoImage.image = IMAGE_NAME(@"check_unsel");
    }
    titleLbl.text = model.title;
}

@end
