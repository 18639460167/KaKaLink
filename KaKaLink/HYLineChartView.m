//
//  HYLineChartView.m
//  旋转
//
//  Created by tenpastnine-ios-dev on 17/1/13.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYLineChartView.h"
#import "HYChartLabel.h"
#import "HYStyle.h"
#import "DefineHeard.h"
@implementation HYLineChartView{
    NSHashTable *_chartLabelsForX;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.clipsToBounds = YES;
    }
    return self;
}
#pragma mark - 数据处理
- (void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}
- (void)setYLabels:(NSArray *)yLabels
{
    float max = 0.00;
    float min = 1000000000.00;
    for (NSArray * ary in yLabels)
    {
        for (NSString *valueString in ary)
        {
            float value = [valueString floatValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    max = max<6 ? 6:max;
    _yValueMin = 0;
    if ((int)max%10 ==0)
    {
        _yValueMax = max;
    }
    else
    {
        int b = (int)max/10;
        _yValueMax = 10*(b+1);
    }
    
    if (_chooseRange.max != _chooseRange.min) {
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    }
    CGFloat level = (_yValueMax-_yValueMin) /5.0;
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /5.0;
    
    for (int i=0; i<6; i++)
    {
        UILabel *label = [UILabel createRightLbl:@"" fontSize:12 textColor:[UIColor threeTwoColor] fatherView:self];
        label.backgroundColor = [UIColor clearColor];
        label.adjustsFontSizeToFitWidth = YES;
        label.frame = CGRectMake(0.0,chartCavanHeight-i*levelHeight+5, UUYLabelwidth-5, UULabelHeight);
        if (i==0)
        {
            label.text = @"0";
        }
        else
        {
            //            label.text = [NSString stringWithFormat:@"%d",(int)_yValueMax/5*i];
            label.text = [NSString stringWithFormat:@"%.0f",(level * i+_yValueMin)];
        }
    }
    if ([super respondsToSelector:@selector(setMarkRange:)]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(UUYLabelwidth, (1-(_markRange.max-_yValueMin)/(_yValueMax-_yValueMin))*chartCavanHeight+UULabelHeight, self.frame.size.width-UUYLabelwidth, (_markRange.max-_markRange.min)/(_yValueMax-_yValueMin)*chartCavanHeight)];
        view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        [self addSubview:view];
    }
    //画横线
    for (int i=0; i<6; i++) {
        if ([_showHorizonLine[i] integerValue]>0)
        {
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(UUYLabelwidth,UULabelHeight+i*levelHeight)];
            [path addLineToPoint:CGPointMake(self.frame.size.width,UULabelHeight+i*levelHeight)];
            [path closePath];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 0.5;
            [self.layer addSublayer:shapeLayer];
        }
    }
}
- (void)setXLabels:(NSArray *)xLabels
{
    if( !_chartLabelsForX ){
        _chartLabelsForX = [NSHashTable weakObjectsHashTable];
    }
    
    _xLabels = xLabels;
    CGFloat num = 0;
    if (xLabels.count>=20) {
        num=20.0;
    }else if (xLabels.count<=1){
        num=1.0;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = (self.frame.size.width - UUYLabelwidth)/num;
    
    for (int i=0; i<xLabels.count; i++) {
        NSString *labelText = xLabels[i];
        UILabel *label = [UILabel createCenterLbl:labelText fontSize:12 textColor:[UIColor threeTwoColor] fatherView:self];
        label.backgroundColor = [UIColor clearColor];
        label.adjustsFontSizeToFitWidth = YES;
        label.frame = CGRectMake(i * _xLabelWidth+UUYLabelwidth, self.frame.size.height - UULabelHeight, _xLabelWidth, UULabelHeight);
        
        [_chartLabelsForX addObject:label];
    }
    
    //画竖线
    for (int i=0; i<1; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,UULabelHeight)];
        [path addLineToPoint:CGPointMake(UUYLabelwidth+i*_xLabelWidth,self.frame.size.height-2*UULabelHeight)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 0.5;
        [self.layer addSublayer:shapeLayer];
    }
}
- (void)setColors:(NSArray *)colors
{
    _colors = colors;
}

- (void)setMarkRange:(CGRange)markRange
{
    _markRange = markRange;
}

- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}

- (void)setshowHorizonLine:(NSMutableArray *)showHorizonLine
{
    _showHorizonLine = showHorizonLine;
}
- (void)strokeChart
{
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childAry = _yValues[i];
        if (childAry.count==0) {
            return;
        }
        //获取最大最小位置
        CGFloat max = [childAry[0] floatValue];
        CGFloat min = [childAry[0] floatValue];
        CGFloat max_i = 0;
        CGFloat min_i = 0;
        
        for (int j=0; j<childAry.count; j++){
            CGFloat num = [childAry[j] floatValue];
            if (max<=num){
                max = num;
                max_i = j;
            }
            if (min>=num){
                min = num;
                min_i = j;
            }
        }
        
        //划线
        CAShapeLayer *_chartLine = [CAShapeLayer layer];
        _chartLine.lineCap = kCALineCapRound;
        _chartLine.lineJoin = kCALineJoinBevel;
        _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
        _chartLine.lineWidth   = 1.5;
        _chartLine.strokeEnd   = 0.0;
        [self.layer addSublayer:_chartLine];
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        CGFloat firstValue = [[childAry objectAtIndex:0] floatValue];
        CGFloat xPosition = (UUYLabelwidth + _xLabelWidth/2.0);
        CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
        
        
        float grade = ((float)firstValue-_yValueMin) / ((float)_yValueMax-_yValueMin);
        
        //第一个点
        BOOL isShowMaxAndMinPoint = YES;
        if (self.showMaxMinArray)
        {
            if ([self.showMaxMinArray[i] intValue]>0)
            {
                isShowMaxAndMinPoint = (max_i==0 || min_i==0)?NO:YES;
            }
            else
            {
                isShowMaxAndMinPoint = YES;
            }
        }
        [self addPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)
                 index:i
                isShow:isShowMaxAndMinPoint
                 value:childAry[0]];
        
        
        [progressline moveToPoint:CGPointMake(xPosition, chartCavanHeight - grade * chartCavanHeight+UULabelHeight)];
        [progressline setLineWidth:2.0];
        [progressline setLineCapStyle:kCGLineCapRound];
        [progressline setLineJoinStyle:kCGLineJoinRound];
        NSInteger index = 0;
        for (NSString * valueString in childAry)
        {
            
            float grade =([valueString floatValue]-_yValueMin) / ((float)_yValueMax-_yValueMin);
            if (index != 0)
            {
                
                CGPoint point = CGPointMake(xPosition+index*_xLabelWidth, chartCavanHeight - grade * chartCavanHeight+UULabelHeight);
                [progressline addLineToPoint:point];
                
                BOOL isShowMaxAndMinPoint = YES;
                if (self.showMaxMinArray) {
                    if ([self.showMaxMinArray[i] intValue]>0) {
                        isShowMaxAndMinPoint = (max_i==index || min_i==index)?NO:YES;
                    }else{
                        isShowMaxAndMinPoint = YES;
                    }
                }
                [progressline moveToPoint:point];
                [self addPoint:point
                         index:i
                        isShow:isShowMaxAndMinPoint
                         value:valueString];
            }
            index += 1;
        }
        
        _chartLine.path = progressline.CGPath;
        _chartLine.strokeColor = [UIColor colorWithHexString:@"#00aee5"].CGColor;
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = childAry.count*0.3;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartLine.strokeEnd = 1.0;
    }
}

- (void)addPoint:(CGPoint)point index:(NSInteger)index isShow:(BOOL)isHollow value:(NSString *)value
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 5, 5)];
    view.center = point;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 2.5;
    view.layer.borderColor = [UIColor colorWithHexString:@"#00aee5"].CGColor;
    
    view.backgroundColor = [UIColor colorWithHexString:@"#00aee5"];
    CGFloat x;
    if (point.y-UULabelHeight*2<0)
    {
        x= point.y+UULabelHeight;
    }
    else
    {
        x=  point.y-UULabelHeight*2;
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x-UUTagLabelwidth/2.0, x, UUTagLabelwidth, UULabelHeight)];
    label.font = FONTSIZE(10);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = BLACK_COLOR;
    label.text = value;
    [self addSubview:label];
    [self addSubview:view];
}

- (NSArray *)chartLabelsForX
{
    return [_chartLabelsForX allObjects];
}



@end
