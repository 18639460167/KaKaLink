//
//  HYDataChartView.h
//  旋转
//
//  Created by tenpastnine-ios-dev on 17/1/13.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDataChartView.h"
#import "UUChartConst.h"
#import "HYLineChartView.h"

@class HYDataChartView ;
@protocol HYChartDataSource <NSObject>

@required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(HYDataChartView *)chart;

//数值多重数组
- (NSArray *)chartConfigAxisYValue:(HYDataChartView *)chart;

@optional
//颜色数组
- (NSArray *)chartConfigColors:(HYDataChartView *)chart;

//显示数值范围
- (CGRange)chartRange:(HYDataChartView *)chart;

//标记数值区域
- (CGRange)chartHighlightRangeInLine:(HYDataChartView *)chart;

//判断显示横线条
- (BOOL)chart:(HYDataChartView *)chart showHorizonLineAtIndex:(NSInteger)index;

//判断显示最大最小值
- (BOOL)chart:(HYDataChartView *)chart showMaxMinAtIndex:(NSInteger)index;

@end

@interface HYDataChartView : UIView

- (id)initWithFrame:(CGRect)rect dataSource:(id<HYChartDataSource>)dataSource ;

- (void)showInView:(UIView *)view;

- (void)strokeChart;

@end
