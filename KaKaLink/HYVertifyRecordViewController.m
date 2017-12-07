//
//  HYVertifyRecordViewController.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYVertifyRecordViewController.h"

@interface HYVertifyRecordViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, strong) HYCardVertifyViewModel *viewModel;
@property (nonatomic, strong) HYCardTableHeaderView *headerView;
@end

@implementation HYVertifyRecordViewController
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI
{
    self.view.backgroundColor = [UIColor fZeroColor];
    self.viewModel = [[HYCardVertifyViewModel alloc]init];
    CGFloat width = [HYStyle getWidthWithTitle:LS(@"Filter") font:10];
    if (width<WScale*35)
    {
        width = WScale*35;
    }
    HYSelectBtn *sxBtn = [HYSelectBtn buttonFrame:CGRectMake(0, 0, width, WScale*35) title:LS(@"Filter") logoName:@"sx"];
    HYWeakSelf;
    [[sxBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        HYStrongSelf;
        [HYCardFilterView createFilterView:sSelf.viewModel.couponType complete:^(id value) {
            sSelf.viewModel.couponType = value;
            [sSelf loadData];
        }];
    }];
    [self LoadNavigation:sxBtn navStyle:HYNavitionStyle_Normal title:LS(@"Vertify_Record") didBackAction:nil];
    
    self.headerView = [HYCardTableHeaderView createHederView:@"已核销" textColor:[UIColor colorWithHexString:@"#ff001f"] fatherView:self.view];
    [self.headerView reloadData:self.viewModel];
    
    tableview = [UITableView createTableWithEmple:UITableViewStylePlain fatherView:self];
    [tableview setTableleHeardViewAction:@selector(loadData) target:self];
    [tableview setTableviewFootAction:@selector(loadMore) target:self];
    tableview.rowHeight = HScale*80;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
}

- (void)loadData
{
    [HYProgressHUD showLoading:@"" rootView:self.view];
    HYWeakSelf;
    [self.viewModel loadNewList:^(id value) {
        HYStrongSelf;
        [tableview.mj_header endRefreshing];
        sSelf.modelArray = sSelf.viewModel.vertifyModelArray;
        [sSelf.headerView reloadData:sSelf.viewModel];
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
    [self.viewModel loadMore:^(id value) {
        HYStrongSelf;
        [tableview.mj_footer endRefreshing];
        sSelf.modelArray = sSelf.viewModel.vertifyModelArray;
        [sSelf.headerView reloadData:sSelf.viewModel];
        [tableview reloadData];
//        if ([value isEqualToString:REQUEST_SUCCESS])
//        {
//            sSelf.modelArray = sSelf.viewModel.vertifyModelArray;
//            [sSelf.headerView reloadData:sSelf.viewModel];
//            [tableview reloadData];
//        }
        [HYProgressHUD handlerDataError:value currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}

#pragma mark -tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYCardRecordCell *cell = [HYCardRecordCell createCell:tableView];
    [cell bindData:self.modelArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYVertifyDetailViewController *vc = [[HYVertifyDetailViewController alloc]init];
    HYCardVertifyModel *model = self.modelArray[indexPath.row];
    vc.hyOrderID = model.hyOrderID;
  //  vc.vertifyModel = self.modelArray[indexPath.row];
    [self pushAction:vc];
}

#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(self.viewModel.isRequestFail)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.viewModel.isRequestFail)
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
