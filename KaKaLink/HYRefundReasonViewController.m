//
//  HYRefundReasonViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYRefundReasonViewController.h"
#import "HYPassView.h"
#import "HYUserViewModel.h"
#import "HYSetTeadePassViewController.h"
#import "HYUserViewModel.h"
#import "HYRefundMessageCell.h"
#import "HYRefundReasonCell.h"
#import "HYRefunceMoneyCell.h"
@interface HYRefundReasonViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *reasonArray;
    NSString *reasonMessage;
}

@property (nonatomic, assign) NSInteger reasonIndex;

@property (nonatomic, strong) HYRefundMessageCell *messageCell;

@end

@implementation HYRefundReasonViewController
@synthesize reasonIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
}

- (void)setUpUI
{
    HYWeakSelf;
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Refund") didBackAction:nil];
    reasonMessage = @"";
    reasonIndex = -1;
    reasonArray = @[LS(@"Business_Negotiations"),LS(@"Many_Times_Pay"),LS(@"Other_Reasons")];
    UIButton *button = [UIButton buttonWithType:0];
    [button setLayerBtn:LS(@"Refund_Now") fontName:GB1_0 sizeFont:15 sizeColor:WHITE_COLOR backColor:[UIColor colorWithHexString:@"#f5a623"]];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        HYStrongSelf;
        NSString *str = reasonIndex==-1?@"":reasonArray[reasonIndex];
        if ([str isEqualToString:@""])
        {
            [HYProgressHUD showLoading:LS(@"Choose_Refund_Reason") time:ErrorInfo_ShowTime currentView:self.view];
        }
        else
        {
            [HYProgressHUD showLoading:@"" rootView:self.view];
            [HYUserViewModel checkTransPass:^(NSString *status) {
                [HYProgressHUD hideLoading:self.view];
                if ([status isEqualToString:REQUEST_SUCCESS])
                {
                    if (reasonIndex == 2)
                    {
                        if ([reasonMessage isEqualToString:@""])
                        {
                            [self.messageCell.textview becomeFirstResponder];
                            return ;
                        }
                    }
                    [HYPassView createView:LS(@"Initiate_Order_Refund") refubd_Type:[HYStyle orderRefundReason:str] money:sSelf.transModel.settle_amount refund_reason:reasonMessage trans_id:sSelf.transModel.trans_ID handler:^{
                        for (UIViewController *vc in sSelf.navigationController.viewControllers)
                        {
                            if ([vc isKindOfClass:[HYTransDerailViewController class]])
                            {
                                HYTransDerailViewController *nvc = (HYTransDerailViewController *)vc;
                                nvc.transModel.finishStatus = HYFinishStatus_Progress;
                                nvc.transModel.refund_reason = reasonMessage;
                                nvc.transModel.refund_reason_type = [HYModel chooseReason:reasonMessage];
                                [sSelf.navigationController popToViewController:nvc animated:YES];
                            }
                        }
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
                        [HYProgressHUD handlerDataError:status currentVC:self handler:nil];
                    }
                }
            }];
        }
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-HScale*20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view).offset(WScale*12);
        make.height.mas_equalTo(HScale*40);
    }];
    UITableView *tableview = [UITableView createTableview:UITableViewStylePlain fatherView:self];
    [tableview registerCell:[HYRefundMessageCell class]];
    [tableview registerCell:[HYRefundReasonCell class]];
    [tableview registerCell:[HYRefunceMoneyCell class]];
    self.messageCell = [[HYRefundMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HYRefundMessageCell"];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
        make.bottom.equalTo(button.mas_top);
    }];
}


#pragma mark - tableview datasouce delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 4;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==3)
        {
            return HScale*130;
        }
        else
        {
            return HScale*35;
        }
    }
    else
    {
        return HScale*35;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScale*58;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [HYStyle createView:WHITE_COLOR];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale*58);
    NSString *str = LS(@"Choose_Refund_Reason");
    if (section==1)
    {
        str = LS(@"Refund_Amount");
    }
    UIView *topView = [HYStyle createView:[UIColor fSixColor]];
    [view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(view);
        make.height.mas_equalTo(HScale*37);
    }];
    UILabel *lable = [UILabel createLbl:str fontSize:15 textColor:[UIColor threeTwoColor] fatherView:topView];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(topView);
        make.right.equalTo(topView).offset(WScale*-8);
        make.left.equalTo(topView).offset(WScale*25);
    }];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==3)
        {
            self.messageCell.textHandler = ^(NSString *text){
                reasonMessage = text;
            };
            if (reasonIndex ==2)
            {
                self.messageCell.textview.userInteractionEnabled = YES;
            }
            else
            {
                reasonMessage = @"";
                self.messageCell.textview.text = @"";
                self.messageCell.textview.placeHolderLbl.alpha = 1.0;
                self.messageCell.textview.userInteractionEnabled = NO;
            }
            self.messageCell.textview.text = reasonMessage;
            return self.messageCell;
        }
        else
        {
            HYRefundReasonCell *cell = [HYRefundReasonCell createCell:tableView];
            NSNumber *number = [NSNumber numberWithBool:NO];
            if (reasonIndex == indexPath.row)
            {
                number = [NSNumber numberWithBool:YES];
            }
            [cell bindData:number reason:reasonArray[indexPath.row]];
            return cell;
        }
    }
    HYRefunceMoneyCell *cell = [HYRefunceMoneyCell createCell:tableView];
    cell.moneyLbl.text = [self.transModel.settle_amount addMoneyUnit];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row!=3)
        {
            reasonIndex = indexPath.row;
            [tableView reloadData];
        }
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
