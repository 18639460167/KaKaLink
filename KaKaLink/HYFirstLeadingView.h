//
//  HYFirstLeadingView.h
//  KaKaLink
//
//  Created by Black on 17/7/6.
//  Copyright © 2017年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYFirstLeadingView : UIView
{
    NSInteger index;
    NSArray *imageArray;
}

@property (nonatomic, copy) noParameterBlock handler;

@property (nonatomic, strong) UIImageView *startImageView;

+ (void)showLeading:(noParameterBlock)complete;

@end
