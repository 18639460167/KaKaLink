//
//  HYSaleQueryViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSaleQueryViewController.h"


@interface HYSaleQueryViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, copy) NSString *currentStatus;
@end

@implementation HYSaleQueryViewController
@synthesize dataArray;
@synthesize viewModel;
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI
{
    HYWeakSelf;
    self.view.backgroundColor = [UIColor sixFourColor];
    viewModel = [[HYSaleQueryViewModel alloc]init];
    
    CGFloat width = [HYStyle getWidthWithTitle:LS(@"Filter") font:10];
    if (width<WScale*35)
    {
        width = WScale*35;
    }
    HYSelectBtn *sxBtn = [HYSelectBtn buttonFrame:CGRectMake(0, 0, width, HScale*30) title:LS(@"Filter") logoName:@"sx"];
    [[sxBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        HYStrongSelf;
        [HYChooseStatusView createChooseStatusView:viewModel.settle_status handler:^(NSInteger status) {
            if (status == 0)
            {
                viewModel.settle_status = @"";
            }
            else
            {
                viewModel.settle_status = [NSString stringWithFormat:@"%d",(int)status-1];
            }
            [sSelf loadData];
        }];
    }];
    [self LoadNavigation:sxBtn navStyle:HYNavitionStyle_Normal title:LS(@"Query_Result") didBackAction:nil];
    
    UIButton *bottomBtn = [UIButton createSendEmailBtn:self];
    
    tableview = [UITableView createTableWithEmple:UITableViewStylePlain fatherView:self];
    [tableview setTableleHeardViewAction:@selector(loadData) target:self];
    [tableview setTableviewFootAction:@selector(loadMore) target:self];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
        make.bottom.equalTo(bottomBtn.mas_top);
    }];
}
- (void)loadData
{
    HYWeakSelf;
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [viewModel loadNewLostStart:self.startTime endTime:self.endTime handler:^(NSString *status) {
        HYStrongSelf;
        [tableview.mj_header endRefreshing];
        dataArray = viewModel.orderListArray;
        [tableview reloadData];
        [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}
- (void)loadMore
{
    HYWeakSelf;
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [viewModel loadMoreStart:self.startTime endTime:self.endTime handler:^(NSString *status) {
        HYStrongSelf;
        [tableview.mj_footer endRefreshing];
        if ([status isEqualToString:REQUEST_SUCCESS])
        {
            dataArray  = viewModel.orderListArray;
            [tableview reloadData];
        }
        [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}
#pragma mark- tableview datasource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale*80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYOrderTableViewCell *cell = [HYOrderTableViewCell createCell:tableview];
    cell.transModel = dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HYTransDerailViewController *vc = [[HYTransDerailViewController alloc]init];
    vc.transModel = dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
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
