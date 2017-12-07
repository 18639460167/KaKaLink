//
//  HYRefundMessageCell.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYPlaceholderTextView.h"

typedef void (^selfText)(NSString *text);
@interface HYRefundMessageCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic, strong) HYPlaceholderTextView *textview;
@property (nonatomic, copy) selfText textHandler;

@end
