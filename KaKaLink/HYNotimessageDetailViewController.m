//
//  HYNotimessageDetailViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYNotimessageDetailViewController.h"
#import "HYNotiMessageContentCell.h"
#import "HYOrderDetailsCell.h"
#import "NotifiMessageViewModel.h"

@interface HYNotimessageDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
}

@end

@implementation HYNotimessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self setUpUI];
}
- (void)setUpUI
{
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Message_Detail") didBackAction:nil];
    
    tableview = [UITableView createTableview:UITableViewStylePlain fatherView:self];
    tableview.scrollEnabled = NO;
    [tableview registerCell:[HYOrderDetailsCell class]];
    [tableview registerCell:[HYNotiMessageContentCell class]];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
}

- (void)loadData
{
    if (self.messageID)
    {
        [NotifiMessageViewModel handleMessage:self.messageID handler:^(NSString *status) {
            if ([status isEqualToString:REQUEST_SUCCESS])
            {
                if(self.readAction)
                {
                    self.readAction();
                }
                [PushNumberModel BageNumberDeauce];
            }
        }];
    }
}

#pragma mark -tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2)
    {
        CGFloat height= [HYStyle getHeightByWidth:SCREEN_WIDTH-WScale*50 title:self.content font:15];
        return height+HScale*25;
    }
    return HScale*50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2)
    {
        HYNotiMessageContentCell *cell = [HYNotiMessageContentCell createCell:tableView];
        [cell bindData:self.content];
        return cell;
    }
    else
    {
        HYOrderDetailsCell *cell = [HYOrderDetailsCell createCell:tableview];
        if (indexPath.row==0)
        {
            [cell bindData:LS(@"Message_Type") message:self.messagetype];
        }
        else
        {
            [cell bindData:LS(@"Message_Time") message:self.messageTime];
        }
        return cell;
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
