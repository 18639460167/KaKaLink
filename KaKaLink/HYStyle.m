//
//  HYStyle.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/22.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "HYStyle.h"
#import "HYLoadingView.h"
#import "PushNumberModel.h"
#import "HYShopMessage.h"

@implementation ActionSheet

- (id)initWithTitle:(NSString *)title buttonClickHandler:(AlertViewButtonClickedHandler)handler cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super initWithTitle:title==nil?nil:title delegate:self cancelButtonTitle:cancelButtonTitle==nil?nil:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle==nil?nil:destructiveButtonTitle otherButtonTitles:nil])
    {
        if (otherButtonTitles != nil)
        {
            [self addButtonWithTitle:otherButtonTitles];
            va_list args;
            va_start(args, otherButtonTitles);
            NSString *otherButton = va_arg(args, NSString*);
            while (otherButton != nil)
            {
                [self addButtonWithTitle:otherButton];
                otherButton = va_arg(args, NSString*);
            }
            va_end(args);
        }
        
        _buttonClickedHandler = [handler copy];
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_buttonClickedHandler != nil)
    {
        _buttonClickedHandler(self, buttonIndex);
    }
}

@end

@implementation HYStyle

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 自适应高度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(CGFloat)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:WScale*font];
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
// 自适应宽度
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(CGFloat)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:WScale*font];
    [label sizeToFit];
    return label.frame.size.width;
}
// 比较时间
+ (void)compareDate:(NSString *)startDate endDate:(NSString *)endDate handler:(void (^)(NSString *))action
{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *closeDate=[dateformatter dateFromString:endDate];
    NSDate *startDa=[dateformatter dateFromString:startDate];
    NSTimeInterval closeAndStartInterval=[startDa timeIntervalSinceDate:closeDate];
    if (closeAndStartInterval>0)
    {
        //            [HYStyle showAlert:LS(@"Sale_Star_Before_End")];
        closeDate = [dateformatter dateFromString:startDate];
        startDa = [dateformatter dateFromString:endDate];
        NSTimeInterval closeInterval=[closeDate timeIntervalSinceNow];
        if (closeInterval>0)
        {
            action(@"ok");
            return;
        }
        else
        {
            action(@"exchange");
            return;
        }
    }
    action(@"ok");

//    if ([startDate isEqualToString:LS(@"Sale_Starting")])
//    {
//        [HYStyle showAlert:LS(@"Sale_Select_Start_time")];
//    }
//    else if ([endDate isEqualToString:LS(@"Sale_Closing")])
//    {
//        [HYStyle showAlert:LS(@"Sale_Select_End_time")];
//    }
//    else
//    {
//        NSDate *closeDate=[dateformatter dateFromString:endDate];
//        NSDate *startDa=[dateformatter dateFromString:startDate];
//        NSTimeInterval closeInterval=[closeDate timeIntervalSinceNow];
//        if (closeInterval>0)
//        {
//            [HYStyle showAlert:LS(@"Sale_End_Date_Exceeded")];
//            return;
//        }
//        NSTimeInterval closeAndStartInterval=[startDa timeIntervalSinceDate:closeDate];
//        if (closeAndStartInterval>0)
//        {
////            [HYStyle showAlert:LS(@"Sale_Star_Before_End")];
//            closeDate = [dateformatter dateFromString:startDate];
//            startDa = [dateformatter dateFromString:endDate];
//            NSTimeInterval closeInterval=[closeDate timeIntervalSinceNow];
//            if (closeInterval>0)
//            {
//                [HYStyle showAlert:LS(@"Sale_End_Date_Exceeded")];
//                return;
//            }
//            else
//            {
//               action(@"exchange");
//                return;
//            }
//        }
//        action(@"ok");
//    }
}
+ (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
// 客服
+ (void)HYTelPhone:(UIView *)currentView
{
    if ([READ_SERVICE_PHONE isEqualToString:@""])
    {
        return;
    }
    ActionSheet *sheet = [[ActionSheet alloc] initWithTitle:LS(@"Telephone") buttonClickHandler:^(UIView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            NSURL *phone_url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",READ_SERVICE_PHONE]];
            [[UIApplication sharedApplication] openURL:phone_url];
        }
    } cancelButtonTitle:LS(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:READ_SERVICE_PHONE,nil];
    [sheet showInView:currentView];
}

/**
 *  生成二维码
 */
+ (UIImage *)getCodeImage:(CGSize)make codeStr:(NSString *)codeStr
{
    ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc]init];
    ZXBitMatrix *result = [writer encode:codeStr
                                  format:kBarcodeFormatQRCode
                                   width:make.width
                                  height:make.height
                                   error:nil];
    if (result)
    {
        ZXImage *imzge = [ZXImage imageWithMatrix:result];
        return [UIImage imageWithCGImage:imzge.cgimage];
    }
    else
    {
        return  nil;
    }
}
#pragma mark - 错误处理
/**
 *  错误处理
 *
 *  @param message 状态信息
 */
+ (void)handlerError:(NSString *)message
{
    if ([message isEqualToString:SHOP_NO_LOGIN])
    {
        [[HYAccountService sharedService] logout];
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_NeedLogin object:nil];
    }
    else
    {
        if (![message isEqualToString:@""])
        {
            [HYLoadingView showLoading:message];
        }
    }
}
/**
 *  数据处理
 *
 *  @return <#return value description#>
 */
+ (void)handlerError:(NSString *)message currentVc:(UIViewController *)vc loginHandler:(void (^)(void))complete
{
    if ([message isEqualToString:SHOP_NO_LOGIN])
    {
        [[HYAccountService sharedService] logout];
        [vc loginSuccessHandler:^{
            if (complete)
            {
                complete();
            }
        }];
    }
    else
    {
        if (![message isEqualToString:@""])
        {
            [HYLoadingView showLoading:message];
        }
    }
}
#pragma mark - 导航条按钮

+ (UIButton *)createRightBtn:(NSString *)title action:(void (^)(void))action
{
    CGFloat width = [HYStyle getWidthWithTitle:title font:16];
    if (width<WScale*66)
    {
        width = WScale*66;
    }
    UIButton *rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, width, HScale*18);
    rigthBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [rigthBtn setTitle:title forState:0];
    [rigthBtn setTitleColor:[UIColor threeTwoColor] forState:0];
    [rigthBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    rigthBtn.titleLabel.font  =FONTSIZE(16);
    [[rigthBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (action)
        {
            action();
        }
    }];
    return rigthBtn;
}

+ (void)setLeftBtnVC:(UIViewController *)vc action:(void (^)(void))action
{
    CGFloat width = [HYStyle getWidthWithTitle:LS(@"BACK") font:16/WScale]+20;
    if (width<80)
    {
        width = 80;
    }
    HYBackButton *backButton = [HYBackButton button:CGRectMake(0, 0, width, 49)];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (action)
        {
            action();
        }
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [vc.navigationItem setLeftBarButtonItem:backItem];
}

#pragma mark - 订单状态处理


+ (NSString *)volueTime:(NSString *)time
{
    NSString *type = LS(@"All_Volue_Orders");
    if ([time isEqualToString:@"1"])
    {
        type = LS(@"Before_Volue_Orders");
    }
    else if ([time isEqualToString:@"0"])
    {
        type = LS(@"Today_Volue_Orders");
    }
    return  type;
}
+ (NSString *)orderRefundReason:(NSString *)reason
{
    NSString *status = @"0";
    if ([reason isEqualToString:LS(@"Business_Negotiations")])
    {
        status = @"1";
    }
    if ([reason isEqualToString:LS(@"Many_Times_Pay")])
    {
        status = @"2";
    }
    if ([reason isEqualToString:LS(@"Other_Reasons")])
    {
        status = @"9";
    }
    return status;
}

+ (UIView *)createView:(UIColor *)backColor
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectZero];
    lineView.backgroundColor = backColor;
    return lineView;
}
+ (UIImageView *)createImage:(NSString *)imageName
{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectZero];
    if (![imageName isEqualToString:@""])
    {
        image.image = IMAGE_NAME(imageName);
    }
    return image;
}

+ (UIImageView *)createImage:(NSString *)url placeName:(NSString *)placeName
{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectZero];
    [image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeName] options:SDWebImageAllowInvalidSSLCertificates];
    return image;
}

+ (UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (BOOL)isPureNumandCharacters:(NSString *)text
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(text.length > 0)
    {
        return NO;
    }
    return YES;
}


+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage
{
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH)
        return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height)
    {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    }
    else
    {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [HYStyle imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSAssert(newImage, @"Fail to clip image.");
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSArray *)dateTimeArray
{
    static NSString *currentStr = @"";
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSMutableArray *dateArray = [NSMutableArray new];
    currentStr = [formatter  stringFromDate:date];
    [dateArray addObject:currentStr];
    for (int i=0; i<5; i++)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM"];
        NSDate *date = [formatter dateFromString:currentStr];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents  *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
        if (comps.month==1)
        {
            comps.year = comps.year-1;
            comps.month = 12;
        }
        else
        {
            comps.month = comps.month-1;
        }
        NSDate *newdate = [calendar dateFromComponents:comps];
        NSString *str = [formatter stringFromDate:newdate];
        currentStr = str;
        [dateArray insertObject:str atIndex:0];
    }
    return dateArray;
}

@end
