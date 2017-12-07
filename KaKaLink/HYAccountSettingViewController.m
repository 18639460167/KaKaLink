//
//  HYAccountSettingViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYAccountSettingViewController.h"

@interface HYAccountSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UIButton *headImage;
    
    HYNameView *nameView;
}

@end

@implementation HYAccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}
- (void)setUpUI
{
    self.view.backgroundColor = [UIColor fSixColor];
    tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.scrollEnabled = NO;
    tableview.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self tableHead];
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        if (IS_IPHONEX)
        {
            make.top.equalTo(self.view).offset(-44);
        }
        else
        {
            make.top.equalTo(self.view).offset(-20);
        }
    }];
}

- (void)tableHead
{
    HYWeakSelf;
    HYStrongSelf;
    UIView *headView = [HYStyle createView:[UIColor whiteColor]];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale*390/2);
    tableview.tableHeaderView = headView;
    
    UIImageView *image = [UIImageView new];
    image.image = IMAGE_NAME(@"setBg");
    [headView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(headView);
    }];
    
    [MessageButton showInView:headView btnAction:^{
        [sSelf pushAction:[HYNotiMessageViewController new]];
    }];
    
    UIView *bottomView = [HYStyle createView:[WHITE_COLOR colorWithAlphaComponent:0.2]];
    [headView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(headView);
        make.height.mas_equalTo(HScale*65);
    }];
    
    headImage = [UIButton buttonWithType:0];
    headImage.backgroundColor = [UIColor whiteColor];
    [headImage setImage:IMAGE_NAME(@"head") forState:0];
    headImage.layer.cornerRadius = HScale*175/4;
    [[headImage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [sSelf pushAction:[HYUserViewController new]];
    }];
    [headView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(WScale*35);
        make.bottom.equalTo(headView).offset(HScale*-30);
        make.size.mas_equalTo(CGSizeMake(HScale*175/2, HScale*175/2));
    }];
    
    nameView = [[HYNameView alloc]initWithFrame:CGRectZero];
    [headView addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HScale*18);
        make.bottom.equalTo(headView).offset(HScale*-31);
        make.left.equalTo(headView).offset(HScale*175/2+WScale*41.5);
        make.width.mas_equalTo(SCREEN_WIDTH-(HScale*175/2+WScale*41.5));
    }];
}

#pragma mark - tableview datasource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section!=2)
    {
        return HScale*10;
    }
    else
    {
        return 1;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section != 2)
    {
        UIView *view = [HYStyle createView: [UIColor colorWithHexString:@"#f6f6f6"]];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        return view;
    }
    else
    {
        UIView *view = [HYStyle createView: [UIColor colorWithHexString:@"#f6f6f6"]];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        return view;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale*80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        HYSettingUserCell *cell = [HYSettingUserCell createCell:tableview];
        cell.currentVC = self;
        return cell;
    }
    else
    {
        HYSettingActionCell *cell = [HYSettingActionCell createCell:tableview];
        cell.currentVC = self;
        return cell;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    nameView.name = READ_USER_NAME;
//    UIApplication *myApplication = [UIApplication sharedApplication];
//    [myApplication setStatusBarHidden:NO];
//    [myApplication setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
