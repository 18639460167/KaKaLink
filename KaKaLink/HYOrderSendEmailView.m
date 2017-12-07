//
//  HYOrderSendEmailView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/9.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYOrderSendEmailView.h"

@interface HYOrderSendEmailView()<UITextFieldDelegate>
{
    UITextField *emailTxt;
    UIView *bgView;
    CGFloat bgViewHeight;
}
@property (nonatomic, copy) sendList block;
@end
@implementation HYOrderSendEmailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)createView:(sendList)compltet
{
    HYOrderSendEmailView *view = [[HYOrderSendEmailView alloc]initWithFrame:[UIScreen mainScreen].bounds createView:compltet];
    [view show];
}
- (instancetype)initWithFrame:(CGRect)frame createView:(sendList)compltet
{
    if (self = [super initWithFrame:frame])
    {
        self.block = compltet;
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0];
        
        bgView = [HYStyle createView:WHITE_COLOR];
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HScale*130);
        [self addSubview:bgView];
        
        HYWeakSelf;
        UIButton *cancelBtn = [UIButton buttonWithType:0];
        [cancelBtn setImage:IMAGE_NAME(@"pass_cancel") forState:0];
        [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            HYStrongSelf;
            [emailTxt resignFirstResponder];
            [UIView animateWithDuration:0.3 animations:^{
                bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HScale*130);
                sSelf.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                
            }completion:^(BOOL finished) {
                [sSelf removeFromSuperview];
            }];
        }];
        [bgView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView).offset(-WScale*10);
            make.top.equalTo(bgView).offset(HScale*10);
            make.size.mas_equalTo(CGSizeMake(HScale*20, HScale*20));
        }];
        
        UILabel *titleLbl = [UILabel createCenterLbl:LS(@"Get_Order_Email") fontSize:18 textColor:[UIColor sixFourColor] fatherView:bgView];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(bgView);
            make.top.equalTo(bgView).offset(HScale*20);
            make.height.mas_equalTo(HScale*21);
        }];
        
        UIView *lineView = [HYStyle createView:WHITE_COLOR];
        lineView.layer.borderColor = [UIColor eOneColor].CGColor;
        lineView.layer.borderWidth = 0.5;
        lineView.layer.cornerRadius = WScale*2;
        [bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView.mas_centerX);
            make.left.equalTo(bgView).offset(WScale*30);
            make.height.mas_equalTo(HScale*40);
            make.top.equalTo(titleLbl.mas_bottom).offset(HScale*20);
        }];
        emailTxt  = [[UITextField alloc]initWithFrame:CGRectZero];
        emailTxt.delegate  =self;
        emailTxt.returnKeyType = UIReturnKeySend;
        emailTxt.font= FONTSIZE(16);
        emailTxt.placeholder = LS(@"Enter_Email");
        emailTxt.text = READ_SEND_EMAIL;
        emailTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        [lineView addSubview:emailTxt];
        [emailTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(lineView);
            make.left.equalTo(lineView).offset(WScale*5);
            make.centerX.mas_equalTo(lineView.mas_centerX);
        }];
        
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    self.frame = [UIScreen mainScreen].bounds;
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    bgViewHeight = HScale*130+height;
    [UIView animateWithDuration:0.3 animations:^{
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT-(HScale*130)-height, SCREEN_WIDTH, (HScale*130)+height);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (bgViewHeight>(HScale*130))
    {
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT-bgViewHeight, SCREEN_WIDTH, bgViewHeight);
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, (HScale*130));
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        return NO;
    }
    else if ([textField.text rangeOfString:@"@"].location == NSNotFound)
    {
        [HYStyle showAlert:LS(@"Enter_Correct_Email")];
        return NO;
    }
    else
    {
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HScale*130);
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        }completion:^(BOOL finished) {
            if (self.block)
            {
                self.block(textField.text);
            }
            [self removeFromSuperview];
        }];
      
    }
    return YES;
}
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [emailTxt becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
