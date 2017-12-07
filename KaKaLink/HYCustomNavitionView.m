//
//  HYCustomNavitionView.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCustomNavitionView.h"


@implementation HYCustomNavitionView

- (instancetype)init
{
    if (self = [super init])
    {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initView];
    }
    return self;
}
- (void)initView
{
    self.backgroundColor = [UIColor fSixColor];
    self.navBgView = [HYStyle createView:[UIColor clearColor]];
    [self addSubview:self.navBgView];
    [self.navBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(64);
    }];
}
- (void)setIsShowRight:(BOOL)isShowRight
{
    if (isShowRight)
    {
        CGFloat width = [HYStyle getWidthWithTitle:LS(@"BACK") font:16]+WScale*18;
        HYBackButton  *backButton = [HYBackButton button:CGRectZero];
        [backButton addTarget:self action:@selector(btnBackClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.navBgView addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.navBgView).offset(WScale*10);
            make.bottom.equalTo(self.navBgView);
            make.height.mas_equalTo(@44);
            make.width.mas_equalTo(width);
            
        }];
        
        if (_titleView)
        {
            [_titleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH-((WScale*15+width)*2));
            }];
        }
    }
    else
    {
        if (_titleView)
        {
            [_titleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH-WScale*20);
            }];
        }
        
    }
    _isShowRight = isShowRight;
}

- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    if (titleView)
    {
        [self.navBgView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.navBgView).offset(0);
            make.centerX.equalTo(self.navBgView.mas_centerX);
            make.width.mas_equalTo(SCREEN_WIDTH-160);
            make.height.mas_equalTo(44);
        }];
    }
    _titleView = titleView;
}

- (void)setLeftButton:(UIButton *)leftButton
{
    [_leftButton removeFromSuperview];
    if (leftButton)
    {
        [self.navBgView addSubview:leftButton];
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.navBgView).offset(WScale*-10);
            make.centerY.mas_equalTo(_titleView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(leftButton.frame.size.width, leftButton.frame.size.height));
        }];
        
        if (_isShowRight)
        {
            CGFloat width = [HYStyle getWidthWithTitle:LS(@"BACK") font:16]+WScale*18;
            
            if (leftButton.frame.size.width+WScale*10 > width)
            {
                [_titleView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(SCREEN_WIDTH-((leftButton.frame.size.width+WScale*10)*2));
                }];
            }
        }
        else
        {
            [_titleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(SCREEN_WIDTH-((leftButton.frame.size.width+WScale*10)*2));
            }];
        }
    }
    _leftButton = leftButton;
}

- (void)btnBackClicked
{
    if (_complete)
    {
        _complete();
    }
    else
    {
        if (self.currentVC)
        {
            [self.currentVC.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (instancetype)initWithframe:(CGRect)frame handler:(backAction)complete
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor fSixColor];
        CGFloat width = [HYStyle getWidthWithTitle:LS(@"BACK") font:16]+WScale*18;
        HYBackButton  *backButton = [HYBackButton button:CGRectZero];
        [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (complete)
            {
                complete();
            }
        }];
        [self addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(WScale*10);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(@44);
            make.width.mas_equalTo(width);
            
        }];
        
        UILabel *titleLbl = [UILabel createCenterLbl:LS(@"Online_Service") fontSize:18 textColor:[UIColor threeTwoColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.equalTo(backButton.mas_right).offset(WScale*5);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}
@end
