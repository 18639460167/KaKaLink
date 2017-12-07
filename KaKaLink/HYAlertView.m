//
//  HYAlertView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/17.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYAlertView.h"

@interface HYAlertView()
@property (nonatomic, strong) UIView *alertView;
@end
@implementation HYAlertView

+ (void)alertShow:(NSString *)okMessage cancelMessage:(NSString *)cancel message:(NSString *)content imageName:(NSString *)name okOrange:(BOOL)isOK messageIsOrange:(BOOL)isOrange handler:(void(^)(void))complete
{
    HYAlertView *view = [[HYAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds alertShow:okMessage cancelMessage:cancel message:content imageName:name okOrange:isOK messageIsOrange:isOrange cancel:nil handler:complete];
    [view show];
}

+ (void)saveLogo:(void (^)(void))cancel okAction:(void (^)(void))complete
{
    HYAlertView *view = [[HYAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds alertShow:LS(@"Save") cancelMessage:LS(@"BACK") message:LS(@"Please_Save_Logo") imageName:@"tuikuan" okOrange:YES messageIsOrange:NO cancel:cancel handler:complete];
    [view show];
}
- (instancetype)initWithFrame:(CGRect)frame alertShow:(NSString *)okMessage cancelMessage:(NSString *)cancel message:(NSString *)content imageName:(NSString *)name okOrange:(BOOL)isOK messageIsOrange:(BOOL)isOrange cancel:(void (^)(void))handler handler:(void(^)(void))complete
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        self.alertView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-WScale*250)/2, -HScale*155, WScale*250, HScale*155)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = WScale*10;
        self.alertView.layer.masksToBounds = YES;
        [self addSubview:self.alertView];
        
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        iconImage.image = IMAGE_NAME(name);
        [self.alertView addSubview:iconImage];
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(WScale*35, WScale*35));
            make.top.equalTo(self.alertView).offset(HScale*22);
            make.centerX.mas_equalTo(self.alertView.mas_centerX);
        }];
        
        UILabel *mesageLbl = [UILabel createCenterLbl:content fontSize:12 textColor:WHITE_COLOR fatherView:self.alertView];
        if (isOrange)
        {
            mesageLbl.textColor = [UIColor colorWithHexString:@"#00aee5"];
        }
        else
        {
            mesageLbl.textColor = [UIColor colorWithHexString:@"#646464"];
        }
        mesageLbl.adjustsFontSizeToFitWidth = YES;
        [mesageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.alertView.mas_centerX);
            make.left.equalTo(self.alertView).offset(WScale*8);
            make.height.mas_equalTo(WScale*14);
            make.top.equalTo(iconImage.mas_bottom).offset(HScale*10);
        }];
        
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIColor *okColor = [UIColor colorWithHexString:@"#00aee5"];
        UIColor *cancelColor = [UIColor sixFourColor];
        if (!isOK)
        {
            okColor = [UIColor sixFourColor];
            cancelColor = [UIColor colorWithHexString:@"#00aee5"];;
        }
        
        [okBtn setBtnTitle:okMessage sizeFont:WScale*15 sizeColor:okColor action:^{
            [UIView animateWithDuration:0.5 animations:^{
                self.alertView.frame = CGRectMake((SCREEN_WIDTH-WScale*250)/2, -HScale*150, WScale*250, HScale*150);
                self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            } completion:^(BOOL finished) {
                if (complete) {
                    complete();
                }
                [self removeFromSuperview];
            }];
        }];
        [self.alertView addSubview:okBtn];
        [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self.alertView);
            make.height.mas_equalTo(HScale*45);
            make.width.mas_equalTo(WScale*125-0.5);
        }];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectZero];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
        [self.alertView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.alertView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(1, HScale*45));
            make.bottom.equalTo(self.alertView);
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        HYWeakSelf;
        [cancelBtn setBtnTitle:cancel sizeFont:WScale*15 sizeColor:cancelColor action:^{
            HYStrongSelf;
            [UIView animateWithDuration:0.5 animations:^{
                sSelf.alertView.frame = CGRectMake((SCREEN_WIDTH-WScale*250)/2, -HScale*155, WScale*250, HScale*155);
                sSelf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            } completion:^(BOOL finished) {
                if (handler)
                {
                    handler();
                }
                [sSelf removeFromSuperview];
            }];
        }];
        [self.alertView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.alertView);
            make.height.mas_equalTo(HScale*45);
            make.width.mas_equalTo(WScale*125-0.5);
        }];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectZero];
        line.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
        [self.alertView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.alertView);
            make.bottom.equalTo(okBtn.mas_top);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

- (void)show
{
    UIWindow *windwo = [UIApplication sharedApplication].keyWindow;
    [windwo addSubview:self];
    
    [UIView animateWithDuration:0.5 delay:0.04 usingSpringWithDamping:0.5f initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alertView.frame = CGRectMake((SCREEN_WIDTH-WScale*250)/2, (SCREEN_HEIGHT-HScale*155)/2, WScale*250, HScale*155);
    } completion:nil];
}
- (void)hideAction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.frame = CGRectMake((SCREEN_WIDTH-WScale*250)/2, -HScale*155, WScale*250, HScale*155);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
