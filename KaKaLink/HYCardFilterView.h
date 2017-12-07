//
//  HYCardFilterView.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/23.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYCardTypeModel : NSObject

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *titleID;
@property (nonatomic, assign) BOOL isSelect;

+ (instancetype)createWithDic:(NSDictionary *)dic;

@end

@interface HYCardFilterView : UIView

+ (void)createFilterView:(NSString *)typeID complete:(HYHandler)complete;

@end
