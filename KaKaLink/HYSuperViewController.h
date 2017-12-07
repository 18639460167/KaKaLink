//
//  HYSuperViewController.h
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCustomNavitionView.h"

@interface HYSuperViewController : UIViewController

@property (nonatomic, strong) HYCustomNavitionView *navBarView;
@property (nonatomic, assign) CGFloat navBarHeight;

/*!
 *  设置是否关闭侧滑手势
 */
@property (nonatomic,assign,readwrite)BOOL interactivePopGestureState;

@property (nonatomic, assign) CGFloat distanceTop; // 距离头部

@end

@interface HYSuperViewController(NavVarStyle)

- (void)LoadNavigation:(UIButton *)leftBtn
              navStyle:(HYNavitionStyle)style
                 title:(NSString *)title
         didBackAction:(backAction)handler;

- (void)loadHaveLeftBtn:(BOOL)isShowRight
               navStyle:(HYNavitionStyle)style
                  title:(NSString *)title
          didBackAction:(backAction)handler;

- (void)LoadNavigation:(UIButton *)leftBtn
             showRight:(BOOL)isShowRight
                 title:(NSString *)title
         didBackAction:(backAction)handler;

@end
