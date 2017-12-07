//
//  HYWelvomeView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 16/12/23.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "HYWelvomeView.h"
#import "DefineHeard.h"
#import "HYAccountService.h"

@interface HYWelvomeView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) NSMutableArray *mImageList;

@end

@implementation HYWelvomeView
@synthesize mScrollView;
@synthesize mImageList;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showAction:(hideAction)handler
{
    if ([[HYAccountService sharedService]checkVersion])
    {
        HYWelvomeView *welcome =  [[HYWelvomeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) action:handler];
        [welcome show];
    }
    else
    {
        if (handler)
        {
            handler(NO);
        }
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame action:(hideAction)block
{
    if (self = [super initWithFrame:frame])
    {
        self.complete = block;
        mImageList = [NSMutableArray array];
        
        [mImageList addObject:@"welcome_1.jpg"];
        [mImageList addObject:@"welcome_2.jpg"];
        [mImageList addObject:@"welcome_3.jpg"];
        
        mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        mScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
        [mScrollView setBackgroundColor:[UIColor whiteColor]];
        
        mScrollView.delegate = self;
        mScrollView.pagingEnabled = YES;
        mScrollView.bounces = NO;
        mScrollView.showsHorizontalScrollIndicator = NO;
        mScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:mScrollView];
        
        for (int i=0; i<mImageList.count; i++)
        {
            UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            imageview.image = IMAGE_NAME(mImageList[i]);
            imageview.userInteractionEnabled = YES;
            [mScrollView addSubview:imageview];
            if (i==(mImageList.count-1))
            {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidewel)];
                [imageview addGestureRecognizer:tap];
            }
        }
    }
    return self;
}
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x<0){
        CGPoint point = scrollView.contentOffset;
        point.x = 0;
        point.y = 0;
        scrollView.contentOffset = point;
        return;
    }
    if(scrollView.contentOffset.x > ([mImageList count]-1)*self.frame.size.width)
    {
        [self hidewel];
        return;
    }
}
- (void)hidewel
{
    if (self.complete)
    {
        self.complete(YES);
    }
    [self removeFromSuperview];
}
@end
