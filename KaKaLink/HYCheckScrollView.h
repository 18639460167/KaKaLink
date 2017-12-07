//
//  HYCheckScrollView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/15.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectIndex)(void);
@interface HYCheckScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) selectIndex complete;
@property (nonatomic, copy) selectIndex checkLoadData;
@property (nonatomic, copy) selectIndex checkLoadMore;

- (instancetype)initWithFrame:(CGRect)frame fatherView:(id)vc;

@end
