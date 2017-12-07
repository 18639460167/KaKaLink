//
//  HYPlaceholderTextView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/29.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "HYPlaceholderTextView.h"
#import "DefineHeard.h"

@implementation HYPlaceholderTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    if (_placeholder != placeholder)
    {
        _placeholder = placeholder;
        [self.placeHolderLbl removeFromSuperview];
        self.placeHolderLbl = nil;
        [self setNeedsDisplay];
    }
}
- (void)textChanged:(NSNotification *)notification
{
    if ([[self placeholder] length] == 0)
    {
        return;
    }
    if ([[self text] length] == 0) {
        [[self viewWithTag:999] setAlpha:1.0];
    }
    
    else{
        
        [[self viewWithTag:999] setAlpha:0];
    }
}

//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{ //其实你可以加在这个代理方法中。当你将要编辑的时候。先执行这个代理方法的时候就可以改变间距了。这样之后输入的内容也就有了行间距。
//    
//    if (textView.text.length < 1) {
//        textView.text = @"间距";
//    }
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    
//    paragraphStyle.lineSpacing = 2;// 字体的行间距
//    
//    NSDictionary *attributes = @{
//                                 
//                                 NSFontAttributeName:FONTSIZE(14),
//                                 
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 
//                                 };
//    
//    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
//    if ([textView.text isEqualToString:@"间距"]) { //之所以加这个判断是因为再次编辑的时候还会进入这个代理方法，如果不加，会把你之前输入的内容清空。你也可以取消看看效果。
//        textView.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:attributes];//主要是把“间距”两个字给去了。
//    }
//    return YES;
//}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if ([[self placeholder] length] > 0) {
        if (_placeHolderLbl == nil)
        {
            _placeHolderLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, HScale*8, self.bounds.size.width-10 , 0)];
            _placeHolderLbl.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLbl.numberOfLines = 0;
            _placeHolderLbl.font = self.font;
            _placeHolderLbl.backgroundColor = [UIColor clearColor];
            _placeHolderLbl.textColor = self.placeholderColor;
            _placeHolderLbl.alpha = 0;
            _placeHolderLbl.tag = 999;
            [self addSubview:_placeHolderLbl];
        }
        _placeHolderLbl.text = self.placeholder;
        [_placeHolderLbl sizeToFit];
        [self sendSubviewToBack:_placeHolderLbl];
    }
    
    if ([[self text] length] == 0 && [[self placeholder] length] >0) {
        [[self viewWithTag:999] setAlpha:1.0];
    }
}
@end
