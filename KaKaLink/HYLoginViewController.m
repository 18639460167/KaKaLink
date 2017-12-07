//
//  HYLoginViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYLoginViewController.h"
#import "HYLoginViewModel.h"
#import "HYLoginView.h"

@interface HYLoginViewController ()

@property (nonatomic, strong) HYLoginView *loginView;

@end

@implementation HYLoginViewController
@synthesize loginView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self registerForKeyboardNotifications];
    [self setUpUI];
}

- (void)setUpUI
{
    self.bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.bgImage.image = IMAGE_NAME(@"login_Bg");
    self.bgImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:self.bgImage];
    
    [HYLoginView createLoginView:self];
}
-(void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
