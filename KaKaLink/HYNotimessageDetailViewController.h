//
//  HYNotimessageDetailViewController.h
//  TourGuidShop
//
//  Created by Black on 17/4/18.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSuperViewController.h"

@interface HYNotimessageDetailViewController : HYSuperViewController

@property (nonatomic, copy) NSString *messagetype;
@property (nonatomic, copy) NSString *messageTime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *messageID;

@property (nonatomic, copy) void(^readAction)(void);

@end
