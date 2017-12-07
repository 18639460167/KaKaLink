//
//  HYSetTeadePassViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSetTeadePassViewController.h"

#import "HYUserViewModel.h"

@interface HYSetTeadePassViewController ()
{
    UITextField *passText;
    UITextField *confirmText;
}

@end

@implementation HYSetTeadePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAction)];
    [self.view addGestureRecognizer:tap];
    UILabel *myLable = [UILabel createLbl:LS(@"Setting_Six_Pass") fontSize:15 textColor:[UIColor sixFourColor] fatherView:self.view];
    [myLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WScale*25);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(HScale*21+NAV_HEIGT);
        make.height.mas_equalTo(HScale*50);
    }];
    
    passText = [[UITextField alloc]initWithFrame:CGRectZero];
    passText.placeholder = LS(@"Input_Six_Number");
    passText.keyboardType = UIKeyboardTypeNumberPad;
    passText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passText.font = FONTSIZE(15);
    [passText controlLength:6];
    [passText setSecureTextEntry:YES];
    [self.view addSubview:passText];
    [passText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WScale*25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(myLable.mas_bottom).offset(HScale*12);
        make.height.mas_equalTo(HScale*20);
    }];
    
    UIView *oneLinew = [HYStyle createView:[UIColor sixFourColor]];
    [self.view addSubview:oneLinew];
    [oneLinew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(WScale*25);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(passText.mas_bottom).offset(HScale*3);
    }];
    
    confirmText = [[UITextField alloc]initWithFrame:CGRectZero];
    confirmText.placeholder = LS(@"Enter_Here");
    confirmText.keyboardType = UIKeyboardTypeNumberPad;
    confirmText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [confirmText controlLength:6];
    [confirmText setSecureTextEntry:YES];
    confirmText.font = FONTSIZE(15);
    [self.view addSubview:confirmText];
    [confirmText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WScale*25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(oneLinew.mas_bottom).offset(HScale*20);
        make.height.mas_equalTo(HScale*20);
    }];
    
    UIView *twoLinew = [HYStyle createView:[UIColor sixFourColor]];
    [self.view addSubview:twoLinew];
    [twoLinew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(WScale*25);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(confirmText.mas_bottom).offset(HScale*3);
    }];
    
    UILabel *alertLbl = [UILabel createLbl:LS(@"Alert_Set_Pass") fontSize:12 textColor:[UIColor subjectColor] fatherView:self.view];
    [alertLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(WScale*25);
        make.height.mas_equalTo(WScale*14);
        make.top.equalTo(twoLinew.mas_bottom).offset(HScale*40);
    }];
    
    HYWeakSelf;
    UIButton *button = [UIButton buttonWithType:0];
    [button setLayerBtn:LS(@"Determine") fontName:GB1_0 sizeFont:15 sizeColor:WHITE_COLOR backColor:[UIColor subjectColor]];
    [button racIsEnable:passText textLength:6 passTxt:confirmText passLength:6 backColor:[UIColor subjectColor]];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        HYStrongSelf;
        [sSelf hideAction];
        if ([passText.text isEqualToString:confirmText.text])
        {
            [HYProgressHUD showLoading:@"" rootView:sSelf.view];
            [HYUserViewModel setTransPass:confirmText.text handler:^(NSString *status) {
                [HYProgressHUD hideLoading:sSelf.view];
                if ([status isEqualToString:REQUEST_SUCCESS])
                {
                    SET_USER_DEFAULT(confirmText.text,SHOP_TRANS_PASS);
                    SYN_USER_DEFAULT;
                    [HYProgressHUD showLoading:LS(@"Setting_Success") currentView:sSelf.view handler:^{
                         [sSelf.navigationController popViewControllerAnimated:YES];
                    }];
                }
                else
                {
                    [HYProgressHUD handlerDataError:status currentVC:sSelf handler:nil];
                }
            }];
        }
        else
        {
            [HYStyle showAlert:LS(@"Two_Pass_Inconsistent")];
        }
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(WScale*12);
        make.height.mas_equalTo(HScale*45);
        make.top.equalTo(alertLbl.mas_bottom).offset(HScale*20);
    }];
}
- (void)hideAction
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
