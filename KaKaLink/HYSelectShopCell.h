//
//  HYSelectShopCell.h
//  
//
//  Created by tenpastnine-ios-dev on 17/2/4.
//
//

#import <UIKit/UIKit.h>

@interface HYSelectShopCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLbl;

- (void)bindData:(NSString *)title;

@end
