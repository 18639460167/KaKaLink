//
//  QRCode.h
//  Tutwo
//
//  Created by 章叶飞 on 15/8/8.
//  Copyright (c) 2015年 Gamificationlife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingObjc.h"

@interface QRCode : NSObject

+ (UIImage *)makeQRCodeWithString:(NSString *)string size:(CGFloat)size color:(UIColor *)color;

+ (NSString *)getCodeWithImage:(UIImage *)image;

+ (UIImage *)makeBarCodeWithString:(NSString *)string barCodeType:(ZXBarcodeFormat)barCodeType size:(CGSize)size;

@end
