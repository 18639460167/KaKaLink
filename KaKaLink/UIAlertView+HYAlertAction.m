//
//  UIAlertView+HYAlertAction.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "UIAlertView+HYAlertAction.h"
#import <objc/runtime.h>
#import "DefineHeard.h"
@implementation UIAlertView (HYAlertAction)
static NSString *keyOfUseCategoryMethod;//用分类方法创建的alert，关联对象的key
static NSString *keyOfBlock;

+ (void)HYAlertTitle:(NSString *)message alertAction:(alertAction)handler
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"KAKALink" message:message delegate:nil cancelButtonTitle:LS(@"Cancel") otherButtonTitles:LS(@"Determine"), nil];
    alert.delegate = alert;
    objc_setAssociatedObject(alert, &keyOfUseCategoryMethod, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    alertAction block = (alertAction)objc_getAssociatedObject(alertView, &keyOfUseCategoryMethod);
    if (block)
    {
        block(buttonIndex);
    }
}

@end
