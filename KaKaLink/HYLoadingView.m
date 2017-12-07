//
//  HYLoadingView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/26.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYLoadingView.h"

@interface HYLoadingView()
{
    UIView *bgView;
}
@property (nonatomic, copy) loadBack block;
@property (nonatomic, assign) CGFloat animationDuration;
@end
@implementation HYLoadingView

+ (void)showLoading:(NSString *)message
{
    HYLoadingView *view = [[HYLoadingView alloc]initWithFrame:[UIScreen mainScreen].bounds Loading:message];
    [view show];
}

#pragma mark - 包含键盘
+ (void)showLoading:(NSString *)message height:(CGFloat)heigth handler:(loadBack)complete
{
    HYLoadingView *view = [[HYLoadingView alloc]initWithFrame:[UIScreen mainScreen].bounds Loading:message handler:complete heigth:heigth];
    [view show];
}
+ (void)showLoading:(NSString *)message animationDuration:(CGFloat)duration
{
    HYLoadingView *view = [[HYLoadingView alloc]initWithFrame:[UIScreen mainScreen].bounds Loading:message];
    view.animationDuration = duration;
    [view show];
}

+ (void)showLoading:(NSString *)message handler:(loadBack)complete
{
    HYLoadingView *view = [[HYLoadingView alloc]initWithFrame:[UIScreen mainScreen].bounds Loading:message handler:complete heigth:0];
    [view show];
}
- (instancetype)initWithFrame:(CGRect)frame Loading:(NSString *)message handler:(loadBack)complete heigth:(CGFloat)height;
{
    if (self = [super initWithFrame:frame])
    {
        self.block = complete;
        [self setUpUI:message height:height];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame Loading:(NSString *)message
{
    if (self =  [super initWithFrame:frame])
    {
        [self setUpUI:message height:0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Loading:(NSString *)message heigth:(CGFloat)height
{
    if (self =  [super initWithFrame:frame])
    {
        [self setUpUI:message height:height];
    }
    return self;
}
- (void)setUpUI:(NSString *)message height:(CGFloat)height
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    bgView = [HYStyle createView:[BLACK_COLOR colorWithAlphaComponent:0.8]];
    bgView.layer.cornerRadius = WScale*10;
    bgView.layer.masksToBounds = YES;
    bgView.alpha = 0.1;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WScale*356/2, HScale*212/2));
        if (height <= (SCREEN_HEIGHT/2.0-HScale*212/2.0))
        {
            make.centerY.mas_equalTo(self.mas_centerY);
        }
        else
        {
            make.bottom.equalTo(self).offset(-height-HScale*5);
        }
    }];
    
    UILabel *messageLbl = [UILabel createCenterLbl:message fontSize:18 textColor:WHITE_COLOR fatherView:bgView];
    messageLbl.adjustsFontSizeToFitWidth  =YES;
    messageLbl.numberOfLines = 0;
    [bgView addSubview:messageLbl];
    [messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bgView);
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.left.equalTo(bgView).offset(WScale*5);
    }];

}

- (void)show
{
    CGFloat animation = 1.5;
    if (self.animationDuration>0)
    {
        animation = self.animationDuration;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
      //  bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        bgView.alpha = 1;
    }completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hide];
        });
    }];
}
- (void)hide
{
    [UIView animateWithDuration:0.4 animations:^{
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
//        bgView.alpha = 0.1;
    } completion:^(BOOL finished) {
        if (self.block)
        {
            self.block();
        }
        [self removeFromSuperview];
    }];
}
@end
