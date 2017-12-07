//
//  HYCardFilterView.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardFilterView.h"

@implementation HYCardTypeModel

+ (instancetype)createWithDic:(NSDictionary *)dic
{
    HYCardTypeModel *model = [[HYCardTypeModel alloc]initWithDic:dic];
    return model;
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.title = [dic objectForKey:@"title"];
        self.titleID = [dic objectForKey:@"id"];
        self.isSelect = NO;
    }
    return self;
}

@end

@interface HYCardFilterView()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *shapView;
    UIView *bgView;
    UITableView *tableview;
    NSMutableArray *titleArray;
    NSInteger curretnIndex;
}
@property (nonatomic, copy) HYHandler handler;

@end

@implementation HYCardFilterView

+ (void)createFilterView:(NSString *)typeID complete:(HYHandler)complete
{
    HYCardFilterView *view = [[HYCardFilterView alloc]initWithFrame:[UIScreen mainScreen].bounds type:typeID handler:complete];
    [view show];
}

- (instancetype)initWithFrame:(CGRect)frame type:(NSString *)typeID handler:(HYHandler)handler
{
    if (self = [super initWithFrame:frame])
    {
        self.handler = handler;
        
        titleArray = [NSMutableArray array];
        NSArray*dicArray = [NSString cardCouponsTpe];
        for (int i=0;i<dicArray.count;i++)
        {
            NSDictionary *dic = dicArray[i];
            HYCardTypeModel *model = [HYCardTypeModel createWithDic:dic];
            if ([[dic objectForKey:@"id"] isEqualToString:typeID])
            {
                curretnIndex = i;
                model.isSelect = YES;
            }
            [titleArray addObject:model];
        }
        
        UIView *hideView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmiss:)];
        [hideView addGestureRecognizer:tap];
        [self addSubview:hideView];
        
        bgView = [UIView createView:[UIColor clearColor] superView:self];
        CGFloat height = HScale*50*titleArray.count+HScale*49;
        if (SCREEN_HEIGHT-NAV_HEIGT-HScale*5 < height)
        {
            height = SCREEN_HEIGHT-NAV_HEIGT-HScale*5;
        }
        bgView.frame = CGRectMake(SCREEN_WIDTH-WScale*200, NAV_HEIGT, SCREEN_WIDTH*200, height);
        bgView.transform = CGAffineTransformMakeScale(0, 0);
        [self drawArrow];
        [self createTableview];
        
    }
    return self;
}

- (void)drawArrow
{
    shapView = [[UIView alloc]init];
    CGFloat width = [HYStyle getWidthWithTitle:LS(@"Filter") font:10];
    if (width<WScale*35)
    {
        width = WScale*35;
    }
    shapView.frame = CGRectMake(WScale*200-WScale*10-(width-WScale*12)/2-WScale*12, 0, WScale*15, HScale*12);
    [bgView addSubview:shapView];
    
    CAShapeLayer *shaLayer = [CAShapeLayer layer];
    shaLayer.position = CGPointMake(WScale*12/2, HScale*6);
    shaLayer.bounds = CGRectMake(0, 0, WScale*12, HScale*12);
    shaLayer.fillColor = [UIColor colorWithHexString:@"#f6f6f6"].CGColor;
    UIBezierPath *berPath = [UIBezierPath bezierPath];
    [berPath moveToPoint:CGPointMake(WScale*12/2, 0)];
    [berPath addLineToPoint:CGPointMake(0, HScale*12)];
    [berPath addLineToPoint:CGPointMake(WScale*12, HScale*12)];
    [berPath addLineToPoint:CGPointMake(WScale*12/2, 0)];
    shaLayer.path = berPath.CGPath;
    [shapView.layer addSublayer:shaLayer];
}

- (void)createTableview
{
    tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.rowHeight = HScale*50;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.tableFooterView = [UIView new];
    [bgView addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.top.equalTo(shapView.mas_bottom);
    }];
}

#pragma mark - tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScale*37;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WScale*200, HScale*37)];
    view.backgroundColor = [UIColor fSixColor];
    NSString *text = LS(@"Card_Ticket_Type");
    UILabel *titleLbl = [UILabel createLbl:text fontSize:15 textColor:[UIColor threeTwoColor] fatherView:view];
    titleLbl.frame = CGRectMake(WScale*8, 0, WScale*192, HScale*37);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYSelectOneCell *cell = [HYSelectOneCell createCell:tableview];
    [cell bindModel:titleArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (curretnIndex == indexPath.row)
    {
        return;
    }
    else
    {
        HYCardTypeModel *model = titleArray[curretnIndex];
        model.isSelect = NO;
        model = titleArray[indexPath.row];
        model.isSelect = YES;
        curretnIndex = indexPath.row;
        [tableView reloadData];
        [self dissmiss:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = tableview.contentOffset;
    if (offset.y <= 0)
    {
        offset.y = 0;
    }
    tableview.contentOffset = offset;
}

- (void)show
{
    UIWindow *window =[[UIApplication sharedApplication]keyWindow];
    [window addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        bgView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}


- (void)dissmiss:(BOOL)isLoad
{
    self.userInteractionEnabled =NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        bgView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        if (isLoad)
        {
            HYCardTypeModel *model = titleArray[curretnIndex];
            if (self.handler)
            {
                self.handler(model.titleID);
            }
        }
        [self removeFromSuperview];
    }];
}
@end
