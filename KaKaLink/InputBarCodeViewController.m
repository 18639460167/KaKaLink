//
//  InputBarCodeViewController.m
//  TutwoShop
//
//  Created by 章叶飞 on 16/1/5.
//  Copyright © 2016年 Tutwo. All rights reserved.
//

#import "InputBarCodeViewController.h"
#import "DefineHeard.h"

@interface InputBarCodeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonSwitchScanCode;
@property (weak, nonatomic) IBOutlet UIButton *buttonOk;
@property (weak, nonatomic) IBOutlet UITextField *textFieldBarCode;
- (IBAction)clickSwitchScanCode:(id)sender;
- (IBAction)clickOk:(id)sender;
@end

@implementation InputBarCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//     self.title = LS(@"Scan");
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Scan") didBackAction:nil];
    self.buttonSwitchScanCode.layer.cornerRadius = 5.0f;
    self.buttonOk.layer.cornerRadius = 5.0f;
    [self.buttonSwitchScanCode setTitle:LS(@"Switch_To_Scan") forState:UIControlStateNormal];
    [self.buttonSwitchScanCode setImage:[UIImage imageNamed:@"nav_scan.png"] forState:UIControlStateNormal];
    self.textFieldBarCode.placeholder = LS(@"Please_Enter_Code");
    [self.textFieldBarCode becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textFieldBarCode resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
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

- (IBAction)clickSwitchScanCode:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickOk:(id)sender
{
    if (self.clickHandler)
    {
        if (self.clickHandler(TRIM(self.textFieldBarCode.text)))
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
