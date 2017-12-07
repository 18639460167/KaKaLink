//
//  NSString+Extensions.h
//  TourGuide
//
//  Created by 步刊 徐 on 15/9/2.
//  Copyright © 2015年 步刊 徐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Extensions)
- (NSString *)lowercaseFirstCharacter;
- (NSString *)uppercaseFirstCharacter;
- (BOOL)isEmpty;
- (NSString *)trim;
- (NSString *)trimTheExtraSpaces;
- (NSString *)stringByDecodingXMLEntities;
- (NSString *)md5;
- (NSString *)md5ForUTF16;

+(NSString *)trimNSNullAsNoValue:(id)aData;
+(NSString *)trimNSNull:(id)aData;
+(NSString *)trimNSNullAsFloatZero:(id)aData;
+(NSString *)trimNSNullAsZero:(id)aData;
+ (NSString *)trimnsNullasIntValue:(id)aData;
+ (NSString *)trimNSNullASTimeValue:(id)aData;
+ (NSString *)getValueStr:(NSString*)oldStr;
+ (NSString *)trimNSNullTimeYear:(id)aData;

/**
 * 快速数组
 */
+ (NSArray *)dataArrayWithStr:(id)aData;

/**
 *  获取问题链接
 *
 */
+ (NSString *)getProblmeUrl;

+ (NSString *)getPhone;

/**
 *  钱数转每分
 */
- (NSString *)getFenMoney;

/**
 *  每分转元
 */
- (NSString *)getMoney;

/**
 *  加下划线
 */
+ (NSMutableAttributedString *)getStr:(NSString *)oldStr textColor:(UIColor *)txtColor;


- (NSString *)startName;

/**
 *  添加货币单位
 *
 */
- (NSString *)addMoneyUnit;

/**
 *  获取当前时间
 */
+ (NSString *)getCurrentTime;

/**
 *  时间戳转时间
 */
+ (NSString *)getTime:(NSString *)time;

/**
 *  判断字符串是不是全是数字
 */
+ (BOOL)isPureNumandCharacters:(NSString *)text;


+ (NSInteger)handlerNumber:(NSString *)oldStr;


#pragma mark - 卡券数据处理
+ (NSString *)trimCardNSNullAsFloat:(id)aData;
+ (NSString *)trimCardNSNullAsTime:(id)aData;

@end
