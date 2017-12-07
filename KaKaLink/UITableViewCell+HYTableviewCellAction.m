//
//  UITableViewCell+HYTableviewCellAction.m
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "UITableViewCell+HYTableviewCellAction.h"

@implementation UITableViewCell (HYTableviewCellAction)

+ (instancetype)createCell:(UITableView *)tableview
{
    NSString *str = NSStringFromClass(self);
    id cell = [tableview dequeueReusableCellWithIdentifier:str];
    if (!cell)
    {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    return cell;
}

@end
