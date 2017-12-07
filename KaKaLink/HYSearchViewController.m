//
//  HYSearchViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSearchViewController.h"
#import "HYNotiMessageViewController.h"
#import "HYSendMessageView.h"
#import "HYSearchView.h"
#import "ScanQRViewController.h"


@interface HYSearchViewController ()<UITextFieldDelegate>
{
    HYSearchView *searchView;
    
}

@end

@implementation HYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    
}
- (void)setUpUI
{
    HYWeakSelf;
    
    self.view.backgroundColor = WHITE_COLOR;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAction)];
    [self.view addGestureRecognizer:tap];
    searchView = [[HYSearchView alloc]initWithFrame:CGRectZero];
    searchView.textFiled.delegate = self;
    [searchView.textFiled becomeFirstResponder];
    [[searchView.cannelButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        HYStrongSelf;
        [searchView.textFiled resignFirstResponder];
        [sSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [[searchView.scanButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        HYStrongSelf;
        [sSelf pushAction:[ScanQRViewController new]];
    }];
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(20+HScale*50);
        if (IS_IPHONEX)
        {
            make.top.equalTo(self.view).offset(10);
        }
        else
        {
            make.top.equalTo(self.view);
        }
    }];
    
    CGFloat height = [HYStyle getHeightByWidth:(SCREEN_WIDTH-WScale*79) title:LS(@"Alert_Input_Order_Number") font:11];
    if (height<HScale*13)
    {
        height = HScale*13;
    }
    UIImageView *curble = [HYStyle createImage:@"search_curble"];
    [self.view addSubview:curble];
    [curble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(WScale*25/2);
        make.right.equalTo(self.view).offset(WScale*-113/2);
        make.height.mas_equalTo(HScale*24+height);
        make.top.equalTo(searchView.mas_bottom).offset(HScale*3);
    }];
    
    UILabel *titleLbl = [UILabel createLbl:LS(@"Alert_Input_Order_Number") fontSize:11 textColor:[UIColor sixFourColor] fatherView:curble];
    if (height<=HScale*13)
    {
        titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    titleLbl.numberOfLines = 0;
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(curble).offset(WScale*5);
        make.centerX.mas_equalTo(curble.mas_centerX);
        make.bottom.equalTo(curble).offset(-HScale*16/2);
        make.height.mas_equalTo(height);
    }];
    
    
}



- (void)hideAction
{
    [searchView.textFiled resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        return NO;
    }
    [textField resignFirstResponder];
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [HYTransViewModel getTransDetail:textField.text handler:^(NSString *status, HYTransModel *model) {
        [HYProgressHUD hideLoading:self.view];
        if ([status isEqualToString:REQUEST_SUCCESS])
        {
            HYTransDerailViewController *vc = [[HYTransDerailViewController alloc]init];
            vc.transModel = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        [HYProgressHUD handlerDataError:status currentVC:self handler:nil];
    }];
    return YES;
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
