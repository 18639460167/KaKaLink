//
//  MyLineView.m
//  旋转
//
//  Created by tenpastnine-ios-dev on 17/1/13.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "MyLineView.h"
#import "UUChart.h"
#import "HYDataChartView.h"
@interface MyLineView()<HYChartDataSource>
{
    HYDataChartView *chartView;
    
    UIButton *rightBtn;
    UIButton *leftBtn;
    
    NSMutableArray *myDateArray;
    NSArray *myYArray;
    NSInteger mIndex;
}

@property (nonatomic, copy) mdateAction block;
@property (nonatomic, strong) NSArray *oldXArray;
@end

@implementation MyLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createView:(NSArray *)dateArray action:(mdateAction)action
{
    MyLineView *view = [[MyLineView alloc]initWithFrame:CGRectZero createView:dateArray action:action];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame createView:(NSArray *)dateArray action:(mdateAction)action
{
    if (self = [super initWithFrame:frame])
    {
        __weak typeof(self)wSelf = self;
        self.isSuccess = ^(BOOL isOK)
        {
            myDateArray = [NSMutableArray arrayWithArray:wSelf.oldXArray];
            [wSelf isHideRightBtn];
        };
        self.backgroundColor = [UIColor whiteColor];
        self.block = action;
        myDateArray = [NSMutableArray arrayWithArray:dateArray];
        dateArray = [NSMutableArray arrayWithArray:dateArray];
        
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(HScale*30);
        }];
        
        leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setImage:[UIImage imageNamed:@"sale_left"] forState:0];
        [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(bottomView);
            make.left.equalTo(bottomView).offset(WScale*26);
            make.width.mas_equalTo(leftBtn.mas_height).multipliedBy(16.0/20);
            //            make.size.mas_equalTo(CGSizeMake(WScale*16, WScale*20));
        }];
        
        rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setImage:[UIImage imageNamed:@"sale_right"] forState:0];
        [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(bottomView);
            make.right.equalTo(bottomView).offset(WScale*-26);
            make.width.mas_equalTo(rightBtn.mas_height).multipliedBy(16.0/20);
            // make.size.mas_equalTo(CGSizeMake(WScale*16, WScale*20));
        }];
        [self isHideRightBtn];
        
        UILabel *myLable = [UILabel createCenterLbl:LS(@"Nearly_Month_Sale") fontSize:13 textColor:[UIColor sixFourColor] fatherView:bottomView];
        [myLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(leftBtn.mas_centerY);
            make.left.equalTo(leftBtn.mas_right).offset(WScale*8);
            make.height.mas_equalTo(HScale*15);
            make.right.equalTo(rightBtn.mas_left).offset(WScale*-8);
        }];
    }
    return self;
}

- (void)reloadData:(NSArray *)yValueArray
{
    if (chartView)
    {
        [chartView removeFromSuperview];
        chartView  = nil;
    }
  
    myYArray = yValueArray;
    chartView = [[HYDataChartView alloc]initWithFrame:CGRectMake(WScale*10, 0, SCREEN_WIDTH-WScale*20, HScale*405/2) dataSource:self];
    [chartView showInView:self];
}

#pragma mark - btnAction
/**
 *  rigthAction
 */
- (void)rightAction
{
    mIndex = 1;
    if (self.block)
    {
        
        NSString *xString = [self getData:[myDateArray lastObject] isAdd:YES];
        [myDateArray removeObjectAtIndex:0];
        [myDateArray addObject:xString];
        self.block(myDateArray);
    }
      [self isHideRightBtn];
    
}
- (void)leftAction
{
    mIndex = 2;
   NSString *xString = [self getData:myDateArray[0] isAdd:NO];
    [myDateArray removeLastObject];
    [myDateArray insertObject:xString atIndex:0];
    if (self.block)
    {
        self.block(myDateArray);
    }
       [self isHideRightBtn];
}


#pragma mark - 判断按钮是否隐藏
- (void)isHideRightBtn
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [formatter dateFromString:[myDateArray lastObject]];
    
    NSString *nowDate = [formatter stringFromDate:[NSDate date]];
    NSDate *mnowDate = [formatter dateFromString:nowDate];
    NSComparisonResult resule = [date compare:mnowDate];
    if (resule == NSOrderedSame )
    {
        rightBtn.enabled = NO;
    }
    else if (resule == NSOrderedDescending)
    {
       rightBtn.enabled = NO;
    }
    else
    {
        rightBtn.enabled = YES;
    }
}
#pragma mark -chartLine delegate
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    self.oldXArray = [myDateArray mutableCopy];
   return [self dateArray:myDateArray];
}

- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    return @[myYArray];
}

- (NSArray *)dateArray:(NSMutableArray *)oldDate
{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSString *str in oldDate)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM"];
        NSDate *date = [formatter dateFromString:str];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents  *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
      
        [mArray addObject:[NSString stringWithFormat:@"%ld",(long)comps.month]];
    }
    return mArray;
}

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}
#pragma mark - 算时间

- (NSString *)setTime:(NSString *)nowTime isAdd:(BOOL)isAdd
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [formatter dateFromString:nowTime];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    if (isAdd)
    {
        if (comps.month == 12)
        {
            comps.year = comps.year+1;
            comps.month=1;
        }
        else
        {
            comps.month=comps.month+1;
        }
    }
    else
    {
        if (comps.month==1)
        {
            comps.year = comps.year-1;
            comps.month = 12;
        }
        else
        {
            comps.month = comps.month-1;
        }
        
    }
    NSDate *newdate = [calendar dateFromComponents:comps];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *strDate = [dateFormatter stringFromDate:newdate];
    return strDate;
}

- (NSString *)getData:(NSString *)nowTime isAdd:(BOOL)isAdd
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSDate *date = [formatter dateFromString:nowTime];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    if (isAdd)
    {
        if (comps.month == 12)
        {
            comps.year = comps.year+1;
            comps.month=1;
        }
        else
        {
            comps.month=comps.month+1;
        }
    }
    else
    {
        if (comps.month==1)
        {
            comps.year = comps.year-1;
            comps.month = 12;
        }
        else
        {
            comps.month = comps.month-1;
        }
        
    }
    NSDate *newdate = [calendar dateFromComponents:comps];
    
    NSString *str = [formatter stringFromDate:newdate];
    return str;
}

@end
