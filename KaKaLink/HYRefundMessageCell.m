//
//  HYRefundMessageCell.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/25.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYRefundMessageCell.h"


@implementation HYRefundMessageCell
@synthesize textview;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        textview = [[HYPlaceholderTextView alloc]initWithFrame:CGRectZero];
        textview.layer.borderWidth = 0.5;
        textview.layer.borderColor = [UIColor eOneColor].CGColor;
        textview.backgroundColor = [UIColor whiteColor];
        textview.delegate = self;
        textview.font = FONTSIZE(12);
        textview.textColor = BLACK_COLOR;
        textview.textAlignment = NSTextAlignmentLeft;
        textview.editable = YES;
        textview.placeholderColor = [UIColor nineSixColor];
        textview.placeholder = LS(@"Input_Other_Reasons");
        [self addSubview:textview];
        [textview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.equalTo(self);
            make.left.equalTo(self).offset(WScale*25);
            make.height.mas_equalTo(HScale*100);
        }];
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textHandler)
    {
        self.textHandler(textView.text);
    }
}

@end
