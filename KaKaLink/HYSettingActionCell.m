//
//  HYSettingActionCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSettingActionCell.h"
//#import "YWManager.h"
#import "HYUserHelpViewController.h"

@implementation HYSettingActionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        float width = (SCREEN_WIDTH-2)/3.0;
        
        NSArray *titArr = @[LS(@"Usual_Problems"),LS(@"User_Feedback"),LS(@"Helpline")];
        NSArray *imageArr = @[@"question",@"feedback",@"phone"];
        for (int i=0; i<3; i++)
        {
            UIView *bgView = [HYStyle createView:WHITE_COLOR];
            bgView.frame = CGRectMake((width+1)*i, 0, width, HScale*80);
            [self addSubview:bgView];
            
            UIImageView *twoImage = [UIImageView new];
            twoImage.image = IMAGE_NAME(imageArr[i]);
            [bgView addSubview:twoImage];
            [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(HScale*25, HScale*25));
                make.centerX.mas_equalTo(bgView.mas_centerX);
                make.top.equalTo(bgView).offset(HScale*15);
            }];
            UILabel *twoLbl = [UILabel createCenterLbl:titArr[i] fontSize:15 textColor:[UIColor sixFourColor] fatherView:bgView];
            [twoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(bgView.mas_centerX);
                make.top.equalTo(twoImage.mas_bottom).offset(HScale*7.5);
                make.right.equalTo(bgView).offset(WScale*-8);
                make.height.mas_equalTo(HScale*18);
            }];
            
            UIButton *button = [UIButton buttonWithType:0];
            button.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
            button.tag = i+1;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(bgView);
            }];
        }
    }
    return self;
}

- (void)buttonAction:(UIButton *)button
{
    if (self.currentVC)
    {
        switch (button.tag)
        {
            case 1:
            {
                [self.currentVC.navigationController pushViewController:[HYUserHelpViewController new] animated:YES];
            }
                break;
            case 2:
            {
               // [YWManager showYWConversationViewController:self.currentVC];
            }
                break;
            case 3:
            {
                [HYStyle HYTelPhone:self.currentVC.view];
            }
                break;
                
            default:
                break;
        }
    }
}
 

@end
