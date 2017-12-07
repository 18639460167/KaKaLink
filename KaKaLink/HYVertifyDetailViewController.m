//
//  HYVertifyDetailViewController.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYVertifyDetailViewController.h"

@interface HYVertifyDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) CGFloat isRequestFail;
@property (nonatomic, strong) HYCardVertifyModel *vertifyModel;

@end

@implementation HYVertifyDetailViewController
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI
{
    [self loadHaveLeftBtn:NO navStyle:HYNavitionStyle_Normal title:LS(@"Vertify_Record_Detail") didBackAction:nil];
    
    tableview = [UITableView createTableWithEmple:UITableViewStylePlain fatherView:self];
    tableview.rowHeight = HScale*50;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
    [self setTablefoot];
}

- (void)loadData
{
    [HYProgressHUD showLoading:@"" rootView:self.view];
    HYWeakSelf;
    [HYCardVertifyViewModel verificationDetail:self.hyOrderID withComplete:^(id model, NSString *status) {
        HYStrongSelf;
        if ([status isEqualToString:REQUEST_SUCCESS])
        {
            sSelf.isRequestFail = NO;
        }
        else
        {
            sSelf.isRequestFail = YES;
        }
        sSelf.vertifyModel = model;
        [tableview reloadData];
        [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}

- (void)setTablefoot
{
    UIView *footView = [UIView createView:[UIColor clearColor] superView:nil];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 115);
    
    UIButton *actionBtn = [UIButton createBgImageBtn:LS(@"Determine") font:15 bgColor:@"kq_inter" height:HScale*40 btnAction:^{
        [self popAction];
    }];
    [footView addSubview:actionBtn];
    [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(HScale*150, HScale*40));
        make.bottom.equalTo(footView);
    }];
    tableview.tableFooterView = footView;
}

#pragma mark -tableview datasource delegae
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vertifyModel.vertifyTitleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.vertifyModel.vertifyTitleArray[indexPath.row];
    if ([title isEqualToString:LS(@"Good_Name")])
    {
        HYCardNameTableViewCell *cell = [HYCardNameTableViewCell createCell:tableView];
        [cell bindName:title goodName:self.vertifyModel.vertifyMessageArray[indexPath.row]];
        return cell;
    }
    else
    {
        HYCardVerifyTableViewCell *cell = [HYCardVerifyTableViewCell createCell:tableview];
        [cell bindData:title message:self.vertifyModel.vertifyMessageArray[indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.vertifyModel.vertifyTitleArray[indexPath.row];
    if ([title isEqualToString:LS(@"Good_Name")])
    {
        HYGoodsDetailViewController *vc = [[HYGoodsDetailViewController alloc]init];
        vc.otaPid = self.vertifyModel.otaPid;
        vc.goodsName = self.vertifyModel.title;
        vc.otaPackageID = self.vertifyModel.otaPackageID;
        [self pushAction:vc];
    }
}

#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(self.isRequestFail)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.isRequestFail)
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
