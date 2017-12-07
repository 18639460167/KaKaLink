//
//  HYGoodsDetailViewController.m
//  KaKaLink
//
//  Created by 张帅 on 2017/11/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYGoodsDetailViewController.h"

@interface HYGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) BOOL requestFail;
@property (nonatomic, strong)  HYGoodsListModel *goodsModel;

@end

@implementation HYGoodsDetailViewController
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI
{
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Good_Detail") didBackAction:nil];
    
    self.goodsModel = [HYGoodsListModel createWithDic:[NSDictionary new]];
    
    tableview = [UITableView createTableWithEmple:UITableViewStylePlain fatherView:self];
    tableview.rowHeight = HYHeight(50);
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.navBarView.mas_bottom);
    }];
}

- (void)loadData
{
    HYWeakSelf;
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [HYCardVertifyViewModel cardGoodsDetail:self.otaPid otaPackageID:self.otaPackageID  withComplete:^(id model, NSString *ststaue) {
        HYStrongSelf;
        if ([ststaue isEqualToString:REQUEST_SUCCESS])
        {
            sSelf.requestFail = NO;
            sSelf.goodsModel = model;
        }
        else
        {
            sSelf.requestFail = YES;
        }
        [sSelf.tableview reloadData];
        [sSelf.tableview goodsDetailTableviewHeard:sSelf.goodsModel.fooDishDetailDTOs.count name:sSelf.goodsName number:sSelf.goodsModel.goodsNumber];
        [HYProgressHUD handlerDataError:ststaue currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}

#pragma mark --tableview datasource delegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.requestFail || self.goodsModel.fooDishDetailDTOs.count == 0)
    {
        return 0;
    }
    else
    {
        return self.goodsModel.fooDishDetailDTOs.count + 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYGoodDetailTableViewCell *cell = [HYGoodDetailTableViewCell createCell:tableView];
    if (indexPath.row == 0)
    {
        [cell bindData:nil indexRow:indexPath.row];
    }
    else
    {
        [cell bindData:self.goodsModel.fooDishDetailDTOs[indexPath.row-1] indexRow:indexPath.row];
    }
    return cell;
}

#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(self.requestFail)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.requestFail)
    {
        [self loadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
