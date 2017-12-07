//
//  HYSettleRecordViewController.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSettleRecordViewController.h"

@interface HYSettleRecordViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, strong) HYCardTableHeaderView *headerView;

@end

@implementation HYSettleRecordViewController
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI
{
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Card_Liquidation_Record") didBackAction:nil];
    
    self.view.backgroundColor = [UIColor fZeroColor];
    
    self.headerView = [HYCardTableHeaderView createHederView:LS(@"Settle_Finish") textColor:[UIColor colorWithHexString:@"#e99316"] fatherView:self.view];
    [self.headerView realodData:@"0" totalAmount:@"0"];
    
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
    [self.batchModel loadNewList:^(id value) {
        [tableview.mj_header endRefreshing];
        HYStrongSelf;
        sSelf.modelArray = sSelf.batchModel.settleModelArray;
        [sSelf.headerView reloadData:sSelf.batchModel];
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
    [self.batchModel loadMore:^(id value) {
        HYStrongSelf;
        [tableview.mj_footer endRefreshing];
        if ([value isEqualToString:REQUEST_SUCCESS])
        {
            sSelf.modelArray = sSelf.batchModel.settleModelArray;
            [sSelf.headerView reloadData:sSelf.batchModel];
            [tableview reloadData];
        }
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
    [cell bindData:_modelArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYSettleDetailViewController *vc = [[HYSettleDetailViewController alloc]init];
    vc.batchModel = _modelArray[indexPath.row];
    [self pushAction:vc];
}

#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(self.batchModel.isRequestFail)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.batchModel.isRequestFail)
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
