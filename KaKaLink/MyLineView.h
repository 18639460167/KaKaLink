//
//  MyLineView.h
//  旋转
//
//  Created by tenpastnine-ios-dev on 17/1/13.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^mdateAction)(NSArray *dateArray);
typedef void (^isSuccess) (BOOL isOK);
@interface MyLineView : UIView

@property (nonatomic, copy) isSuccess isSuccess;
/**
 * 刷新数据
 */

+ (instancetype)createView:(NSArray *)dateArray action:(mdateAction)action;

- (void)reloadData:(NSArray *)yValueArray;

@end
