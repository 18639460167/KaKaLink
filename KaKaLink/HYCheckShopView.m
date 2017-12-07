//
//  HYCheckShopView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCheckShopView.h"
#import "HYSelectOneCell.h"

@implementation HYCheckShopView
@synthesize shopNameLbl;
@synthesize clickBtn;
@synthesize arrorImage;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIView *clickView = [[UIView alloc]initWithFrame:CGRectZero];
        clickView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        clickView.layer.cornerRadius = WScale*19;
        clickView.layer.masksToBounds = YES;
        [self addSubview:clickView];
        [clickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.equalTo(self).offset(HScale*7.5);
            make.height.mas_equalTo(HScale *38);
            make.left.equalTo(self).offset(12.5*WScale);
        }];
        
        arrorImage = [[UIImageView alloc]init];
        arrorImage.image = IMAGE_NAME(@"arrow");
        [clickView addSubview:arrorImage];
        [arrorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(clickView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScale*12, HScale*12));
            make.left.equalTo(clickView).mas_equalTo(WScale*11);
        }];
        
        shopNameLbl = [UILabel createLbl:LS(@"Select_Shop") fontSize:15 textColor:[UIColor threeTwoColor] fatherView:clickView];
        [shopNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(clickView);
            make.left.equalTo(arrorImage.mas_right).offset(WScale*10);
            make.right.equalTo(clickView).offset(-WScale*10);
        }];
        
        clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickView addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(clickView);
        }];
    }
    return self;
}

- (void)reloadDataShopList
{
    NSString *str = LS(@"Select_Shop");
    if([[HYShopMessage sharedModel] getShopListArray].count==1)
    {
        HYShopListModel *demol = [[HYShopMessage sharedModel] getShopListArray][0];
        str = demol.title;
    }
    shopNameLbl.text = str;
}

@end
@implementation HYChooseStatusView
@synthesize tableview;
@synthesize backHandler;
@synthesize bgView;
@synthesize numberArray;
@synthesize selectIndex;
@synthesize titleArray;

+ (void)createChooseStatusView:(NSString *)selectStr handler:(chooseStatus)complete
{
    HYChooseStatusView *shopView = [[HYChooseStatusView alloc]initWithFrame:[UIScreen mainScreen].bounds createChooseStatusView:selectStr handler:complete];
    [shopView show];
}

- (instancetype)initWithFrame:(CGRect)frame createChooseStatusView:(NSString *)selectStr handler:(chooseStatus)complete
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0];
        self.backHandler = complete;
        
        UIView *hideView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAction)];
        [hideView addGestureRecognizer:tap];
        [self addSubview:hideView];
        
        titleArray = @[LS(@"All"),LS(@"Settlf_Fail"),LS(@"Settle_Finish")];
        numberArray = [NSMutableArray new];
        for (int i=0; i<titleArray.count; i++)
        {
            NSNumber *number =[NSNumber numberWithBool:NO];
            if ([selectStr isEqualToString:@""])
            {
                if (i == 0)
                {
                    number = [NSNumber numberWithBool:YES];
                }
            }
            else
            {
                if ([selectStr intValue] == i-1)
                {
                    number = [NSNumber numberWithBool:YES];
                    self.selectIndex = i;
                }
            }
            [numberArray addObject:number];
        }
        bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-WScale*200, NAV_HEIGT, WScale*200, titleArray.count*HScale*50+HScale*37)];
        bgView.backgroundColor = [WHITE_COLOR colorWithAlphaComponent:0];
        [self addSubview:bgView];
        bgView.transform = CGAffineTransformMakeScale(0, 0);
        tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableview.dataSource = self;
        tableview.delegate = self;
        tableview.tableFooterView = [UIView new];
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [bgView addSubview:tableview];
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(bgView);
        }];
    }
    return self;
}

#pragma mark -tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale * 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScale*37;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WScale*200, HScale*37)];
    view.backgroundColor = [UIColor fSixColor];
    UILabel *titleLbl = [UILabel createLbl:LS(@"Liquidation_Status") fontSize:15 textColor:[UIColor threeTwoColor] fatherView:view];
    titleLbl.frame = CGRectMake(WScale*8, 0, WScale*192, HScale*37);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYSelectOneCell *cell = [HYSelectOneCell createCell:tableview];
    [cell bindData:numberArray[indexPath.row] title:titleArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectIndex == indexPath.row)
    {
        return;
    }
    else
    {
        NSNumber *number = [NSNumber numberWithBool:NO];
        [numberArray replaceObjectAtIndex:selectIndex withObject:number];
        NSNumber *number1 = [NSNumber numberWithBool:YES];
        [numberArray replaceObjectAtIndex:indexPath.row withObject:number1];
        self.selectIndex = indexPath.row;
        [tableView reloadData];
    }
    if (self.backHandler)
    {
        self.backHandler(selectIndex);
    }
    [self hideAction];
}

#pragma mark -action
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0.2];
        bgView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)hideAction
{
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0];
        bgView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end
