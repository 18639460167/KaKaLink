//
//  HYFirstLeadingView.m
//  KaKaLink
//
//  Created by Black on 17/7/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYFirstLeadingView.h"

@implementation HYFirstLeadingView

+ (void)showLeading:(noParameterBlock)complete
{
    NSString *str = READ_IS_FIRST;
    if ([str isEqualToString:@""])
    {
        HYFirstLeadingView *view = [[HYFirstLeadingView alloc]initWithFrame:[UIScreen mainScreen].bounds leading:complete];
        [view show];
    }
    else
    {
        if (complete)
        {
            complete();
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame leading:(noParameterBlock)complete
{
    if (self = [super initWithFrame:frame])
    {
        SET_USER_DEFAULT(@"商户第一次登陆", SHOP_IS_FIRSTLOGIN);
        SYN_USER_DEFAULT;
        
        index = 0;
        self.handler = complete;
        imageArray = @[[@"check" startName],[@"sale" startName],[@"kaquan" startName],[@"setting" startName]];
        
        self.startImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.startImageView.userInteractionEnabled = YES;
//        self.startImageView.contentMode =  UIViewContentModeScaleAspectFill;
        self.startImageView.image = IMAGE_NAME(imageArray[index]);
        [self addSubview:self.startImageView];
        [self.startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeAction)];
        [self.startImageView addGestureRecognizer:tap];
    }
    return self;
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)changeAction
{
    if (index==imageArray.count-1)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (self.handler)
            {
                self.handler();
            }
        }];
        
    }
    else
    {
        index++;
        self.startImageView.image = IMAGE_NAME(imageArray[index]);
    }
}
@end
