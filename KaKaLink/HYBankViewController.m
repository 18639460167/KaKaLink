//
//  HYBankViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYBankViewController.h"
#import "HYBankCell.h"

@interface HYBankViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSArray *titleArray;
    NSArray *messageArray;
}

@end

@implementation HYBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI
{
    
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Personal_Information") didBackAction:nil];
    titleArray = @[LS(@"Bank_Branch_Name"),LS(@"Bank_Trunk_Name"),LS(@"Bank_Account_Name"),LS(@"Bank_Account_Number")];
    messageArray = READ_BANK_MESSAGE;
    tableview = [UITableView createTableview:UITableViewStylePlain fatherView:self];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.scrollEnabled = NO;
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
}
#pragma mark- tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale*50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYBankCell *cell = [HYBankCell createCell:tableview];
    [cell bindData:titleArray[indexPath.row] message:messageArray[indexPath.row]];
    return cell;
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
