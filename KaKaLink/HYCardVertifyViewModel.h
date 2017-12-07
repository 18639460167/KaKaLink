//
//  HYCardVertifyViewModel.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/30.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,cardType) {
    cardType_All, // 全部
    cardType_Package,// 套餐
    cardType_Cash, // 现金抵用券
    cardType_UnKonw // 未知
};

@interface HYCardVertifyViewModel : NSObject

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger total_count;
@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *vertifyModelArray;

@property (nonatomic, assign) cardType cardtype; // 卡券类型
@property (nonatomic, assign) BOOL isRequestFail;// 是否请求失败
@property (nonatomic, copy) NSString *couponType; // 卡券类型

- (void)loadNewList:(HYHandler)complete;
- (void)loadMore:(HYHandler)complete;



/**
 卡券核销
 
 @param qrCode 卡券号
 @param complete 返回结果，model详情，请求状态
 */
+ (void)cardVerification:(NSString *)qrCode withComplete:(void (^)(id model,NSString *status))complete;


/**
 核销详情
 
 @param hyorderID 环游订单ID
 @param complete 返回结果，核销详情，请求状态
 */
+ (void)verificationDetail:(NSString *)hyorderID withComplete:(void (^)(id model,NSString *status))complete;

/**
 商品详情

 @param otapid 商品ID
 @param otaPackageID 套餐ID
 @param complete 返回结果，商品详情，请求状态
 */
+ (void)cardGoodsDetail:(NSString *)otapid otaPackageID:(NSString *)otaPackageID withComplete:(void (^) (id model, NSString *ststaue))complete;

@end
