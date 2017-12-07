//
//  HYCheckSelectView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/24.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCheckSelectView.h"

@interface HYCheckSelectView()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *shapView;
    UIView *bgView;
    UITableView *tableview;
    
    NSMutableArray *tdArray;
    NSMutableArray *timeArray;
    NSArray *allArray;
    NSArray *bollArray;
    NSInteger tdSelIndex;
    NSInteger timeSelIndex;
}
@property (nonatomic, copy) checkSelHandler block;
@end

@implementation HYCheckSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)createViewTd:(NSString *)tdStr time:(NSString *)time handler:(checkSelHandler)complete
{
    HYCheckSelectView *view = [[HYCheckSelectView alloc]initWithFrame:[UIScreen mainScreen].bounds createViewTd:tdStr time:time handler:complete];
    [view show];
    
}
- (instancetype)initWithFrame:(CGRect)frame createViewTd:(NSString *)tdStr time:(NSString *)time handler:(checkSelHandler)complete
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        NSArray *tdTti = @[LS(@"All"),LS(@"Wechat_Collection"),LS(@"Ali_Pay")];
        NSArray *timeAr = @[LS(@"All"),LS(@"Today"),LS(@"Before")];
        self.block = complete;
        
        UIView *hideViw  =[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmiss)];
        [hideViw addGestureRecognizer:tap];
        [self addSubview:hideViw];
        tdArray = [NSMutableArray new];
        timeArray = [NSMutableArray new];
        for (int i=0; i<tdTti.count; i++)
        {
            NSNumber *number =[NSNumber numberWithBool:NO];
            if ([tdStr isEqualToString:tdTti[i]])
            {
                number = [NSNumber numberWithBool:YES];
            }
            [tdArray addObject:number];
        }
        for (int i=0; i<timeAr.count; i++)
        {
            NSNumber *number =[NSNumber numberWithBool:NO];
            if ([time isEqualToString:timeAr[i]])
            {
                number = [NSNumber numberWithBool:YES];
            }
            [timeArray addObject:number];
        }
        allArray = @[tdTti,timeAr];
        bollArray = @[tdArray,timeArray];
        bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-WScale*200, HScale*125-HScale*12+5, SCREEN_WIDTH*200, HScale*753/2+HScale*12)];
        bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        [self addSubview:bgView];
         bgView.transform = CGAffineTransformMakeScale(0, 0);
        [self drawArrow];
        [self createTableview];
    }
    return self;
}

/**
 *  画三角形
 */

- (void)drawArrow
{
    shapView = [[UIView alloc]init];
    CGFloat width = [HYStyle getWidthWithTitle:LS(@"Filter") font:10];
    if (width<WScale*35)
    {
        width = WScale*35;
    }
    shapView.frame = CGRectMake(WScale*200-WScale*20-(width-WScale*12)/2-WScale*12, 0, WScale*15, HScale*12);
    [bgView addSubview:shapView];
    
    CAShapeLayer *shaLayer = [CAShapeLayer layer];
    shaLayer.position = CGPointMake(WScale*12/2, HScale*6);
    shaLayer.bounds = CGRectMake(0, 0, WScale*12, HScale*12);
    shaLayer.fillColor = [UIColor fSixColor].CGColor;
    UIBezierPath *berPath = [UIBezierPath bezierPath];
    [berPath moveToPoint:CGPointMake(WScale*12/2, 0)];
    [berPath addLineToPoint:CGPointMake(0, HScale*12)];
    [berPath addLineToPoint:CGPointMake(WScale*12, HScale*12)];
    [berPath addLineToPoint:CGPointMake(WScale*12/2, 0)];
    shaLayer.path = berPath.CGPath;
    [shapView.layer addSublayer:shaLayer];
}

/**
 *   单选列表
 */

- (void)createTableview
{
    tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.tableFooterView = [UIView new];
    [tableview registerCell:[HYSelectOneCell class]];
    [bgView addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bgView);
        make.top.equalTo(shapView.mas_bottom);
    }];
}

#pragma mark -tableview datasource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return allArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = allArray[section];
    return [arr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HScale*37;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (HScale*753/2-HScale*74)/6;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WScale*200, HScale*37)];
    view.backgroundColor = [UIColor fSixColor];
    NSString *text = LS(@"Payment_Channel");
    if (section==1)
    {
        text = LS(@"Payment_Date");
    }
    UILabel *titleLbl = [UILabel createLbl:text fontSize:15 textColor:[UIColor threeTwoColor] fatherView:view];
    titleLbl.frame = CGRectMake(WScale*8, 0, WScale*192, HScale*37);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYSelectOneCell *cell = [HYSelectOneCell createCell:tableview];
    NSArray *array = allArray[indexPath.section];
    NSMutableArray *arr = bollArray[indexPath.section];
    [cell bindData:arr[indexPath.row] title:array[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *array = bollArray[indexPath.section];
    BOOL isOk = [array[indexPath.row] boolValue];
    if (isOk)
    {
        return;
    }
    else
    {
        if (indexPath.section==0)
        {
            NSNumber *number = [NSNumber numberWithBool:NO];
            [array replaceObjectAtIndex:tdSelIndex withObject:number];
            NSNumber *number1 = [NSNumber numberWithBool:YES];
            [array replaceObjectAtIndex:indexPath.row withObject:number1];
            tdSelIndex = indexPath.row;
            [tableView reloadData];
        }
        else
        {
            NSNumber *number = [NSNumber numberWithBool:NO];;
            [array replaceObjectAtIndex:timeSelIndex withObject:number];
            NSNumber *number1 = [NSNumber numberWithBool:YES];
            [array replaceObjectAtIndex:indexPath.row withObject:number1];
            timeSelIndex = indexPath.row;
            [tableView reloadData];
        }
        if (self.block)
        {
            self.block(indexPath.section,allArray[indexPath.section][indexPath.row]);
        }
        [self dissmiss];
    }
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

- (void)dissmiss
{
    self.userInteractionEnabled =NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        bgView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
