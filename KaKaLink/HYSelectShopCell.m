//
//  HYSelectShopCell.m
//  
//
//  Created by tenpastnine-ios-dev on 17/2/4.
//
//

#import "HYSelectShopCell.h"

@implementation HYSelectShopCell
@synthesize titleLbl;

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
        titleLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor sixFourColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(WScale*13/2);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectZero];
        lineView.backgroundColor = [UIColor eOneColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)bindData:(NSString *)title
{
    titleLbl.text = title;
}

@end
