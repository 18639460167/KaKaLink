//
//  HYTabBarViewController.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/22.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "HYTabBarViewController.h"
#import "HYStyle.h"
#import "DefineHeard.h"
#import "NavigationViewController.h"

#import "HYSalesStatusViewController.h"
#import "HYAccountSettingViewController.h"
#import "BDHomeViewController.h"
//#import "HYCodeMessageViewController.h"

@interface HYTabBarViewController ()

@end

@implementation HYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addAllChildVcs];
}

- (void)addAllChildVcs
{
    BDHomeViewController *homeVc = [[BDHomeViewController alloc]init];
    [self addOneChildVc:homeVc title:LS(@"check") imageName:@"check" selectedImageName:@"check_tap_sel"];
    
    HYSalesStatusViewController *saleVC = [[HYSalesStatusViewController alloc]init];
    [self addOneChildVc:saleVC title:LS(@"sale") imageName:@"sale" selectedImageName:@"sale_sel"];
    
    HYCardCouponsViewController *cardVC = [[HYCardCouponsViewController alloc]init];
    [self addOneChildVc:cardVC title:LS(@"Voucher") imageName:@"card_nor" selectedImageName:@"card_sel"];
    
    HYAccountSettingViewController *setVC = [[HYAccountSettingViewController alloc]init];
    [self addOneChildVc:setVC title:LS(@"User") imageName:@"setting" selectedImageName:@"setting_sel"];
    
    
}
#pragma mark --注释--
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    //设置标题
    childVc.title = title;
    //设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //设置选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (OS_ISVERSION7)
    {
        //声明这张图用原图
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    //设置背景
    self.tabBar.backgroundImage = [HYStyle imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)];
    //添加导航控制器
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

+ (void)initialize
{
//    设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor subjectColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];

    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#969696"],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
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
