//
//  HYPassView.m
//  ZSAlert
//
//  Created by tenpastnine-ios-dev on 17/1/11.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYPassView.h"
#import "LZProgressView.h"
#import "HYWithdrawViewModel.h"

@interface HYPassView()<UITextFieldDelegate>
{
    UIView *bgView;
    UITextField *myTextField;
    
    NSMutableArray *dataSource;
    
    CGFloat bgViewHeight;
    
    UIView *animationView;
    
    LZProgressView *progressView;
    
    NSString *orderTransId;
    NSString *order_message;
    NSString *order_money;
    NSString *order_refund_Type;
    NSString *refund_reason;
    
    NSString *requestType; // 请求类型
    NSString *requestStaus; // 请求状态
}
@property (nonatomic, copy) refundSuccess handler;
@end

@implementation HYPassView


+ (void)createView:(NSString *)message money:(NSString *)money trans_id:(NSString *)trans_id handler:(refundSuccess)complete
{
    HYPassView *view= [[HYPassView alloc]initWithFrame:[UIScreen mainScreen].bounds createView:message money:money trans_id:trans_id handler:complete];
    [view show];
}
+ (void)createView:(NSString *)message refubd_Type:(NSString *)refund_Type money:(NSString *)money refund_reason:(NSString *)reason trans_id:(NSString *)trans_id handler:(refundSuccess)complete
{
    HYPassView *view = [[HYPassView alloc]initWithFrame:[UIScreen mainScreen].bounds createView:message refubd_Type:refund_Type money:money refund_reason:reason trans_id:trans_id handler:complete];
    [view show];
}
#pragma mark - 提现
+ (void)createView:(NSString *)message withdrawMoney:(NSString *)money handler:(refundSuccess)complete
{
    HYPassView *view = [[HYPassView alloc]initWithFrame:[UIScreen mainScreen].bounds createView:message withdrawMoney:money handler:complete];
    [view show];
}
- (instancetype)initWithFrame:(CGRect)frame createView:(NSString *)message withdrawMoney:(NSString *)money handler:(refundSuccess)complete
{
    if (self = [super initWithFrame:frame])
    {
         dataSource = [[NSMutableArray alloc]init];
        requestType = @"3";
        order_money = money;
        order_message = message;
        self.handler = complete;
        [self setUpUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame createView:(NSString *)message money:(NSString *)money trans_id:(NSString *)trans_id handler:(refundSuccess)complete
{
    if (self = [super initWithFrame:frame])
    {
        orderTransId = trans_id;
        dataSource = [[NSMutableArray alloc]init];
        order_message = message;
        order_money = money;
        requestType = @"1";
        self.handler = complete;
        [self setUpUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame createView:(NSString *)message refubd_Type:(NSString *)refund_Type money:(NSString *)money refund_reason:(NSString *)reason trans_id:(NSString *)trans_id handler:(refundSuccess)complete
{
    if (self = [super initWithFrame:frame])
    {
        orderTransId = trans_id;
        dataSource = [[NSMutableArray alloc]init];
        order_message = message;
        order_money = money;
        order_refund_Type  =refund_Type;
        refund_reason = reason;
        requestType = @"2";
        self.handler = complete;
        [self setUpUI];
        
    }
    return self;
}

#pragma mark- createView
- (void)setUpUI
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    bgView = [HYStyle createView:WHITE_COLOR];
    bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HScale*372/2);
    [self addSubview:bgView];
    
    HYWeakSelf;
    UIButton *cancelBtn = [UIButton buttonWithType:0];
    [cancelBtn setImage:IMAGE_NAME(@"pass_cancel") forState:0];
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        HYStrongSelf;
        animationView.hidden = YES;
        [myTextField resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HScale*372/2);
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
    UILabel *titleLbl = [UILabel createCenterLbl:LS(@"Input_Pay_Pass") fontSize:18 textColor:[UIColor sixFourColor] fatherView:bgView];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.top.equalTo(bgView).offset(HScale*20);
        make.height.mas_equalTo(HScale*21);
    }];
    UIView *passView = [[UIView alloc]initWithFrame:CGRectZero];
    passView.layer.borderWidth = 0.5;
    passView.layer.borderColor =[UIColor nineSixColor].CGColor;
    passView.layer.cornerRadius = WScale*4;
    passView.layer.masksToBounds = YES;
    passView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    [bgView addSubview:passView];
    [passView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.left.equalTo(bgView).offset(HScale*73/2);
        make.height.mas_equalTo(HScale*51);
        make.top.equalTo(titleLbl.mas_bottom).offset(HScale*27/2);
    }];
    
    UILabel *messageLbl = [UILabel createCenterLbl:order_message fontSize:15 textColor:[UIColor subjectColor] fatherView:bgView];
    [messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.left.equalTo(bgView).offset(WScale*8);
        make.height.mas_equalTo(HScale*20);
        make.top.equalTo(passView.mas_bottom).offset(HScale*15);
    }];
    
    UILabel *moneyLbl = [UILabel createCenterLbl:[order_money addMoneyUnit] fontSize:15 textColor:[UIColor subjectColor] fatherView:bgView];
    [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX);
        make.left.equalTo(bgView).offset(WScale*8);
        make.height.mas_equalTo(HScale*20);
        make.top.equalTo(messageLbl.mas_bottom).offset(HScale*10);
    }];
    
    
    animationView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HScale*372/2)];
    animationView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    animationView.hidden = YES;
    [self addSubview:animationView];
    
    
    
    myTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    myTextField.keyboardType = UIKeyboardTypeNumberPad;
    myTextField.hidden = YES;
    myTextField.delegate = self;
    myTextField.backgroundColor = [WHITE_COLOR colorWithAlphaComponent:0];
    [myTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [passView addSubview:myTextField];
    [myTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(passView);
    }];
    
    float width = (SCREEN_WIDTH-WScale*73)/6;
    for (int i=0; i<6; i++)
    {
        UITextField *padLbl = [[UITextField alloc]initWithFrame:CGRectMake(width*i,0 , width, HScale*51)];
        padLbl.textAlignment = NSTextAlignmentCenter;
        padLbl.enabled = NO;
        padLbl.backgroundColor = [WHITE_COLOR colorWithAlphaComponent:0];
        padLbl.secureTextEntry = YES;
        padLbl.textAlignment = NSTextAlignmentCenter;
        padLbl.font = FONTSIZE(20);
        [passView addSubview:padLbl];
        [dataSource addObject:padLbl];
    }
    
    for (int i=0; i<5; i++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(width*(i+1), 0, 0.5, HScale*51)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [passView addSubview:lineView];
    }
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)textChange:(UITextField *)txt
{
    NSString *password = txt.text;
    for (int i=0; i<dataSource.count; i++)
    {
        UITextField *pwdtx = [dataSource objectAtIndex:i];
        pwdtx.text = @"";
        if (i < password.length)
        {
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdtx.text = pwd;
        }
    }
    if (txt.text.length == 6)
    {
        animationView.hidden = NO;
        [myTextField resignFirstResponder];
        NSArray *colors = @[
                            [UIColor subjectColor]
                            ];
        progressView = [[LZProgressView alloc] initWithFrame:CGRectMake((animationView.frame.size.width-HScale*50)/2, (animationView.frame.size.height-HScale*50)/2, HScale*50, HScale*50) andLineWidth:2.0 andLineColor:colors];
        [animationView addSubview:progressView];
        [progressView startAnimation];
        if ([requestType isEqualToString:@"1"])
        {
            [HYTransViewModel setCancelRefund:orderTransId pass:txt.text handler:^(NSString *status) {
                requestStaus  =status;
                if ([status isEqualToString:REQUEST_SUCCESS])
                {
                    [self requestSuccess];
                }
                else
                {
                    [self requestFaild];
                }
            }];
        }
        else if([requestType isEqualToString:@"2"])
        {
            [HYTransViewModel setOrderRefund:orderTransId refund_reason_type:order_refund_Type reason:refund_reason pass:txt.text handler:^(NSString *status) {
                requestStaus = status;
                if ([status isEqualToString:REQUEST_SUCCESS])
                {
                    [self requestSuccess];
                }
                else
                {
                    [self requestFaild];
                }
            }];
        }
        else if ([requestType isEqualToString:@"3"])
        {
            [HYWithdrawViewModel shopWithdrawMoney:order_money pass:txt.text complete:^(NSString *status) {
                requestStaus = status;
                if ([status isEqualToString:REQUEST_SUCCESS])
                {
                    [self requestSuccess];
                }
                else
                {
                    [self requestFaild];
                }
            }];
        }
      
    }
}
- (void)requestResult
{
        [progressView requestSuccess];
        bgViewHeight = 0;
        [self performSelector:@selector(successAnimation) withObject:nil afterDelay:1];
     
}

#pragma mark - 请求结果
- (void)requestFaild
{
    [self performSelector:@selector(requestResultFaild) withObject:self afterDelay:3];
}
- (void)requestResultFaild
{
    [progressView requestFail];
    [self performSelector:@selector(animationHide) withObject:nil afterDelay:1];
}
- (void)requestSuccess
{

    [self performSelector:@selector(requestResult) withObject:nil afterDelay:1];
}
- (void)successAnimation
{
    animationView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HScale*372/2);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
    }completion:^(BOOL finished) {
        if (self.handler)
        {
            self.handler();
        }
        [self removeFromSuperview];
    }];
}
- (void)animationHide
{
    if ([requestStaus isEqualToString:SHOP_NO_LOGIN])
    {
        animationView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, HScale*372/2);
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            
        }completion:^(BOOL finished) {
            
            [HYStyle handlerError:requestStaus];
            [self removeFromSuperview];
        }];
    }
    else
    {
        animationView.hidden = YES;
        myTextField.text = @"";
        [self textChange:myTextField];
        [progressView removeFromSuperview];
        bgViewHeight = 0;
        [myTextField becomeFirstResponder];
    }
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
    bgViewHeight = HScale*372/2+height;
    [UIView animateWithDuration:0.3 animations:^{
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT-(HScale*372/2)-height, SCREEN_WIDTH, (HScale*372/2)+height);
        animationView.frame = CGRectMake(0, SCREEN_HEIGHT-bgViewHeight, SCREEN_WIDTH, bgViewHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (bgViewHeight>(HScale*372/2))
    {
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT-bgViewHeight, SCREEN_WIDTH, bgViewHeight);
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, (HScale*372/2));
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [myTextField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    }
    else if(string.length == 0)
    {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= 6)
    {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        return NO;
    }
    else
    {
        return YES;
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
