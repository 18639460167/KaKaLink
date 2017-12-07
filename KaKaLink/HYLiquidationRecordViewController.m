//
//  HYLiquidationRecordViewController.m
//  TourGuidShop
//
//  Created by Black on 17/6/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYLiquidationRecordViewController.h"

@interface HYLiquidationRecordViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, strong) HYSettleListViewModel *settleModel;

@end

@implementation HYLiquidationRecordViewController
@synthesize tableview;
@synthesize modelArray;
@synthesize settleModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI
{
    settleModel = [[HYSettleListViewModel alloc]init];
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Liquidation_Record") didBackAction:nil];
    
    tableview = [UITableView createTableWithEmple:UITableViewStylePlain fatherView:self];
    [tableview setTableleHeardViewAction:@selector(loadData) target:self];
    [tableview setTableviewFootAction:@selector(loadMore) target:self];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
}

- (void)loadData
{
    HYWeakSelf;
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [settleModel loadNewSettleList:^(id value) {
        HYStrongSelf;
        [tableview.mj_header endRefreshing];
        modelArray = settleModel.settleArray;
        [tableview reloadData];
        [HYProgressHUD handlerDataError:value currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}

- (void)loadMore
{
    HYWeakSelf;
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [settleModel loadMoreSettleList:^(id value) {
        HYStrongSelf;
        [tableview.mj_footer endRefreshing];
        if ([value isEqualToString:REQUEST_SUCCESS])
        {
            modelArray = settleModel.settleArray;
            [tableview reloadData];
        }
        [HYProgressHUD handlerDataError:value currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}

#pragma mark - tableview datasource delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale *72;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYLiquidationRecordCell *cell = [HYLiquidationRecordCell createCell:tableView];
    cell.model = self.modelArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    HYLiquidationRecordCell *cell = (HYLiquidationRecordCell *)[tableview cellForRowAtIndexPath:indexPath];
    [cell cellAction:self];
}

#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(settleModel.requestFail)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (settleModel.requestFail)
    {
        [self loadData];
    }
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
