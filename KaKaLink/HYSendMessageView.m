//
//  HYSendMessageView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/1/10.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSendMessageView.h"
#import "DefineHeard.h"
#import "Masonry.h"
#import "HYStyle.h"
#define kScreenBounds ([[UIScreen mainScreen] bounds])

@interface HYSendMessageView ()<UITextViewDelegate>
{
    BOOL statusTextView;//当文字大于限定高度之后的状态
    NSString *placeholderText;//设置占位符的文字
}

@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UIButton *imageButton;

@end
@implementation HYSendMessageView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createUI];
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification
                                                object:nil];
    }
    
    /**
     点击 空白区域取消
     */
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self addGestureRecognizer:centerTap];
    
    self.backBlock = ^(BOOL isok){
        NSLog(@"131321");
    };
    return self;
}

- (void)createUI{
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WScale*10);
        make.top.mas_equalTo(HScale*12.5);
        make.size.mas_equalTo(CGSizeMake(WScale*40, HScale*35));
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backGroundView.mas_centerY);
        make.top.mas_equalTo(HScale*10);
        make.left.equalTo(_imageButton.mas_right).offset(WScale*8);
        make.right.mas_equalTo(WScale*-8);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.equalTo(_imageButton.mas_right).offset(8);
        make.height.mas_equalTo(39);
    }];
    
}

//暴露的方法
- (void)setPlaceholderText:(NSString *)text{
    placeholderText = text;
    self.placeholderLabel.text = placeholderText;
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    self.frame = kScreenBounds;
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    if (self.textView.text.length == 0) {
        
        self.backGroundView.frame = CGRectMake(0, SCREEN_HEIGHT-height-HScale*60-NAV_HEIGT, SCREEN_WIDTH, HScale*60);
    }else{
        CGRect rect = CGRectMake(0, SCREEN_HEIGHT - self.backGroundView.frame.size.height-height-NAV_HEIGT, SCREEN_WIDTH, self.backGroundView.frame.size.height);
        self.backGroundView.frame = rect;
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.textView.text.length == 0) {
        self.backGroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale*60);
        self.frame = CGRectMake(0, SCREEN_HEIGHT-HScale*60-NAV_HEIGT, SCREEN_WIDTH, HScale*60);
    }
    else
    {
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, self.backGroundView.frame.size.height);
        self.backGroundView.frame = rect;
        self.frame = CGRectMake(0, SCREEN_HEIGHT - rect.size.height-NAV_HEIGT, SCREEN_WIDTH, self.backGroundView.frame.size.height);
    }
}

- (void)centerTapClick
{
    [self.textView resignFirstResponder];
}
#pragma mark -- textfiledDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    /**
     *  占位符
     */
    if (textView.text.length == 0)
    {
        self.placeholderLabel.text = placeholderText;
    }
    else
    {
        self.placeholderLabel.text = @"";
    }
    
    /**
     *  计算高度
     */
    CGSize size = CGSizeMake(SCREEN_WIDTH-WScale*66, CGFLOAT_MAX);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil];
    CGFloat curHeight = [textView.text boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic
                                                    context:nil].size.height;
    CGFloat y = CGRectGetMaxY(self.backGroundView.frame);
    if (curHeight<19.094)
    {
        statusTextView = NO;
        self.backGroundView.frame = CGRectMake(0, y-HScale*60, SCREEN_WIDTH, HScale*60);
    }
    else if (curHeight<MAXTextViewHeight)
    {
        statusTextView = NO;
        self.backGroundView.frame = CGRectMake(0, y-textView.contentSize.height-10, SCREEN_WIDTH, textView.contentSize.height+10);
    }
    else
    {
        statusTextView = YES;
        return;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        NSLog(@"==发送");
        return NO;
    }
    return YES;
}

#pragma mark- 懒加载
- (UIView *)backGroundView
{
    if (!_backGroundView)
    {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HScale*60)];
        _backGroundView.backgroundColor = [UIColor fSixColor];
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}
- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.layer.cornerRadius = WScale*4;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = [UIColor eOneColor].CGColor;
        [self.backGroundView addSubview:_textView];
    }
    return _textView;
}
- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.font = [UIFont systemFontOfSize:16];
        _placeholderLabel.textColor = [UIColor grayColor];
        [self.backGroundView addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}
- (UIButton *)imageButton
{
    if (!_imageButton)
    {
        _imageButton = [[UIButton alloc]init];
        [_imageButton setBackgroundImage:IMAGE_NAME(@"picture") forState:0];
        [_imageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_imageButton addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:_imageButton];
    }
    return _imageButton;
}
#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (statusTextView == NO) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        
    }
}

#pragma  mark -- 发送事件
- (void)sendClick
{
    [self.textView endEditing:YES];
    if (self.SendMessafeBlock)
    {
        self.SendMessafeBlock(self.textView.text);
    }
    
    //---- 发送成功之后清空 ------//
    self.textView.text = @"";
    self.placeholderLabel.text = placeholderText;
    [self.imageButton setBackgroundColor:RGB(180, 180, 180)];
    self.frame = CGRectMake(0, SCREEN_HEIGHT-HScale*60-NAV_HEIGT, SCREEN_WIDTH, HScale*60);
    self.backGroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale*60);
}

@end
