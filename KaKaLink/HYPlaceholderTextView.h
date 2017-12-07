//
//  HYPlaceholderTextView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/29.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYPlaceholderTextView : UITextView

@property (nonatomic, strong) UILabel *placeHolderLbl;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
- (void)textChanged:(NSNotification * )notification;
@end
