//
//  HYCardHeardView.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardHeardView.h"

@implementation HYCardHeardButton

+ (instancetype)createHeardBtn:(NSString *)title imageName:(NSString *)imageName fatherView:(UIView *)fatherView
{
    HYCardHeardButton *button = [[HYCardHeardButton alloc]initWithFrame:CGRectZero title:title imageName:imageName];
    if (fatherView)
    {
        [fatherView addSubview:button];
    }
    return button;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *logoImage = [HYStyle createImage:imageName];
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(HScale*16, HScale*20));
            make.top.equalTo(self);
        }];
        
        UILabel *titleLbl = [UILabel createCenterLbl:title fontSize:10 textColor:[UIColor sixFourColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.mas_equalTo(logoImage.mas_bottom);
        }];
    }
    return self;
}

@end

@interface HYCardHeardView ()
{
    HYCardHeardButton *rightBtn;
    HYCardHeardButton *leftBtn;
}

@end

@implementation HYCardHeardView

+ (instancetype)createCardView:(UIViewController *)currentVC isOpen:(BOOL)isOpen
{
    HYCardHeardView *headerView = [[HYCardHeardView alloc]initWithFrame:CGRectZero cardView:currentVC isOpen:isOpen];
    UIView *navView = [HYStyle createView:[UIColor fSixColor]];
    
    if (currentVC)
    {
        [currentVC.view addSubview:navView];
        [navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(currentVC.view);
            make.top.equalTo(currentVC.view);
            make.height.mas_equalTo(NAV_HEIGT);
        }];
        [navView addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(navView);
            make.top.equalTo(navView).offset(20);
        }];
    }
    return headerView;
}

- (instancetype)initWithFrame:(CGRect)frame cardView:(UIViewController *)currentVC isOpen:(BOOL)isOpen
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor fSixColor];
        
        
        CGFloat width = WScale*5 + [HYStyle getWidthWithTitle:LS(@"Vertify_Record") font:10];
        CGFloat leftWidth = WScale *5 +  [HYStyle getWidthWithTitle:LS(@"Card_Liquidation_Record") font:10];
        
        rightBtn = [HYCardHeardButton createHeardBtn:LS(@"Vertify_Record") imageName:@"card_qs" fatherView:self];
        [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (currentVC)
            {
                [currentVC pushAction:[HYVertifyRecordViewController new]];
            }
        }];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(HScale *25 +WScale*10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.equalTo(self).offset(WScale*-10);
        }];
        
        leftBtn = [HYCardHeardButton createHeardBtn:LS(@"Card_Liquidation_Record") imageName:@"card_hs" fatherView:self];
        [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (currentVC)
            {
                [currentVC pushAction:[HYSettleListViewController new]];
            }
        }];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(leftWidth);
            make.height.mas_equalTo(HScale *25 +WScale*10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(WScale*10);
        }];
                
        CGFloat distance = leftWidth>width ? leftWidth : width;
        UILabel *titleLbl = [UILabel createCenterLbl:LS(@"Card_Verification") fontSize:18 textColor:[UIColor threeTwoColor] fatherView:self];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.right.equalTo(self).offset(-(distance+WScale*10));
        }];
        
    }
    return self;
}

- (void)reloadData:(BOOL)isOpen
{
    leftBtn.hidden = !isOpen;
    rightBtn.hidden = !isOpen;
}

@end



#pragma mark - 输入卡券
@interface HYInputNumberView()
{
    UIViewController *currentVC;
    UITextField *inputNumberTxt;
}
@end

@implementation HYInputNumberView

+ (void)createInputView:(HYSuperViewController *)currentVC
{
    HYInputNumberView *inutView = [[HYInputNumberView alloc]initWithFrame:CGRectZero currentVC:currentVC];
    if (currentVC)
    {
        [currentVC.view addSubview:inutView];
        [inutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(currentVC.view);
            make.top.equalTo(currentVC.navBarView.mas_bottom).offset(HScale*70);
            make.height.mas_equalTo(HScale*125);
        }];
    }
}

- (instancetype)initWithFrame:(CGRect)frame currentVC:(UIViewController *)vc
{
    if (self = [super initWithFrame:frame])
    {
        currentVC = vc;
        
        UIView *bgView = [UIView createView:WHITE_COLOR superView:self];
        bgView.layer.borderWidth = 0.5;
        bgView.layer.borderColor = [UIColor bFourColor].CGColor;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.equalTo(self).offset(WScale*25);
            make.height.mas_equalTo(HScale*50);
            make.top.equalTo(self);
        }];
        inputNumberTxt = [UITextField createTxt:LS(@"Input_Card_Number") font:16 textColor:[UIColor threeTwoColor] delegate:self];
        inputNumberTxt.returnKeyType = UIReturnKeySearch;
        inputNumberTxt.keyboardType = UIKeyboardTypeNumberPad;
        [bgView addSubview:inputNumberTxt];
        [inputNumberTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(bgView);
            make.left.equalTo(bgView).offset(WScale*8);
            make.centerX.mas_equalTo(bgView.mas_centerX);
        }];
        
        [inputNumberTxt becomeFirstResponder];
        
        HYWeakSelf;
        UIButton *searchBtn = [UIButton createBgImageBtn:LS(@"Vertify") font:18 bgColor:@"kq_inter" height:HScale*50 btnAction:^{
            HYStrongSelf;
            [sSelf loadData];
        }];
        [self addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(HScale*200, HScale*50));
            make.top.equalTo(bgView.mas_bottom).offset(HScale*25);
        }];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self loadData];
    return YES;
}

- (void)loadData
{
    if ([inputNumberTxt.text isEqualToString:@""])
    {
        return;
    }
    else if (inputNumberTxt.text.length != 20)
    {
        [UIAlertView HYAlertTitle:[NSString stringWithFormat:@"%@%@ %@",LS(@"Card_Number"),inputNumberTxt.text,LS(@"Not_Find")] alertAction:nil];
    }
    else
    {
        [HYProgressHUD showLoading:@"" rootView:currentVC.view];
        [HYCardVertifyViewModel cardVerification:inputNumberTxt.text withComplete:^(id model, NSString *status) {
            [HYProgressHUD hideLoading:currentVC.view];
            if ([status isEqualToString:REQUEST_SUCCESS])
            {
                HYVertifyDetailViewController *vc = [[HYVertifyDetailViewController alloc]init];
                vc.hyOrderID = ((HYCardVertifyModel *)model).hyOrderID;
                [currentVC pushAction:vc];
            }
            else
            {
                [HYProgressHUD handlerDataError:status currentVC:currentVC handler:^{
                    [self loadData];
                }];
            }
        }];
    }
}
@end


@implementation HYNoCardvertifyView

+ (instancetype)createNoCardVertify:(HYSuperViewController *)vc
{
    HYNoCardvertifyView *view = [[HYNoCardvertifyView alloc]initWithFrame:CGRectZero currentVC:vc];
    if (vc)
    {
        [vc.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(vc.view);
            make.top.mas_equalTo(vc.view).offset(NAV_HEIGT);
        }];
    }
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame currentVC:(UIViewController *)vc
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor fSixColor];
        
        UIImageView *logoImage = [HYStyle createImage:@"tuikuan"];
        [self addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(HScale*35, HScale*35));
            make.top.equalTo(self).offset(HScale*170);
        }];
        
        UILabel *alertLbl = [UILabel createCenterLbl:LS(@"Not_Open_Card") fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self];
        alertLbl.numberOfLines = 0;
        CGFloat height = [HYStyle getHeightByWidth:SCREEN_WIDTH-WScale*70 title:alertLbl.text font:15];
        [alertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.equalTo(logoImage.mas_bottom).offset(HScale*20);
            make.height.mas_equalTo(height);
            make.left.equalTo(self).offset(WScale*35);
        }];
    }
    return self;
}

@end
