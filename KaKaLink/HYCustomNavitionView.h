//
//  HYCustomNavitionView.h
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^backAction)(void);
typedef NS_ENUM(NSInteger, HYNavitionStyle) {
    HYNavitionStyle_Normal, // 正常
    HYNavitionStyle_Clean, // 隐藏
};

@interface HYCustomNavitionView : UIView

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, copy) backAction complete;
@property (nonatomic, assign) BOOL isShowRight;
@property (nonatomic, strong) UIView *navBgView; //背景view

@property (nonatomic, strong) UIViewController *currentVC;


- (instancetype)initWithframe:(CGRect)frame handler:(backAction)complete;

@end
