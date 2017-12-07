//
//  NSString+Extensions.m
//  TourGuide
//
//  Created by 步刊 徐 on 15/9/2.
//  Copyright © 2015年 步刊 徐. All rights reserved.
//

#import "NSString+Extensions.h"
#import "DefineHeard.h"
#import "HYStyle.h"

@implementation NSString (Extensions)

#pragma mark - 转换string大小写

- (NSString *)lowercaseFirstCharacter {
    NSRange range = NSMakeRange(0,1);
    NSString *lowerFirstCharacter = [[self substringToIndex:1] lowercaseString];
    return [self stringByReplacingCharactersInRange:range withString:lowerFirstCharacter];
}

- (NSString *)uppercaseFirstCharacter {
    NSRange range = NSMakeRange(0,1);
    NSString *upperFirstCharacter = [[self substringToIndex:1] uppercaseString];
    return [self stringByReplacingCharactersInRange:range withString:upperFirstCharacter];
}

#pragma mark - trim string

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimTheExtraSpaces{
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [self componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    return [filteredArray componentsJoinedByString:@" "];
}

//是否是空字符串
- (BOOL)isEmpty {
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [self stringByTrimmingCharactersInSet:charSet];
    return [trimmed isEqualToString:@""];
}


// implementation by Daniel Dickison and Walty
// http://stackoverflow.com/questions/1105169/html-character-decoding-in-objective-c-cocoa-touch
- (NSString *)stringByDecodingXMLEntities {
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", (unichar)charCode];
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
        }
        else {
            NSString *amp;
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
        }
    }
    while (![scanner isAtEnd]);
    
finish:
    return result;
}

//普通的MD5加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

//UTF16的MD5加密
- (NSString *)md5ForUTF16{
    NSData *temp = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    
    UInt8 *cStr = (UInt8 *)[temp bytes];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)[temp length], result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

#pragma mark - tokeniztion string


+ (NSString *)trimNSNull:(id)aData
{
    NSString *string;
    if ([aData isEqual:[NSNull null]]||aData==nil)
    {
        string=LS(@"Empty");
    }
    else
    {
        string=aData;
        string = [NSString stringWithFormat:@"%@",string];
    }
    return string;
}
+ (NSString *)trimNSNullAsNoValue:(id)aData
{
    NSString *string;
    if ([aData isEqual:[NSNull null]]||aData==nil)
    {
        string=@"";
    }
    else
    {
        string=aData;
        string = [NSString stringWithFormat:@"%@",string];
    }
    return string;
}
+ (NSString *)trimNSNullAsFloatZero:(id)aData
{
    NSString *string;
    if ([aData isEqual:[NSNull null]]||aData==nil)
    {
        string=@"0";
    }
    else
    {
        string=aData;
        string = [NSString stringWithFormat:@"%@",string];
        CGFloat monery = [string floatValue];
        float value = monery/100.0;
        string = [NSString stringWithFormat:@"%.2f",value];
        string = [NSString getValueStr:string];
    }
    return string;
}

+ (NSString *)trimnsNullasIntValue:(id)aData
{
    NSString *string;
    if ([aData isEqual:[NSNull null]] || aData == nil)
    {
        string = @"0";
    }
    else
    {
        string = aData;
        string = [NSString stringWithFormat:@"%@",string];
    }
    return string;
}
+(NSString *)trimNSNullAsZero:(id)aData{
    
    NSString *string;
    if ([aData isEqual:[NSNull null]]||aData==nil)
    {
        string=@"0";
        
    }
    else
    {
        
        string=aData;
        string = [NSString stringWithFormat:@"%@",string];
        CGFloat monery = [string floatValue];
        float value = monery/100.0;
        string = [NSString stringWithFormat:@"%.2f",value];
        string = [NSString getValueStr:string];
    }
    return string;
    
}
+ (NSString *)trimNSNullTimeYear:(id)aData
{
    NSString *string;
    if ([aData isEqual:[NSNull null]] || aData == nil)
    {
        string = @"0000-00";
    }
    else
    {
        string = aData;
        string = [NSString stringWithFormat:@"%@",string];
    }
    return string;
}

+ (NSString *)getValueStr:(NSString *)number
{
    if ([number rangeOfString:@"."].location != NSNotFound)
    {
        NSArray *array  = [number componentsSeparatedByString:@"."];
        if (array.count>=1)
        {
            NSString *str = [array lastObject];
            if ([str floatValue] == 0)
            {
                number = [array firstObject];
                number = [self addPoint:number];
            }
            else
            {
                if (str.length>2)
                {
                    number = [NSString stringWithFormat:@"%.2f",[number doubleValue]];
                }
                NSString *lastStr = [number substringFromIndex:number.length-1];
                if ([lastStr isEqualToString:@"0"])
                {
                    number = [NSString stringWithFormat:@"%.1f",[number doubleValue]];
                }
                
                NSArray *newArray = [number componentsSeparatedByString:@"."];
                if (newArray.count > 1)
                {
                    NSString *firstStr = newArray[0];
                    NSString *twoStr = [newArray lastObject];
                    firstStr = [self addPoint:firstStr];
                    number  = [NSString stringWithFormat:@"%@.%@",firstStr,twoStr];
                }
            }
        }
    }
    else
    {
        number = [self addPoint:number];
    }
    return number;
//    oldStr = [NSString stringWithFormat:@"%@",oldStr];
//    if ([oldStr rangeOfString:@"."].location != NSNotFound)
//    {
//        NSArray *array  = [oldStr componentsSeparatedByString:@"."];
//        NSLog(@"==%@",array);
//        if (array.count>=1)
//        {
//            NSString *str = [array lastObject];
//            if ([str floatValue] == 0)
//            {
//                oldStr = [array firstObject];
//            }
//            else
//            {
//                if (str.length>2)
//                {
//                    oldStr = [NSString stringWithFormat:@"%.2f",[oldStr doubleValue]];
//                }
//                NSString *lastStr = [oldStr substringFromIndex:oldStr.length-1];
//                if ([lastStr isEqualToString:@"0"])
//                {
//                    oldStr = [NSString stringWithFormat:@"%.1f",[oldStr doubleValue]];
//                }
//            }
//        }
//    }
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    NSString *formatter = @"###,##0";
//    NSString *format = @"%.0f";
//    if ([NSString handlerNumber:oldStr] == 0)
//    {
//        format = @"%.0f";
//        formatter = @"###,##0";
//    }
//    else if ([NSString handlerNumber:oldStr] == 1)
//    {
//        format = @"%.1f";
//        formatter = @"###,##0.0";
//    }
//    else
//    {
//        format = @"%.2f";
//        formatter = @"###,##0.00";
//    }
//    [numberFormatter setPositiveFormat:formatter];
//    oldStr = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[oldStr doubleValue]]];
//    return oldStr;
}
    
+ (NSString *)addPoint:(NSString *)number
{
    NSString *doneTitle = @"";
    int count = 0;
    for (NSInteger i = number.length-1; i >= 0; i--) {
        
        count++;
        doneTitle = [doneTitle stringByAppendingString:[number substringWithRange:NSMakeRange(i, 1)]];
        if (count == 3)
        {
            if (i==0)
            {
                doneTitle = [NSString stringWithFormat:@"%@", doneTitle];
            }
            else
            {
                doneTitle = [NSString stringWithFormat:@"%@,", doneTitle];
            }
            
            count = 0;
        }
    }
    NSMutableString * reverseString = [NSMutableString string];
    for(int i = 0 ; i < doneTitle.length; i ++)
    {
        unichar c = [doneTitle characterAtIndex:doneTitle.length- i -1];
        [reverseString appendFormat:@"%c",c];
    }
    doneTitle = reverseString;
    return doneTitle;
}

#pragma mark - 数字处理
+ (NSInteger)handlerNumber:(NSString *)oldStr
{
    oldStr = [NSString stringWithFormat:@"%@",oldStr];
    NSInteger number = 0;
    if ([oldStr rangeOfString:@"."].location != NSNotFound)
    {
        NSArray *array  = [oldStr componentsSeparatedByString:@"."];
        if (array.count>=1)
        {
            NSString *str = [array lastObject];
            if ([str floatValue] == 0)
            {
                number = 0;
            }
            else
            {
                if (str.length == 1)
                {
                    number = 1;
                }
                else
                {
                    number = 2;
                }
            }
        }
    }
    return number;
}

+ (NSString *)trimNSNullASTimeValue:(id)aData
{
    NSString *string;
    if ([aData isEqual:[NSNull null]]||aData==nil)
    {
        string=@"0000-00-00 00:00:00";
        
    }
    else
    {
        
        string=aData;
        string = [self getTime:string];
    }
    
    
    
    return string;
}

+ (NSString*)getPhone
{
    NSString *str = @"cn";
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSArray *array = [currentLanguage componentsSeparatedByString:@"-"];
    if (array.count>=2)
    {
        if (array.count == 3)
        {
            currentLanguage = [NSString stringWithFormat:@"%@-%@",array[0],array[1]];
        }
        else
        {
            currentLanguage = array[0];
        }
    }
    if ([currentLanguage isEqualToString:@"th"])
    {
        str = @"th";
    }
    else if ([currentLanguage isEqualToString:@"en"])
    {

        str = @"en";
    }
    else if ([currentLanguage isEqualToString:@"ko"])
    {
        str = @"kr";
    }
    else
    {
        str = @"cn";
    }
    return str;
}
+ (NSString *)getProblmeUrl
{
    NSString *serviceRoot = @"http://kakalink.huanyouji.com/";
    // @"https://biz.huanyouji.com"
    NSString *url = [NSString stringWithFormat:@"%@public/html/qa/index.html#lang=en",serviceRoot];
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSArray *array = [currentLanguage componentsSeparatedByString:@"-"];
    if (array.count>=2)
    {
        if (array.count == 3)
        {
            currentLanguage = [NSString stringWithFormat:@"%@-%@",array[0],array[1]];
        }
        else
        {
            currentLanguage = array[0];
        }
    }
    NSLog(@"==%@",currentLanguage);
    // 中文－cn，英文－en，韩语－kr，泰语－th ,越南-vi
    if ([currentLanguage isEqualToString:@"th"])
    {
        url = [NSString stringWithFormat:@"%@public/html/qa/index.html#lang=th",serviceRoot];
    }
    else if ([currentLanguage isEqualToString:@"zh-Hans"])
    {
        url = [NSString stringWithFormat:@"%@public/html/qa/index.html#lang=cn",serviceRoot];
    }
    else if ([currentLanguage isEqualToString:@"ko"])
    {
        url = [NSString stringWithFormat:@"%@public/html/qa/index.html#lang=kr",serviceRoot];
    }
    else if ([currentLanguage isEqualToString:@"vi"])
    {
        url = [NSString stringWithFormat:@"%@public/html/qa/index.html#lang=vi",serviceRoot];
    }
    else
    {
        url = [NSString stringWithFormat:@"%@public/html/qa/index.html#lang=en",serviceRoot];
    }
    return url;
}

/**
 *  多语言引导页
 *
 *  @return 图片名
 */
- (NSString *)startName
{
    NSString *imageName = self;
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSArray *array = [currentLanguage componentsSeparatedByString:@"-"];
    if (array.count>=2)
    {
        if (array.count == 3)
        {
            currentLanguage = [NSString stringWithFormat:@"%@-%@",array[0],array[1]];
        }
        else
        {
            currentLanguage = array[0];
        }
    }
    // 中文－cn，英文－en，韩语－kr，泰语－th ,越南-vi
    if ([currentLanguage isEqualToString:@"th"])
    {
        imageName = [NSString stringWithFormat:@"%@_th",imageName];
    }
    else if ([currentLanguage isEqualToString:@"zh-Hans"])
    {
        imageName = [NSString stringWithFormat:@"%@_cn",imageName];
    }
//    else if ([currentLanguage isEqualToString:@"ko"])
//    {
//        imageName = [NSString stringWithFormat:@"%@_kr",imageName];
//    }
    else if ([currentLanguage isEqualToString:@"vi"])
    {
        imageName = [NSString stringWithFormat:@"%@_vi",imageName];
    }
    else
    {
        imageName = [NSString stringWithFormat:@"%@_en",self];
    }
    return imageName;
}

#pragma mark - 获取分
- (NSString *)getFenMoney
{
    CGFloat price = [self floatValue];
    price = price/100.0;
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",price];
    return priceStr;
}

- (NSString *)getMoney
{
    CGFloat price = [self floatValue];
    NSLog(@"%f",price);
    price = price*100.0;
    NSString *priceStr = [NSString stringWithFormat:@"%.0f",price];
    return priceStr;
}

+ (NSMutableAttributedString *)getStr:(NSString *)oldStr textColor:(id)txtColor
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:oldStr];
    NSRange titleRange = {0,oldStr.length};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:txtColor range:titleRange];
    return title;
}

- (NSString *)addMoneyUnit
{
    NSString *message = self;
    message = [NSString stringWithFormat:@"%@  %@",READ_SHOP_SIGN,message];
    return message;
}

+ (NSString *)getCurrentTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // [formatter setDateStyle:NSDateFormatterFullStyle];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}


+ (NSString *)getTime:(NSString *)time
{
    //    NSTimeInterval _interval=([time doubleValue]+[NSTimeZone localTimeZone].secondsFromGMT) / 1000.0;
    //    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDate *date = [self timeStampDate:[NSString stringWithFormat:@"%@",time]];
    if (date)
    {
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateStyle:NSDateFormatterMediumStyle];
        [objDateformat setTimeZone:[NSTimeZone systemTimeZone]];
        [objDateformat setTimeStyle:NSDateFormatterShortStyle];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [objDateformat stringFromDate:date];
    }
    else
    {
        return @"0000-00-00 00:00:00";
    }
    
}

+ (NSDate *)timeStampDate:(NSString *)time
{
    if(time.length == 13)
    {
//        NSTimeInterval _interval=([time doubleValue]+[NSTimeZone localTimeZone].secondsFromGMT) / 1000.0;
         NSTimeInterval _interval=([time doubleValue]) / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        return date;
    }
    else if(time.length == 10)
    {
        NSTimeInterval _interval=([time doubleValue]);
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        return date;
    }
    else
    {
        return nil;
    }
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

#pragma mark - 数据处理
+ (NSString *)trimCardNSNullAsFloat:(id)aData
{
    NSString *string;
    if ([aData isEqual:[NSNull null]]||aData==nil)
    {
        string=@"0";
        
    }
    else
    {
        
        string=aData;
        string = [NSString stringWithFormat:@"%@",string];
        string = [NSString getValueStr:string];
    }
    return string;
}

+ (NSString *)trimCardNSNullAsTime:(id)aData
{
    NSString *string;
    if ([aData isEqual:[NSNull null]]||aData==nil)
    {
        string=@"0000-00-00 00:00:00";
        
    }
    else
    {
        string = [NSString stringWithFormat:@"%@",aData];
        if ([string rangeOfString:@"."].location != NSNotFound)
        {
            NSArray *array = [string componentsSeparatedByString:@"."];
            if (array.count>0)
            {
                string = array[0];
            }
        }
    }
    return string;
}

+ (NSArray *)dataArrayWithStr:(id)aData
{
    NSArray *array = [NSArray array];
    if ([aData isEqual:[NSNull null]] || aData == nil)
    {
        
    }
    else
    {
        array = (NSArray *)aData;
    }
    return array;
}

@end
