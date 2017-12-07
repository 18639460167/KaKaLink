//
//  HYSuperViewController.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSuperViewController.h"

@interface HYSuperViewController ()<UIGestureRecognizerDelegate>

@end

@implementation HYSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.distanceTop = 0;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setInteractivePopGestureState:(BOOL)interactivePopGestureState
{
    _interactivePopGestureState = interactivePopGestureState;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        _interactivePopGestureState = interactivePopGestureState;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = (_interactivePopGestureState ? self : nil);
        }
    }
}

- (HYCustomNavitionView *)navBarView
{
    if (!_navBarView)
    {
        self.distanceTop = 0;
        _navBarView = [HYCustomNavitionView new];
        [self.view addSubview:_navBarView];
        
        [_navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.mas_equalTo(NAV_HEIGT);
            self.navBarHeight  = NAV_HEIGT;
        }];
    }
    return _navBarView;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [HYProgressHUD hideLoading:self.view];
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


@implementation HYSuperViewController(NavVarStyle)

- (void)LoadNavigation:(UIButton *)leftBtn
              navStyle:(HYNavitionStyle)style
                 title:(NSString *)title
         didBackAction:(backAction)handler
{
    UILabel *titleLbl = [UILabel new];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = FONTSIZE(18);
    titleLbl.textColor = [UIColor threeTwoColor];
    self.navBarView.currentVC = self;
    self.navBarView.titleView = titleLbl;
    self.navBarView.isShowRight = YES;
    self.navBarView.complete = handler;
    self.navBarView.leftButton = leftBtn;
    if (style == HYNavitionStyle_Clean)
    {
        self.navBarView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    
}

- (void)loadHaveLeftBtn:(BOOL)isShowRight navStyle:(HYNavitionStyle)style title:(NSString *)title didBackAction:(backAction)handler
{
    UILabel *titleLbl = [UILabel new];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = FONTSIZE(18);
    titleLbl.textColor = [UIColor threeTwoColor];
    self.navBarView.currentVC = self;
    self.navBarView.titleView = titleLbl;
    self.navBarView.isShowRight = isShowRight;
    self.navBarView.complete = handler;
    if (style == HYNavitionStyle_Clean)
    {
        self.navBarView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
}

- (void)LoadNavigation:(UIButton *)leftBtn
              showRight:(BOOL)isShowRight
                 title:(NSString *)title
         didBackAction:(backAction)handler
{
    UILabel *titleLbl = [UILabel new];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = FONTSIZE(18);
    titleLbl.textColor = [UIColor threeTwoColor];
    self.navBarView.currentVC = self;
    self.navBarView.titleView = titleLbl;
    self.navBarView.isShowRight = isShowRight;
    self.navBarView.complete = handler;
}

@end

