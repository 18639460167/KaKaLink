//
//  HYUserHelpViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYUserHelpViewController.h"
@interface HYUserHelpViewController ()<UIWebViewDelegate>
{
    UIWebView *hyWebView;
    HYWebProgressLayer *progressLayer;
}

@end

@implementation HYUserHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI
{
    HYWeakSelf;
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Usual_Problems") didBackAction:^{
        if ([hyWebView canGoBack])
        {
            [hyWebView goBack];
        }
        else
        {
            [wSelf popAction];
        }
    }];
    
    hyWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    hyWebView.backgroundColor = [UIColor whiteColor];
    hyWebView.delegate = self;
    [self.view addSubview:hyWebView];
    [hyWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navBarView.mas_bottom);
    }];
    [self loadData];
    
}
- (void)loadData
{
    NSURL *url = [NSURL URLWithString:[NSString getProblmeUrl]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [hyWebView loadRequest:request];
}
#pragma mark -webView delegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [progressLayer finishedLoad];
     [HYLoadingView showLoading:[error localizedDescription]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [progressLayer finishedLoad];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    progressLayer = [HYWebProgressLayer layerWithFrame:CGRectMake(0, 62.5, SCREEN_WIDTH, 1.5)];
    [self.view.layer addSublayer:progressLayer];
    [progressLayer startLoad];
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
