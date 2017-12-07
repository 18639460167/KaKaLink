//
//  HYLiquidationDetailViewController.m
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYLiquidationDetailViewController.h"

@interface HYLiquidationDetailViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) HYSettleDetailViewModel *viewModel;

@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation HYLiquidationDetailViewController
@synthesize modelArray;
@synthesize viewModel;
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI
{
    viewModel = [[HYSettleDetailViewModel alloc]init];
    viewModel.settlement_ID = self.settleModel.settlement_id;
    
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Liquidation_Detail") didBackAction:nil];
    
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
    [viewModel loadNewSettleList:^(id value) {
        [tableview.mj_header endRefreshing];
        HYStrongSelf;
        modelArray = viewModel.transArray;
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
    [viewModel loadMoreSettleList:^(id value) {
        HYStrongSelf;
        [tableview.mj_footer endRefreshing];
        if ([value isEqualToString:REQUEST_SUCCESS])
        {
            modelArray = viewModel.transArray;
            [tableview reloadData];
        }
        [HYProgressHUD handlerDataError:value currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    HYOrderTableViewCell *cell = (HYOrderTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell cellAction:self];
}

#pragma mark - tableview datasource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale*72;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYOrderTableViewCell *cell = [HYOrderTableViewCell createCell:tableview];
    cell.transModel = modelArray[indexPath.row];
    return cell;
}

#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
//    NSString *imageName = @"no_data";
//    if (viewModel.requestFail == NO)
//    {
//        imageName = @"no_netdork";
//    }
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(!viewModel.requestFail)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (viewModel.requestFail == NO)
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
