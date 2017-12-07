//
//  HYLoginView.m
//  TourGuidShop
//
//  Created by Black on 17/4/28.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYLoginView.h"

@implementation HYLoginView
@synthesize userText;
@synthesize passText;

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == userText)
    {
        [passText becomeFirstResponder];
    }
    else
    {
        [self loginAction];
    }
    return YES;
}

#pragma mark niticefication
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:)name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardShow:(NSNotification*)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    if ((SCREEN_HEIGHT - height) < HScale*390)
    {
        CGFloat mHeight = height - (SCREEN_HEIGHT - HScale*390);
        CGRect rect = self.currentVC.bgImage.frame;
        rect.origin.y = -mHeight-HScale*5;
        [UIView animateWithDuration:0.3 animations:^{
            self.currentVC.bgImage.frame = rect;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.currentVC.bgImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
}

- (void)keyboardBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.currentVC.bgImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    
}

+ (void)createLoginView:(HYLoginViewController *)vc
{
    HYLoginView *loginView = [[HYLoginView alloc]initWithFrame:CGRectZero vc:vc];
    [vc.bgImage addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vc.bgImage).offset(WScale*25);
        make.height.mas_equalTo(HScale *160);
        make.centerX.mas_equalTo(vc.bgImage.mas_centerX);
        make.top.equalTo(vc.bgImage).offset(HScale*230);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame vc:(HYLoginViewController *)vc
{
    if (self = [super initWithFrame:frame])
    {
        [self registerForKeyboardNotifications];
        self.backgroundColor = [UIColor clearColor];
        self.currentVC = vc;
        
        UIView *topView = [HYStyle createView:WHITE_COLOR];
        topView.layer.cornerRadius = WScale*5;
        topView.layer.masksToBounds = YES;
        [self addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(HScale*90);
        }];
        
        UIView *nameView = [HYStyle createView:WHITE_COLOR];
        [topView addSubview:nameView];
        [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(topView);
            make.height.mas_equalTo(HScale*45);
        }];
        
        UIImageView *nameImage = [HYStyle createImage:@"user_icon"];
        [nameView addSubview:nameImage];
        [nameImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(HScale*23, HScale*25));
            make.centerY.mas_equalTo(nameView.mas_centerY);
            make.left.equalTo(nameView).offset(WScale*10);
        }];
        
        userText = [[UITextField alloc]initWithFrame:CGRectZero];
        userText.clearButtonMode = UITextFieldViewModeAlways;
        userText.textColor = [UIColor threeTwoColor];
        userText.placeholder = LS(@"Login_Input_Name");
        userText.delegate = self;
        userText.font = [UIFont systemFontOfSize:WScale*15];
        [userText controlLength:10];
        [nameView addSubview:userText];
        [userText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(nameView);
            make.right.equalTo(nameView).offset(WScale*-5);
            make.left.equalTo(nameImage.mas_right).offset(WScale*8);
        }];
        
        
        UIView *passView = [HYStyle createView:WHITE_COLOR];
        [topView addSubview:passView];
        [passView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(topView);
            make.height.mas_equalTo(HScale*45);
        }];
        
        UIImageView *passImage = [HYStyle createImage:@"pass_icon"];
        [passView addSubview:passImage];
        [passImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(HScale*23, HScale*25));
            make.centerY.mas_equalTo(passView.mas_centerY);
            make.left.equalTo(passView).offset(WScale*10);
        }];
        
        passText = [[UITextField alloc]initWithFrame:CGRectZero];
        passText.clearButtonMode = UITextFieldViewModeAlways;
        passText.textColor = [UIColor threeTwoColor];
        passText.placeholder = LS(@"Login_Input_Pass");
        passText.secureTextEntry = YES;
        passText.delegate = self;
        [passText setReturnKeyType:UIReturnKeyDone];
        passText.font = [UIFont systemFontOfSize:WScale*15];
        [passText controlLength:8];
        [passView addSubview:passText];
        [passText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(passView);
            make.right.equalTo(passView).offset(WScale*-5);
            make.left.equalTo(passImage.mas_right).offset(WScale*8);
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor colorWithHexString:@"#979797"]];
        [topView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(topView.mas_centerY);
            make.right.equalTo(topView);
            make.left.equalTo(topView).offset(HScale*25+WScale*15);
            make.height.mas_equalTo(0.5);
        }];
        
        HYWeakSelf;
        UIButton *loginBtn = [UIButton createNoLayerBtn:LS(@"Login") titColor:WHITE_COLOR bgColor:[UIColor subjectColor] font:18 btnAction:^{
            HYStrongSelf;
            [sSelf loginAction];
        }];
        [loginBtn racIsEnable:userText textLength:4 passTxt:passText passLength:2 backColor:[UIColor subjectColor]];
        [self addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(HScale*45);
        }];
    }
    return self;
}

- (void)loginAction
{
    if ([userText.text isEqualToString:@""]||[passText.text isEqualToString:@""])
    {
        [HYProgressHUD showLoading:LS(@"Login_Input_No_Data") time:ErrorInfo_ShowTime currentView:self.currentVC.view];
        return;
    }
    [self endEditing:YES];
    [HYProgressHUD showLoading:@"" rootView:self.currentVC.view];
    [HYLoginViewModel loginWithUserName:userText.text withPassword:passText.text withComplete:^(NSString *status) {
        
        [HYProgressHUD handlerError:status currentVC:self.currentVC loginHandler:^{
            if (self.currentVC.isHome)
            {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                HYTabBarViewController *tab = [[HYTabBarViewController alloc]init];
                window.rootViewController = tab;
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_orderChange object:self];
                [self.currentVC.navigationController dismissViewControllerAnimated:YES completion:^{
                    if (self.currentVC.loginHandler)
                    {
                        self.currentVC.loginHandler();
                    }
                }];
            }
        }];
    }];
}

@end
