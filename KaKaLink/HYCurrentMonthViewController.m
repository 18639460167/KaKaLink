//
//  HYCurrentMonthViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCurrentMonthViewController.h"
#import "HYSaleMonthViewModel.h"
#import "HYCheckShopView.h"
#import "MyLineView.h"
#import "HYSelectShopView.h"
#import "HYCurrentMonthCell.h"

@interface HYCurrentMonthViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
{
    MyLineView *lineView;
    
    UITableView *tableview;
    NSArray *monthDateArray;
    NSArray *modleArray;
    NSMutableArray *numberArray;
    NSString *shopMid;
    
    HYCheckShopView *shopView;
    BOOL isRequestFaild;
}



@end

@implementation HYCurrentMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self LoadData];
}

- (void)setUpUI
{

    
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Current_Month_Balance") didBackAction:nil];
    
    shopMid = @"0";
    numberArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    monthDateArray = [HYStyle dateTimeArray];
    HYWeakSelf;
    HYStrongSelf;
    shopView = [[HYCheckShopView alloc]initWithFrame:CGRectZero];
    [shopView reloadDataShopList];
    [[shopView.clickBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [HYSelectShopView createViewInY:(69+HScale*43.5) arrowImage:shopView.arrorImage  handler:^(NSString *title, NSString *mid) {
            shopView.shopNameLbl.text = title;
            shopMid = mid;
            [sSelf LoadData];
        }];
    }];
    [self.view addSubview:shopView];
    [shopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
        make.height.mas_equalTo(HScale*123/2);
    }];
    lineView = [MyLineView createView:monthDateArray action:^(NSArray *dateArray) {
        monthDateArray = dateArray;
        [sSelf LoadData];
    }];
    [lineView reloadData:numberArray];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(HScale*464/2+HScale*15);
        make.top.equalTo(shopView.mas_bottom);
    }];
    

    tableview = [UITableView createTableWithEmple:UITableViewStylePlain fatherView:self];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(lineView.mas_bottom).offset(HScale*10);
    }];
}
- (void)LoadData
{
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [HYSaleMonthViewModel getMonthData:monthDateArray[0] endDate:[monthDateArray lastObject] shopMid:shopMid handler:^(NSString *status, NSArray *dataArray) {
        if ([status isEqualToString:REQUEST_SUCCESS])
        {
            [numberArray removeAllObjects];
            isRequestFaild = NO;
            modleArray = dataArray;
            for (HYSaleMonthModel *model in dataArray)
            {
                
                [numberArray addObject:model.sale];
            }
        }
        else
        {
            lineView.isSuccess(NO);
            isRequestFaild = YES;
            numberArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
            modleArray = [NSArray new];
        }
        [lineView reloadData:numberArray];
        [tableview reloadData];
        [HYProgressHUD handlerDataError:status currentVC:self handler:^{
            [shopView reloadDataShopList];
            shopMid = @"0";
            [self LoadData];
        }];
    }];
}

#pragma mark - tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return modleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale*63;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYCurrentMonthCell *cell = [HYCurrentMonthCell createCell:tableview];
    [cell bindData:modleArray[indexPath.row]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [HYProgressHUD hideLoading:self.view];
}
#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(isRequestFaild)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (isRequestFaild)
    {
        [self LoadData];
    }
}


@end

