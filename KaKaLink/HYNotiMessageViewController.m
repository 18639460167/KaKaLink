//
//  HYNotiMessageViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYNotiMessageViewController.h"
@interface HYNotiMessageViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) BOOL isAllRead;
@property (nonatomic, strong) NotifiMessageViewModel *messageViewModel;

@end

@implementation HYNotiMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self loadData];
}
- (void)setUpUI
{
    HYWeakSelf;
    HYStrongSelf;
    self.messageViewModel =[[NotifiMessageViewModel alloc]init];
    
    [self LoadNavigation:[HYStyle createRightBtn:LS(@"All_Read") action:^{
        if (sSelf.dataArray.count==0)
        {
            return ;
        }
        [HYProgressHUD showLoading:@"" rootView:self.view];
        [NotifiMessageViewModel handleMessage:@"0" handler:^(NSString *status) {
            [HYProgressHUD dismiss];
            if ([status isEqualToString:REQUEST_SUCCESS])
            {
                [PushNumberModel clearBageNumber];
                sSelf.isAllRead = YES;
                [sSelf.tableview reloadData];
            }
            [HYProgressHUD handlerDataError:status currentVC:self handler:nil];
        }];

    }] navStyle:HYNavitionStyle_Normal title:LS(@"Message") didBackAction:^{
        if (sSelf.isMessageFail)
        {
            UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
            UITabBarController *tabViewController = (UITabBarController *)window.rootViewController;
            [tabViewController setSelectedIndex:2];
            [sSelf.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [sSelf popAction];
        }
    }];
    
    self.tableview = [UITableView createTableWithEmple:UITableViewStylePlain fatherView:self];
    self.tableview.rowHeight = HYHeight(75);
    [self.tableview setTableleHeardViewAction:@selector(loadData) target:self];
    [self.tableview setTableviewFootAction:@selector(loadDataMore) target:self];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
}

#pragma mark - 加载数据
- (void)loadData
{
    HYWeakSelf;
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [self.messageViewModel loadNewList:^(NSString *status) {
        HYStrongSelf;
        [sSelf.tableview.mj_header endRefreshing];
        if ([status isEqualToString:REQUEST_SUCCESS])
        {
            sSelf.isAllRead = NO;
            sSelf.dataArray = sSelf.messageViewModel.messageArray;
        }
        [sSelf.tableview reloadData];
        [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
            [sSelf loadData];
        }];
    }];
}

- (void)loadDataMore
{
    HYWeakSelf;
        [HYProgressHUD showLoading:@"" rootView:self.view];
        [self.messageViewModel loadMore:^(NSString *status) {
            HYStrongSelf;
            [sSelf.tableview.mj_footer endRefreshing];
            if ([status isEqualToString:REQUEST_SUCCESS])
            {
                sSelf.isAllRead = NO;
                sSelf.dataArray = sSelf.messageViewModel.messageArray;
                [sSelf.tableview reloadData];
            }
            [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
                [sSelf loadData];
            }];
        }];
}
#pragma mark - tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYNotiMessageTableViewCell *cell = [HYNotiMessageTableViewCell registerCell:tableView bindData:self.dataArray[indexPath.row] isAllReady:self.isAllRead];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYNotiMessageTableViewCell *cell = (HYNotiMessageTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell cellAction:self messageModel:self.dataArray[indexPath.row]];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NotifiMessageModel *model = self.dataArray[indexPath.row];
        [HYProgressHUD showLoading:@"" rootView:self.view];
        [NotifiMessageViewModel pushDelete:model.messageID handler:^(NSString *status) {
            if ([status isEqualToString:REQUEST_SUCCESS])
            {
                if (!model.isRead)
                {
                    [PushNumberModel BageNumberDeauce];
                }
                [self.dataArray removeObjectAtIndex:indexPath.row];
                [tableView reloadData];
            }
            [HYProgressHUD handlerDataError:status currentVC:self handler:nil];
        }];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LS(@"Deleate");
}
#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(self.messageViewModel.isRequestFaild)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.messageViewModel.isRequestFaild)
    {
        [self loadData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isMessageFail)
    {
        [HYStyle setLeftBtnVC:self action:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
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
