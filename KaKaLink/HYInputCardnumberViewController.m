//
//  HYInputCardnumberViewController.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYInputCardnumberViewController.h"

@interface HYInputCardnumberViewController ()

@end

@implementation HYInputCardnumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
}

- (void)setUpUI
{
    self.view.backgroundColor = [UIColor fSixColor];
    CGFloat width = WScale*5 + [HYStyle getWidthWithTitle:LS(@"Vertify_Record") font:10];
    HYCardHeardButton *recordBtn =  [HYCardHeardButton createHeardBtn:LS(@"Vertify_Record")  imageName:@"card_qs" fatherView:nil];
    recordBtn.frame = CGRectMake(0, 0, width, HScale*25+WScale*10);
    HYWeakSelf;
    [[recordBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        HYStrongSelf;
        [sSelf pushAction:[HYVertifyRecordViewController new]];
    }];
    [self LoadNavigation:recordBtn navStyle:HYNavitionStyle_Normal title:LS(@"Card_Verification") didBackAction:nil];
    
    [HYInputNumberView createInputView:self];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
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
