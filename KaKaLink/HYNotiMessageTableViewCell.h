//
//  HYNotiMessageTableViewCell.h
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/12.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotifiMessageModel.h"
//#import "WithdrawalsProgressTableViewController.h"

@interface HYNotiMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *hourceLbl;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *messageLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UIView *redView;

+ (HYNotiMessageTableViewCell *)registerCell:(UITableView *)tableview bindData:(NotifiMessageModel *)model isAllReady:(BOOL)isAllready;
/**
 *  cell点击事件
 *
 */
- (void)cellAction:(UIViewController *)vc messageModel:(NotifiMessageModel *)myModel;

@end
