//
//  HYUserViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYUserViewController.h"
#import "HYUserView.h"
#import "HYShopMessage.h"
#import "HYLoginViewModel.h"

@interface HYUserViewController ()
{
    HYUserView *phoneView;
    HYUserView *emailView;
}

@end

@implementation HYUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI
{
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Personal_Information") didBackAction:nil];
    phoneView = [[HYUserView alloc]initWithFrame:CGRectZero];
    [phoneView bindData:LS(@"Phone_Number")];
    phoneView.messsageLbl.text = READ_USER_PHONE;
    [self.view addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(HScale*50);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
    
    emailView = [[HYUserView alloc]initWithFrame:CGRectZero];
    [emailView bindData:LS(@"Email")];
    emailView.messsageLbl.text = READ_USER_EMAIL;
    [self.view addSubview:emailView];
    [emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(phoneView.mas_bottom);
        make.height.mas_equalTo(HScale*50);
    }];
    
    UIButton *logoutBtn = [UIButton createBgImageBtn:LS(@"Exit_Account") font:16 bgColor:@"save_bg" height:HYHeight(45) btnAction:^{
        [HYProgressHUD showLoading:@"" rootView:self.view];
        [HYLoginViewModel userLogoutWithCompleteBlock:^(NSString *status) {
            if ([status isEqualToString:SHOP_NO_LOGIN])
            {
                emailView.messsageLbl.text = @"";
                phoneView.messsageLbl.text = @"";
            }
            [HYProgressHUD handlerDataError:status currentVC:self handler:^{
                emailView.messsageLbl.text = READ_USER_EMAIL;
                phoneView.messsageLbl.text = READ_USER_PHONE;
            }];
        }];
    }];
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(WScale*25);
        make.height.mas_equalTo(HScale*45);
        make.bottom.equalTo(self.view).offset(HScale*-25);
    }];
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
