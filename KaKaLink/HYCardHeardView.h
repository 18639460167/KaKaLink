//
//  HYCardHeardView.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYCardHeardButton : UIButton

+ (instancetype)createHeardBtn:(NSString *)title imageName:(NSString *)imageName fatherView:(UIView *)fatherView;

@end

@interface HYCardHeardView : UIView

+ (instancetype)createCardView:(UIViewController *)currentVC isOpen:(BOOL)isOpen;

- (void)reloadData:(BOOL)isOpen;

@end

@interface HYInputNumberView : UIView<UITextFieldDelegate>

+ (void)createInputView:(HYSuperViewController *)currentVC;

@end

@interface HYNoCardvertifyView : UIView

+ (instancetype)createNoCardVertify:(HYSuperViewController *)vc;

@end
