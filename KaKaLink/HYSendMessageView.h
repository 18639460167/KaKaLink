//
//  HYSendMessageView.h
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAXTextViewHeight 80 // 限制文字输入的高度

@interface HYSendMessageView : UIView

@property (nonatomic, copy) void (^SendMessafeBlock)(NSString *message);

/**
 *   占位符
 */
- (void)setPlaceholderText:(NSString *)placeText;

@property (nonatomic, copy) void(^backBlock)(BOOL success);
@end
