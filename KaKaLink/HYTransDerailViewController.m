//
//  HYTransDerailViewController.m
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYTransDerailViewController.h"

@interface HYTransDerailViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UIButton *revokeBtn; // 退款按钮

@property (nonatomic, strong) UIButton *serviceBtn; // 客服电话

@end

@implementation HYTransDerailViewController
@synthesize tableview;
@synthesize revokeBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI
{
    self.view.backgroundColor = [UIColor fSixColor];
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Order_detail") didBackAction:nil];
    
    tableview = [UITableView createTableWithEmple:UITableViewStyleGrouped fatherView:self];
    tableview.backgroundColor = [WHITE_COLOR colorWithAlphaComponent:0];
    [tableview setTableleHeardViewAction:@selector(loadData) target:self];
    tableview.rowHeight = HScale*50;
    tableview.sectionFooterHeight = 0.01;
    tableview.sectionHeaderHeight = HYHeight(10);
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
}


- (void)loadData
{
    [HYProgressHUD showLoading:@"" rootView:self.view];
    [HYTransViewModel getTransDetail:self.transModel.trans_ID handler:^(NSString *status, HYTransModel *model) {
        [tableview.mj_header endRefreshing];
        if ([status isEqualToString:REQUEST_SUCCESS])
        {
            self.transModel = model;
            self.transModel.isRequesrtFail = YES;
            [self.transModel reloadTransMessageArray];
        }
        else
        {
            self.transModel.isRequesrtFail = NO;
        }
        [self reloadBottomView];
        [HYProgressHUD handlerDataError:status currentVC:self handler:^{
            [self loadData];
        }];
    }];
}

- (void)reloadBottomView
{
    self.tableview.tableFooterView = [UIView new];
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    [self.transModel reloadTransMessageArray];
    [self.revokeBtn removeFromSuperview];
    [self.serviceBtn removeFromSuperview];
    [self.tableview reloadData];
    if (self.transModel.isRequesrtFail == YES)
    {
        switch (self.transModel.finishStatus)
        {
            case HYFinishStatus_Success:
            {
                [self loadFinshBottomBtn];
            }
                break;
            case HYFinishStatus_RefundEd:
            {
                [self loadRefundedBottom];
            }
                break;
            case HYFinishStatus_Progress:
            {
                [self loadProgressBottom];
            }
                break;
                
            default:
                break;
        }

    }
}

#pragma mark -底部试图
- (void)loadFinshBottomBtn
{
    if (self.transModel.settleStatus == HYSettleStatus_Progress)
    {
        [self.revokeBtn removeFromSuperview];
        self.revokeBtn = nil;
        
        HYWeakSelf;
        UIView *view = [HYStyle createView:WHITE_COLOR];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale*50);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setAttributedTitle:[NSString getStr:LS(@"Refund") textColor:[UIColor subjectColor]]
                          forState:UIControlStateNormal];
        button.titleLabel.font = FONTSIZE(16);
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            HYStrongSelf;
            [HYAlertView alertShow:LS(@"Determine") cancelMessage:LS(@"Cancel") message:LS(@"Alert_Initiate_Refund") imageName:@"tuikuan" okOrange:NO messageIsOrange:NO handler:^{
                [HYProgressHUD showLoading:@"" rootView:sSelf.view];
                [HYUserViewModel checkTransPass:^(NSString *status) {
                    [HYProgressHUD hideLoading:sSelf.view];
                    if ([status isEqualToString:REQUEST_SUCCESS])
                    {
                        HYRefundReasonViewController *vc = [[HYRefundReasonViewController alloc]init];
                        vc.transModel = sSelf.transModel;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    else
                    {
                        if ([status isEqualToString:SHOP_TRADE_NO_PASS])
                        {
                            [HYAlertView alertShow:LS(@"Determine") cancelMessage:LS(@"Cancel") message:LS(@"No_Trans_Pass") imageName:@"tuikuan" okOrange:YES messageIsOrange:YES handler:^{
                                [sSelf pushAction:[HYSetTeadePassViewController new]];
                            }];
                        }
                        else
                        {
                            [HYProgressHUD handlerDataError:status currentVC:sSelf handler:nil];
                        }
                    }
                }];
            }];
        }];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(WScale*-25);
            make.height.mas_equalTo(HScale*50);
            make.width.mas_equalTo(WScale*120);
            make.centerY.mas_equalTo(view.mas_centerY);
        }];
        [tableview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
        }];
        tableview.tableFooterView = view;
        
    }
}

- (void)loadRefundedBottom
{
    self.serviceBtn = [UIButton crateTransBottomBtn:self];
    [tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(HScale*-55);
    }];
}

- (void)loadProgressBottom
{
    HYWeakSelf;
    if (!revokeBtn)
    {
        revokeBtn = [UIButton createBgImageBtn:LS(@"Revoked") font:15 bgColor:@"save_bg" height:HYHeight(40) btnAction:^{
            HYStrongSelf;
            [HYAlertView alertShow:LS(@"Determine") cancelMessage:LS(@"Cancel") message:LS(@"Alert_Cancellation_Refund") imageName:@"tuikuan" okOrange:YES messageIsOrange:NO handler:^{
                [HYProgressHUD showLoading:@"" rootView:sSelf.view];
                [HYUserViewModel checkTransPass:^(NSString *status) {
                    [HYProgressHUD hideLoading:sSelf.view];
                    if ([status isEqualToString:REQUEST_SUCCESS])
                    {
                        [HYPassView createView:LS(@"Start_Cancellation_Refund") money:sSelf.transModel.settle_amount trans_id:sSelf.transModel.trans_ID handler:^{
                            sSelf.transModel.finishStatus = HYFinishStatus_Success;
                            sSelf.transModel.isChange = YES;
                            [sSelf loadData];
                        }];
                    }
                    else
                    {
                        if ([status isEqualToString:SHOP_TRADE_NO_PASS])
                        {
                            [HYAlertView alertShow:LS(@"Determine") cancelMessage:LS(@"Cancel") message:LS(@"No_Trans_Pass") imageName:@"tuikuan" okOrange:YES messageIsOrange:YES handler:^{
                                [sSelf pushAction:[HYSetTeadePassViewController new]];
                            }];
                        }
                        else
                        {
                            [HYProgressHUD handlerDataError:status currentVC:sSelf handler:nil];
                        }
                    }
                }];
                
            }];
        }];
        [self.view addSubview:revokeBtn];
        [revokeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(HScale*-10);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.left.equalTo(self.view).offset(WScale*12);
            make.height.mas_equalTo(HScale*40);
        }];
        
    }
    [tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(HScale*-55);
    }];
}

#pragma mark - tableview datasource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.transModel.titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *mArray = self.transModel.titleArray[section];
    return [mArray count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[HYStyle createView:[UIColor fSixColor]];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale*10);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 2)
        {
            HYOrderStatusCell *cell = [HYOrderStatusCell createCell:tableView];
            [cell bindModel:self.transModel];
            return cell;
        }
        else
        {
            HYOrderDetailsCell *cell = [HYOrderDetailsCell createCell:tableview];
            cell.messageLbl.textColor = [UIColor nineSixColor];
            [cell bindData:self.transModel.titleArray[indexPath.section][indexPath.row] message:self.transModel.messageArray[indexPath.section][indexPath.row]];
            if (indexPath.row == 0 || indexPath.row == 1)
            {
                cell.messageLbl.font = FONTSIZE(18);
            }
            return cell;
        }
    }
    else
    {
        HYOrderDetailsCell *cell = [HYOrderDetailsCell createCell:tableView];
        cell.messageLbl.textColor = [UIColor bFourColor];
        [cell bindData:self.transModel.titleArray[indexPath.section][indexPath.row] message:self.transModel.messageArray[indexPath.section][indexPath.row]];
        return cell;
    }
}
#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(!self.transModel.isRequesrtFail)];
    noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
    return noData;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if (self.transModel.isRequesrtFail == NO)
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
