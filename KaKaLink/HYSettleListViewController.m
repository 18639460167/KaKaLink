//
//  HYSettleListViewController.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSettleListViewController.h"

@interface HYSettleListViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, strong) HYCardSettleViewModel *viewModel;

@end

@implementation HYSettleListViewController
@synthesize tableview;
@synthesize viewModel;
@synthesize modelArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI
{
    viewModel = [[HYCardSettleViewModel alloc]init];
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Card_Liquidation_Record") didBackAction:nil];
    
    tableview = [UITableView createTableWithEmple:UITableViewStylePlain fatherView:self];
    tableview.rowHeight = HScale*60;
    [tableview setTableleHeardViewAction:@selector(loadData) target:self];
    [tableview setTableviewFootAction:@selector(loadMore) target:self];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
}


- (void)loadData
{
    [HYProgressHUD showLoading:@"" rootView:self.view];
    HYWeakSelf;
    [viewModel loadNewList:^(id value) {
        HYStrongSelf;
        [tableview.mj_header endRefreshing];
        modelArray = viewModel.settleModelArray;
        [tableview reloadData];
        [HYProgressHUD handlerDataError:value currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}

- (void)loadMore
{
    [HYProgressHUD showLoading:@"" rootView:self.view];
    HYWeakSelf;
    [viewModel loadMore:^(id value) {
        HYStrongSelf;
        [tableview.mj_footer endRefreshing];
        if ([value isEqualToString:REQUEST_SUCCESS])
        {
            modelArray = viewModel.settleModelArray;
            [tableview reloadData];
        }
        [HYProgressHUD handlerDataError:value currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}


#pragma mark - tableview delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYSettleListTableViewCell *cell = [HYSettleListTableViewCell createCell:tableview];
    [cell bindModel:modelArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    HYSettleRecordViewController *vc = [[HYSettleRecordViewController alloc]init];
    vc.batchModel = modelArray[indexPath.row];
    [self pushAction:vc];
}

#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(viewModel.isRequestFail)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (viewModel.isRequestFail)
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
