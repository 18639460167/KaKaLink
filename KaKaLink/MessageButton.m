//
//  MessageButton.m
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/13.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import "MessageButton.h"
@interface MessageButton()
@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, assign) BOOL isAnimation; // 是否包含动画
@end

@implementation MessageButton

+ (MessageButton *)shareMessageButton
{
    static dispatch_once_t once;
    static MessageButton *shareView;
    dispatch_once(&once,^{
        CGFloat width = [HYStyle getWidthWithTitle:LS(@"Message") font:12];
        shareView = [[MessageButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-width-WScale*10, HScale*40, width, HScale*40)];
        shareView.messageNumber = 0;
    });
    return shareView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *image = [UIImageView new];
        image.image = IMAGE_NAME(@"message");
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(WScale*25, HScale*21));
        }];
        
        UILabel *messageLbl = [UILabel createCenterLbl:LS(@"Message") fontSize:12 textColor:WHITE_COLOR fatherView:self];
        messageLbl.adjustsFontSizeToFitWidth = YES;
        [messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(image.mas_bottom).offset(HScale*4);
            make.height.mas_equalTo(HScale*14);
        }];
        [self addSubview:messageLbl];
        self.isAnimation = NO;
        
        self.messageView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-HScale*10,0, HScale*8, HScale*8)];
        self.messageView.layer.cornerRadius = HScale*4;
        self.messageView.backgroundColor = [UIColor redColor];
        self.messageView.layer.masksToBounds = YES;
        self.messageView.hidden=YES;
        [image addSubview:self.messageView];
        [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(HScale*8, HScale*8));
            make.top.equalTo(image);
            make.right.equalTo(image).offset(HScale*5);
        }];
    }
    return self;
}

+ (void)showInView:(UIView *)view btnAction:(btnAction)handler
{
    [[MessageButton shareMessageButton] showIniew:view handler:handler];
}

- (void)showIniew:(UIView *)view handler:(btnAction)action
{
    [view addSubview:[MessageButton shareMessageButton]];
    [[MessageButton shareMessageButton] addTarget:self action:@selector(messageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [MessageButton shareMessageButton].myAction = action;
}

- (void)messageBtnAction
{
    if ([MessageButton shareMessageButton].myAction)
    {
        [MessageButton shareMessageButton].myAction();
    }
}

- (void)setMessageNumber:(NSInteger)messageNumber
{
    _messageNumber = messageNumber;
    if (messageNumber>0)
    {
        self.messageView.hidden = NO;
        if (self.isAnimation == NO)
        {
            [self redAnimation];
        }
        self.isAnimation = YES;
        [self redAnimation];
    }
    else
    {
        self.messageView.hidden = YES;
        self.isAnimation = NO;
        [self.messageView.layer removeAllAnimations];
    }
}
- (void)redAnimation
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(1.2);
    animation.toValue = @(0.7);
    animation.duration = 1;
    animation.autoreverses = YES;
    animation.repeatCount = MAX_CANON;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.messageView.layer addAnimation:animation forKey:@"scale"];
}

@end
