//
//  HYQrCodeViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYQrCodeViewController.h"
#import "HYCodeView.h"

@interface HYQrCodeViewController ()
{
    UIScrollView *scrollView;
    NSInteger currentIndex;
}

@end

@implementation HYQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI
{
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Qr_Code") didBackAction:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    scrollView.scrollEnabled = NO;
    scrollView.bounces=NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize=CGSizeMake(WScale*550/2*[[HYShopMessage sharedModel] getShopListArray].count, 0);
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(HScale*194/2+NAV_HEIGT);
        make.size.mas_equalTo(CGSizeMake(WScale*550/2, HScale*300));
    }];
    
    for (int i=0; i<[[HYShopMessage sharedModel] getShopListArray].count; i++)
    {
        HYCodeView *codeView = [[HYCodeView alloc]initWithFrame:CGRectMake(WScale*550/2*i, 0, WScale*550/2, HScale*300)];
        codeView.tag = i+1;
        [codeView bindModel:[[HYShopMessage sharedModel] getShopListArray][i]];
        codeView.numberLbl.text = [NSString stringWithFormat:@"%d/%ld",i+1,(long)[[[HYShopMessage sharedModel] getShopListArray] count]];
        [scrollView addSubview:codeView];
    }
    
    UIButton *leftBtn = [UIButton buttonWithType:0];
    [leftBtn setImage:IMAGE_NAME(@"code_left") forState:0];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (currentIndex==0)
        {
            return ;
        }
        else
        {
            currentIndex --;
            scrollView.contentOffset=CGPointMake(WScale*550/2*currentIndex, 0);
        }
    }];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(scrollView.mas_centerY);
        make.left.equalTo(self.view).offset(WScale*10);
        make.size.mas_equalTo(CGSizeMake(WScale*30, HScale*40));
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:0];
    [rightBtn setImage:IMAGE_NAME(@"code_right") forState:0];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (currentIndex==[[HYShopMessage sharedModel]getShopListArray].count-1)
        {
            return ;
        }
        else
        {
            currentIndex ++;
            scrollView.contentOffset=CGPointMake(WScale*550/2*currentIndex, 0);
        }
    }];
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(scrollView.mas_centerY);
        make.right.equalTo(self.view).offset(WScale*-10);
        make.size.mas_equalTo(CGSizeMake(WScale*30, HScale*40));
    }];
    UILabel *titleLbl = [UILabel createCenterLbl:LS(@"Change_Qr") fontSize:12 textColor:[UIColor nineSixColor] fatherView:self.view];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(scrollView.mas_bottom).offset(HScale*17);
        make.height.mas_equalTo(HScale*14);
    }];
    
    UIButton *saveBtn = [UIButton createBgImageBtn:LS(@"Save_Photo") font:18 bgColor:@"save_bg" height:HYHeight(40) btnAction:^{
        HYCodeView *codeView =(HYCodeView *)[scrollView viewWithTag:currentIndex+1];
        UIImageWriteToSavedPhotosAlbum(codeView.coedImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    saveBtn.enabled = YES;
    if ([[HYShopMessage sharedModel] getShopListArray].count<1)
    {
        saveBtn.enabled = NO;
    }
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WScale*550/2, HScale*40));
        make.top.equalTo(titleLbl.mas_bottom).offset(HScale*55);
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil)
    {
        [HYLoadingView showLoading:LS(@"Save_Success")];
    }
    else
    {
        [HYLoadingView showLoading:LS(@"Save_Fail")];
    }
    
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
