//
//  HYSearchView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/4.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSearchView.h"
#import "DefineHeard.h"

@interface HYSearchView ()
{
    UIImageView *searcImage;
    UILabel *placeLbl;
}

@end
@implementation HYSearchView
@synthesize textFiled;
@synthesize cannelButton;
@synthesize scanButton;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        cannelButton = [UIButton buttonWithType:0];
        [cannelButton setBtnTitle:LS(@"Cancel") sizeFont:WScale*15 sizeColor:[UIColor colorWithHexString:@"#00aee5"] action:nil];
        cannelButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:cannelButton];
        [cannelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.right.equalTo(self).offset(WScale*-6);
            make.bottom.equalTo(self);
            CGFloat width = [HYStyle getWidthWithTitle:LS(@"Cancel") font:15];
            if (width<WScale*45)
            {
                width = WScale*45;
            }
            make.width.mas_equalTo(width);
        }];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectZero];
        bgView.backgroundColor = [UIColor colorWithHexString:@"#e1e1e1"];
        bgView.layer.cornerRadius = HScale*19;
        bgView.layer.masksToBounds = YES;
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cannelButton.mas_left).offset(WScale*-5);
            make.left.equalTo(self).offset(WScale*25/2);
            make.centerY.mas_equalTo(cannelButton.mas_centerY);
            make.bottom.equalTo(self).offset(HScale*-6);
        }];
        
        scanButton = [UIButton buttonWithType:0];
        [scanButton setImage:IMAGE_NAME(@"scan") forState:0];
        [bgView addSubview:scanButton];
        [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgView.mas_centerY);
            make.right.right.equalTo(bgView).offset(HScale*-15);
            make.top.equalTo(bgView).offset(HScale*5);
            make.width.mas_equalTo(scanButton.mas_height).multipliedBy(1.0);
        }];
        searcImage = [HYStyle createImage:@"check_search"];
        searcImage.frame = CGRectMake(WScale*60, HScale*9, WScale*20, HScale*20);
        [bgView addSubview:searcImage];
        [searcImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(WScale*20,HScale*20));
            make.left.equalTo(bgView).offset(HScale*12);
        }];
        
        textFiled = [[UITextField alloc]initWithFrame:CGRectZero];
        textFiled.textColor = [UIColor threeTwoColor];
        textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFiled.returnKeyType = UIReturnKeySearch;
        textFiled.placeholder = LS(@"Input_Order_Number");
        textFiled.font = FONTSIZE(15);
        textFiled.tintColor = [[UIColor threeTwoColor] colorWithAlphaComponent:0.9];
        // textFiled.tintColor = [[UIColor whiteColor]colorWithAlphaComponent:0.69];
        [bgView addSubview:textFiled];
        [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(bgView);
            make.left.equalTo(searcImage.mas_right).offset(WScale*5);
            //            make.left.equalTo(bgView).offset(WScale*13+HScale*20);
            make.right.equalTo(scanButton.mas_left).offset(WScale*-5);
        }];
        //        HYWeakSelf;
        //        UIButton *actionBtn = [UIButton buttonWithType:0];
        //        [[actionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //            [wSelf beginediting];
        //        }];
        //        [bgView addSubview:actionBtn];
        //        [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.bottom.equalTo(bgView);
        //            make.left.equalTo(bgView).offset(WScale*13+HScale*20);
        //            make.right.equalTo(scanButton.mas_left).offset(WScale*-5);
        //        }];
    }
    return self;
}




@end
