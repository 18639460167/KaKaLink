//
//  HYCheckShopView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/29.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^chooseStatus)(NSInteger status);

@interface HYChooseStatusView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, copy) chooseStatus backHandler;

+ (void)createChooseStatusView:(NSString *)selectStr handler:(chooseStatus)complete;

@end

@interface HYCheckShopView : UIView

@property (nonatomic, strong) UILabel *shopNameLbl;
@property (nonatomic, strong)  UIButton *clickBtn;
@property (nonatomic, strong) UIImageView *arrorImage;

- (void)reloadDataShopList;

@end
