//
//  HYCheckScrollView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/15.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCheckScrollView.h"
#import "HYOrderTableViewCell.h"

@interface HYCheckScrollView ()<UIScrollViewDelegate>
{
    UIView *lineView;
    UIButton *selectBtn;
}

@end
@implementation HYCheckScrollView
@synthesize scrollview;

- (instancetype)initWithFrame:(CGRect)frame fatherView:(id)vc
{
    if (self  =[super initWithFrame:frame])
    {
        [self setUpUI:vc];
    }
    return self;
}

- (void)setUpUI:(id)vc
{
    self.currentIndex = 1;
    NSArray *array = @[LS(@"Done"),LS(@"Procress"),LS(@"Refunded")];
    float width = SCREEN_WIDTH/3;
    for (int i=0; i<array.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, HScale*25, width, HScale*18);
        [button buttonStatus:array[i]];
        button.tag = i+1;
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (selectBtn==button)
            {
                return;
            }
            else
            {
                selectBtn.selected=NO;
                selectBtn=button;
                button.selected=YES;
                [UIView animateWithDuration:0.3 animations:^{
                    lineView.center=CGPointMake(button.center.x, button.center.y+HScale*13);
                    scrollview.contentOffset=CGPointMake(SCREEN_WIDTH*i, 0);
                }completion:^(BOOL finished) {
                    self.currentIndex = selectBtn.tag;
                    if (self.complete)
                    {
                        self.complete();
                    }
                }];
            }
        }];
        if (i==0)
        {
            button.selected = YES;
            selectBtn = button;
        }
        [self addSubview:button];
    }
    lineView = [HYStyle createView:[UIColor subjectColor]];
    lineView.frame = CGRectMake(WScale*7.5, CGRectGetMaxY(selectBtn.frame)+HScale*3.5, width-WScale*15, 1);
    [self addSubview:lineView];
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectZero];
    scrollview.bounces=NO;
    scrollview.pagingEnabled=YES;
    scrollview.delegate=self;
    scrollview.contentSize=CGSizeMake(SCREEN_WIDTH*3, 0);
    [self addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(lineView.mas_bottom).offset(HScale*10);
    }];
    
    for (int i=0; i<array.count; i++)
    {
        CGFloat heigth = (SCREEN_HEIGHT-HScale*125-HScale*213/2-14-49);
        heigth = heigth-(CGRectGetMaxY(lineView.frame))-HScale*10;
        UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, heigth) style:UITableViewStylePlain];
        tableview.tag = 100+i;
        tableview.dataSource = vc;
        tableview.delegate  =vc;
        [tableview setTableleHeardViewAction:@selector(loadData) target:self];
        [tableview setTableviewFootAction:@selector(loadMore) target:self];
        tableview.emptyDataSetDelegate = vc;
        tableview.emptyDataSetSource = vc;
        tableview.tableFooterView = [UIView new];
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [scrollview addSubview:tableview];
    }

}
- (void)loadData
{
    if (self.checkLoadData)
    {
        self.checkLoadData();
    }
}
- (void)loadMore
{
    if (self.checkLoadMore)
    {
        self.checkLoadMore();
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == scrollview)
    {
        float value = 1/3.0;
        lineView.frame=CGRectMake(WScale*7.5+(scrollview.contentOffset.x*value),HScale*46.5, SCREEN_WIDTH/3-WScale*15, 1);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==scrollview)
    {
        int tag = scrollView.contentOffset.x/SCREEN_WIDTH;
        if (tag+1 == selectBtn.tag)
        {
            return;
        }
        UIButton *button=(UIButton *)[self  viewWithTag:tag+1];
        selectBtn.selected=NO;
        selectBtn = button;
        button.selected=YES;
        self.currentIndex = selectBtn.tag;
        if (self.complete)
        {
            self.complete();
        }
    }
    
}
@end
