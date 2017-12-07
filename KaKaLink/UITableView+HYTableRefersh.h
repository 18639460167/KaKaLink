//
//  UITableView+HYTableRefersh.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HYTableRefersh)

- (void)setTableviewFootAction:(SEL)action target:(id)target;
- (void)setTableleHeardViewAction:(SEL)action target:(id)target;

/**
 *  注册cell
 */
- (void)registerCell:(Class)className;

/**
 *  创建tableview
 */
+ (UITableView *)createTableview:(UITableViewStyle)style fatherView:(id)vc;

/**
 *  创建含有空的table
 *
 *  @param style      tableview样式
 *  @param fatherView 父试图
 *
 *  @return tableview
 */
+ (UITableView *)createTableWithEmple:(UITableViewStyle)style fatherView:(id)fatherView;


/**
 商品名称和数量

 @param arrayCount 数组个数
 @param name 商品名称
 @param number 商品数量
 */
- (void)goodsDetailTableviewHeard:(NSInteger)arrayCount name:(NSString *)name number:(NSString *)number;
@end
