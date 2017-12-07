//
//  HYCardVertifyModel.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CardOrderStyle_UnKonow, // 未知
    CardOrderStyle_ZSuccess=102, // 占位成功
    CardOrderStyle_ZFail=103, //占位失败
    CardOrderStyle_CleanSuccess=202, // 清位成功
    CardOrderStyle_Clean_Fail=203, // 清位失败
    CardOrderStyle_Define=301, // 确认中
    CardOrderStyle_DefineSuccess=302, // 确认成功
    CardOrderStyle_Define_Fail=301, //确认失败
    CardOrderStyle_Cancel=401, //取消中
    CardOrderStyle_CancelSuccess=404, // 部分取消成功
    CardOrderStyle_CancelFail=405, // 部分取消失败
    CardOrderStyle_Vertify_success=501, // 核销成功
    CardOrderStyle_VertifyFail=502 // 核销失败
    
}CardOrderStyle;

@interface HYCardVertifyModel : NSObject

@property (nonatomic, copy) NSString *categoryID;
@property (nonatomic, copy) NSString *hyOrderID;
@property (nonatomic, copy) NSString *orderPrice;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *orderSource;
@property (nonatomic, copy) NSString *otaPid; // 商品ID
@property (nonatomic, copy) NSString *otaPackageID; // 套餐ID
@property (nonatomic, copy) NSString *qrCode;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *qty; // 数量
@property (nonatomic, copy) NSString *unitPrice; // 单价
@property (nonatomic, copy) NSString *verticationDateTime;
@property (nonatomic, copy) NSString *picURL; 

@property (nonatomic, strong) NSArray *vertifyMessageArray;
@property (nonatomic, strong) NSArray *vertifyTitleArray;

+ (instancetype)createWithDic:(NSDictionary *)dic;


@end
