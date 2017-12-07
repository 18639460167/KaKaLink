//
//  UITableView+HYTableRefersh.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "UITableView+HYTableRefersh.h"
#import "DefineHeard.h"
#import "MJRefresh/MJRefresh.h"

@implementation UITableView (HYTableRefersh)

- (void)setTableleHeardViewAction:(SEL)action target:(id)target
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    NSMutableArray *idleImages=[[NSMutableArray alloc]init];
    NSMutableArray *pullingImages=[[NSMutableArray alloc]init];
    NSMutableArray *refreshingImages=[[NSMutableArray alloc]init];
    for (int i=0; i<6; i++) {
        [idleImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",6]]];
        [pullingImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",1]]];
        [refreshingImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",i+1]]];
        
    }
    [header setTitle:LS(@"Pull to refresh...") forState:MJRefreshStateIdle];
    [header setTitle:LS(@"Release to refresh...") forState:MJRefreshStatePulling];
    [header setTitle:LS(@"Loading...") forState:MJRefreshStateRefreshing];
    
    // 设置普通状态的动画图片
    [header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.mj_header = header;
}

- (void)setTableviewFootAction:(SEL)action target:(id)target
{
    if (self.mj_footer == nil)
    {
        MJRefreshBackNormalFooter *footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
        footer.stateLabel.hidden = YES;
        self.mj_footer = footer;
    }
}

- (void)registerCell:(Class)className
{
    [self registerClass:[className class] forCellReuseIdentifier:NSStringFromClass(className)];
}

+ (UITableView *)createTableview:(UITableViewStyle)style fatherView:(id)vc
{
    UITableView *tableview =[[UITableView alloc]initWithFrame:CGRectZero style:style];
    if (vc)
    {
        tableview.dataSource = vc;
        tableview.delegate = vc;
        if ([vc isKindOfClass:[UIViewController class]])
        {
            UIViewController *mVc = (UIViewController *)vc;
            [mVc.view addSubview:tableview];
        }
        else
        {
            [vc addSubview:tableview];
        }
    }
    tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    return tableview;
}

+ (UITableView *)createTableWithEmple:(UITableViewStyle)style fatherView:(id)fatherView
{
    UITableView *tableview =[[UITableView alloc]initWithFrame:CGRectZero style:style];
    if (fatherView)
    {
        tableview.dataSource = fatherView;
        tableview.delegate = fatherView;
        tableview.emptyDataSetSource = fatherView;
        tableview.emptyDataSetDelegate = fatherView;
        if ([fatherView isKindOfClass:[UIViewController class]])
        {
            UIViewController *mVc = (UIViewController *)fatherView;
            [mVc.view addSubview:tableview];
        }
        else
        {
            [fatherView addSubview:tableview];
        }
    }
    if (style == UITableViewStylePlain)
    {
         tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    return tableview;
}

- (void)goodsDetailTableviewHeard:(NSInteger)arrayCount name:(NSString *)name number:(NSString *)number
{
    if (arrayCount > 0)
    {
        UIView *heardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HYHeight(75))];
        self.tableHeaderView = heardView;
        UILabel *nameLbl = [UILabel createCenterLbl:name fontSize:15 textColor:[UIColor threeTwoColor] fatherView:heardView];
        [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(heardView);
            make.left.equalTo(heardView).offset(HYWidth(20));
            make.centerX.mas_equalTo(heardView.mas_centerX);
        }];
        [UIView createLineView:HYWidth(15) superView:heardView];
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HYHeight(50))];
        self.tableFooterView = footView;
        UILabel *pieceLbl = [UILabel createRightLbl:LS(@"Piece") fontSize:15 textColor:[UIColor threeTwoColor] fatherView:footView];
        [pieceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(footView);
            make.right.equalTo(footView).offset(HYWidth(-20));
            make.width.mas_equalTo([HYStyle getWidthWithTitle:LS(@"Piece") font:15]);
        }];
        
        UILabel *numberLbl = [UILabel createRightLbl:number fontSize:15 textColor:[UIColor eNineColor] fatherView:footView];
        [numberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(footView);
            make.right.equalTo(pieceLbl.mas_left).offset(-2);
            make.width.mas_equalTo([HYStyle getWidthWithTitle:number font:15]);
        }];
        UILabel *totalLbl = [UILabel createRightLbl:LS(@"Total") fontSize:15 textColor:[UIColor threeTwoColor] fatherView:footView];
        [totalLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(footView);
            make.right.equalTo(numberLbl.mas_left).offset(-2);
            make.left.equalTo(footView).offset(HYWidth(20));
        }];
        
        UIView *lineView = [UIView createView:[UIColor eOneColor] superView:footView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footView);
            make.height.mas_equalTo(0.5);
            make.centerX.mas_equalTo(footView.mas_centerX);
            make.left.equalTo(footView).offset(HYWidth(15));
        }];
    }
    else
    {
        self.tableFooterView = [UIView new];
        self.tableHeaderView = [UIView new];
    }
}

@end
