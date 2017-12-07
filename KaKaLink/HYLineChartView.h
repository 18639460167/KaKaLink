//
//  HYLineChartView.h
//  旋转
//
//  Created by tenpastnine-ios-dev on 17/1/13.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUChartConst.h"


@interface HYLineChartView : UIView

@property (nonatomic, strong) NSArray *xLabels;
@property (nonatomic, strong) NSArray *yLabels;
@property (nonatomic, strong) NSArray *yValues;
@property (nonatomic, strong) NSArray *colors;

@property (strong, nonatomic) NSMutableArray *showHorizonLine;
@property (strong, nonatomic) NSMutableArray *showMaxMinArray;
@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) CGFloat yValueMin;
@property (nonatomic) CGFloat yValueMax;
@property (nonatomic, assign) CGRange markRange;

@property (nonatomic, assign) CGRange chooseRange;

-(void)strokeChart;

- (NSArray *)chartLabelsForX;

@end
