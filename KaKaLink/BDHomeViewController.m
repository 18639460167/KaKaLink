//
//  BDHomeViewController.m
//  TourGuidShop
//
//  Created by Black on 17/6/21.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "BDHomeViewController.h"

@interface BDHomeViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
{
    BOOL loadIsFirst;
    NSArray *doneModelArray;
    NSArray *progressModelArray;
    NSArray *refundModelArray;
    
    HYCheckActionView *actionView;
}

@property (nonatomic, strong)  HYCheckMessageView *messageView;
@property (nonatomic, strong)  HYCheckScrollView *bottomView;

@end

@implementation BDHomeViewController
@synthesize bottomView;
@synthesize doneModel;
@synthesize progressModel;
@synthesize refundModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(orderChange) name:Notification_orderChange object:nil];
    HYWeakSelf;
    HYStrongSelf;
    doneModel = [[HYTransViewModel alloc]init];
    progressModel = [[HYTransViewModel alloc]init];
    refundModel = [[HYTransViewModel alloc]init];
    
    actionView = [HYCheckActionView createView:self transModel:self.doneModel];
    actionView.actionHandler = ^(NSString *payID, NSString *timeID){
        HYStrongSelf;
        
        sSelf.messageView.nUnitLbl.text = [HYStyle volueTime:timeID];
        [sSelf loadData];
    };
    actionView.actionSelectShop = ^(NSString *title,NSString *mid){
        [sSelf loadData];
    };
    [self.view addSubview:actionView];
    self.messageView = [[HYCheckMessageView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.messageView ];
    [self.messageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(actionView.mas_bottom);
        make.height.mas_equalTo(HScale*(213/2+10));
    }];
    bottomView =[[HYCheckScrollView alloc]initWithFrame:CGRectZero fatherView:self];
    bottomView.complete = ^()
    {
        switch (sSelf.bottomView.currentIndex)
        {
            case 1:
                sSelf.doneModel.finishStatus = [HYModel getFinishStatus:[NSString stringWithFormat:@"%d",(int)sSelf.bottomView.currentIndex]];
                [sSelf loadData];
                break;
            case 2:
                sSelf.progressModel.finishStatus = [HYModel getFinishStatus:[NSString stringWithFormat:@"%d",(int)sSelf.bottomView.currentIndex]];
                [sSelf loadData];
                break;
            case 3:
               sSelf.refundModel.finishStatus = [HYModel getFinishStatus:[NSString stringWithFormat:@"%d",(int)sSelf.bottomView.currentIndex]];
                [sSelf loadData];
                break;
                
            default:
                break;
        }
    };
    bottomView.checkLoadData = ^(){
        [sSelf loadData];
    };
    bottomView.checkLoadMore = ^(){
        [sSelf loadMore];
    };
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.messageView.mas_bottom);
    }];

}

- (void)orderChange
{
    [doneModel modelReloadData];
    doneModelArray = [NSArray new];
    
    [progressModel modelReloadData];
    progressModelArray = [NSArray new];
    
    [refundModel modelReloadData];
    refundModelArray = [NSArray new];
    
     self.messageView.mUnitLbl.text = [NSString stringWithFormat:@"%@ / %@",LS(@"Total_Sale"),READ_SHOP_SIGN];
    
    for (int i=0; i<3; i++)
    {
        UITableView *tableview = (UITableView *)[bottomView.scrollview viewWithTag:i+100];
        [tableview reloadData];
    }
    [actionView reloadShopList];
}

- (void)loadData
{
    HYWeakSelf;
    HYStrongSelf;
    UITableView *tableview = (UITableView*)[bottomView.scrollview viewWithTag:100+bottomView.currentIndex-1];
    [HYProgressHUD showLoading:@"" rootView:self.view];
    if (bottomView.currentIndex == 1)
    {
        [sSelf.messageView bindModel:doneModel];
        [doneModel loadNewOrderList:^(NSString *status) {
            [tableview.mj_header endRefreshing];
            [sSelf.messageView bindModel:doneModel];
            doneModelArray = doneModel.orderListArray;
            [tableview reloadData];
            tableview.contentOffset = CGPointMake(0, 0);
            [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
                [sSelf loadData];
            }];
        }];
    }
    else if (bottomView.currentIndex == 2)
    {
        [sSelf.messageView bindModel:progressModel];
        [progressModel loadNewOrderList:^(NSString *status) {
            [tableview.mj_header endRefreshing];
            [sSelf.messageView bindModel:progressModel];
            progressModelArray = progressModel.orderListArray;
            [tableview reloadData];
            tableview.contentOffset = CGPointMake(0, 0);
            [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
                [sSelf loadData];
            }];
        }];
    }
    else
    {
        [sSelf.messageView bindModel:refundModel];
        [refundModel loadNewOrderList:^(NSString *status) {
            [tableview.mj_header endRefreshing];
            [sSelf.messageView bindModel:refundModel];
            refundModelArray = refundModel.orderListArray;
            [tableview reloadData];
            tableview.contentOffset = CGPointMake(0, 0);
            [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
                [sSelf loadData];
            }];
        }];
    }
}
- (void)loadMore
{
    HYWeakSelf;
    HYStrongSelf;
    UITableView *tableview = (UITableView*)[bottomView.scrollview viewWithTag:100+bottomView.currentIndex-1];
    if (bottomView.currentIndex==1)
    {
        [HYProgressHUD showLoading:@"" rootView:self.view];
        [doneModel loadMoreOrder:^(NSString *status) {
            [tableview.mj_footer endRefreshing];
            if ([status isEqualToString:REQUEST_SUCCESS])
            {
                doneModelArray = doneModel.orderListArray;
                [tableview reloadData];
            }
            [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
                [sSelf loadData];
            }];
        }];
    }
    else if (bottomView.currentIndex==2)
    {
        [HYProgressHUD showLoading:@"" rootView:self.view];
        [progressModel loadMoreOrder:^(NSString *status) {
            [tableview.mj_footer endRefreshing];
            if ([status isEqualToString:REQUEST_SUCCESS])
            {
                progressModelArray = progressModel.orderListArray;
                [tableview reloadData];
            }
            [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
                [sSelf loadData];
            }];
        }];
    }
    else if(bottomView.currentIndex==3)
    {
            [HYProgressHUD showLoading:@"" rootView:self.view];
            [refundModel loadMoreOrder:^(NSString *status) {
                [tableview.mj_footer endRefreshing];
                if ([status isEqualToString:REQUEST_SUCCESS])
                {
                    refundModelArray = refundModel.orderListArray;
                    [tableview reloadData];
                }
                [HYProgressHUD handlerDataError:status currentVC:sSelf handler:^{
                    [sSelf loadData];
                }];
            }];
    }

}

#pragma mark - tableview datasource deleagte
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (bottomView.currentIndex==1)
    {
        return doneModelArray.count;
    }
    else if (bottomView.currentIndex==2)
    {
        return progressModelArray.count;
    }
    else if (bottomView.currentIndex==3)
    {
        return refundModelArray.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale*72;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYOrderTableViewCell *cell = [HYOrderTableViewCell createCell:tableView];
    if (tableView.tag==100)
    {
        cell.transModel = doneModelArray[indexPath.row];
    }
    else if (tableView.tag== 101)
    {
        cell.transModel = progressModelArray[indexPath.row];
    }
    else if (tableView.tag == 102)
    {
        cell.transModel = refundModelArray[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HYOrderTableViewCell *cell = (HYOrderTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell cellAction:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HYFirstLeadingView showLeading:^{
        [self loadData];
    }];
}

#pragma mark - EmptyDataSet delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    switch (scrollView.tag)
    {
        case 100:
        {
            UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(doneModel.isRequestFailed)];
            noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
            return noData;
        }
            break;
        case 101:
        {
            UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(progressModel.isRequestFailed)];
            noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
            return noData;
        }
            break;
        case 102:
        {
            UIImage *noData =[UIImage imageNamed:PLACE_IMAGE(refundModel.isRequestFailed)];
            noData = [noData imageByScalingToSize:CGSizeMake(WScale*200, 331.0/549.0*WScale*200)];
            return noData;
        }
            break;
            
        default:
            break;
    }
    return nil;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    switch (scrollView.tag)
    {
        case 100:
        {
            if (doneModel.isRequestFailed)
            {
                [self loadData];
            }
        }
            break;
        case 101:
        {
            if (progressModel.isRequestFailed)
            {
                [self loadData];
            }
        }
            break;
        case 102:
        {
            if (refundModel.isRequestFailed)
            {
                [self loadData];
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
