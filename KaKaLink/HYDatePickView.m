//
//  HYDatePickView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "HYDatePickView.h"
@interface HYDatePickView()
{
    UIView *whiteView;
}
@property (nonatomic, strong) UILabel *yearLbl;
@property (nonatomic, strong) UILabel *monthLbl;
@property (nonatomic, strong) UILabel *dayLbl;
@property (nonatomic, copy)   NSString *chooseDate;
@property (nonatomic, copy)   HYHandler dateHandler;
@end

@implementation HYDatePickView
@synthesize chooseDate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showDatePicker:(HYHandler)complete
{
    HYDatePickView *datePick = [[HYDatePickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) DatePicker:complete];
    [datePick show];
}
- (instancetype)initWithFrame:(CGRect)frame DatePicker:(HYHandler)complete
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.dateHandler = complete;
        chooseDate = [self getNowDate];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        [self addSubview:bgView];
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAction)];
        [bgView addGestureRecognizer:tapges];
        
        whiteView  = [[UIView alloc]initWithFrame:CGRectZero];
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.layer.cornerRadius = 10;
        whiteView.layer.masksToBounds = YES;
        whiteView.alpha = 0.1;
        [self addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(WScale*300, HScale*195));
        }];
        
        UIDatePicker *datePicker = [[UIDatePicker alloc]init];
        [datePicker setDate:[NSDate date]];
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        datePicker.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en"];
        [datePicker addTarget:self action:@selector(update:) forControlEvents:UIControlEventValueChanged];
        [whiteView addSubview:datePicker];
        [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(whiteView);
            make.height.mas_equalTo(HScale*140);
        }];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectZero];
        lineView.backgroundColor = RGBSAME(149);
        [whiteView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(whiteView);
            make.top.equalTo(datePicker.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        HYWeakSelf;
        [cancelBtn setBtnTitle:@"Cancel" sizeFont:22 sizeColor:RGBSAME(0) action:^{
            HYStrongSelf;
            [sSelf hide:YES];
        }];
        [whiteView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(whiteView);
            make.top.equalTo(lineView.mas_bottom);
            make.width.mas_equalTo(whiteView).multipliedBy(0.5);
        }];
        
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setBtnTitle:@"OK" sizeFont:WScale*22 sizeColor:RGBSAME(0) action:^{
            HYStrongSelf;
            [sSelf hide:NO];
        }];
        [whiteView addSubview:okBtn];
        [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(whiteView);
            make.top.equalTo(lineView.mas_bottom);
            make.width.mas_equalTo(whiteView).multipliedBy(0.5);
        }];
        
        UIView *cLine = [UIView new];
        cLine.backgroundColor = RGBSAME(149);
        [whiteView addSubview:cLine];
        [cLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(whiteView.mas_centerX);
            make.bottom.equalTo(whiteView);
            make.top.equalTo(lineView.mas_bottom);
            make.width.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    [window addSubview:self];
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        whiteView.alpha = 1;
    }];
}

- (void)hideAction
{
    [self hide:YES];
}
- (void)hide:(BOOL)isCancle
{
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        whiteView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (isCancle == NO)
        {
            if (self.dateHandler)
            {
                self.dateHandler(chooseDate);
            }
        }
    }];
}

- (void)update:(UIDatePicker*)datePicker
{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    chooseDate=[dateformatter stringFromDate:datePicker.date];
}
- (NSString*)RealDate:(NSString*)currentChooseDate
{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeInterval closeInterval=[[dateformatter dateFromString:currentChooseDate] timeIntervalSinceNow];
    if (closeInterval>0)
    {
        return [self getNowDate];
    }
    else
    {
        return currentChooseDate;
    }
}
- (NSString*)getNowDate
{
    NSDate *todayDate=[NSDate new];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *todayStr=[dateformatter stringFromDate:todayDate];
    return [todayStr componentsSeparatedByString:@" "][0];
}
@end
