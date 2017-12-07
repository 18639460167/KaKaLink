//
//  HYSalesStatusViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSalesStatusViewController.h"
@interface HYSalesStatusViewController ()
{
    HYSaleDataView *dataView;
}

@end

@implementation HYSalesStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
}

- (void)setUpUI
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moneyChange) name:Notification_orderChange object:nil];
    
    dataView = [HYSaleDataView createDataView:self];
    
    HYSaleDateView *dateView = [HYSaleDateView createDateView:self];
    [dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(dataView.mas_bottom);
    }];
    
}
- (void)moneyChange
{
    [dataView.dataLbl countForm:0 to:0 withDuration:0];
}
- (void)loadData
{
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [HYSaleMonthViewModel getMOnthMoney:^(NSString *status) {
        [HYProgressHUD hideLoading:self.view];
        NSString *str = READ_ACCOUNT_BALANCE;
        dataView.dataLbl.unit = READ_SHOP_SIGN;
        if ([NSString handlerNumber:str] == 0)
        {
            dataView.dataLbl.format = @"%.0f";
            dataView.dataLbl.positiveFormat = @"###,##0";
        }
        else if ([NSString handlerNumber:str] == 1)
        {
            dataView.dataLbl.format = @"%.1f";
            dataView.dataLbl.positiveFormat = @"###,##0.0";
        }
        else
        {
            dataView.dataLbl.format = @"%.2f";
            dataView.dataLbl.positiveFormat = @"###,##0.00";
        }
        dataView.dataLbl.oldMoney = str;
        [dataView.dataLbl countForm:0 to:[str floatValue] withDuration:1.0f];
        [HYProgressHUD handlerDataError:status currentVC:self handler:^{
            [self loadData];
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HYProgressHUD hideLoading:self.view];
    [self loadData];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
