//
//  UITextField+Length.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "UITextField+Length.h"
#import "DefineHeard.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UITextField (Length)

- (void)controlLength:(NSInteger)legth
{
    [[self rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
        if (self.text.length>legth)
        {
            self.text = [self.text substringToIndex:legth];
        }
    }];
}

+ (instancetype)createTxt:(NSString *)place font:(CGFloat)font textColor:(UIColor *)txtColor delegate:(id)cDelete
{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    textField.placeholder = place;
    textField.font = FONTSIZE(font);
    textField.textColor = txtColor;
    textField.delegate = cDelete;
    textField.backgroundColor = WHITE_COLOR;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}


@end
