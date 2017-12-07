//
//  HYSelectShopView.m
//  TourGuidShop
//
//  Created by tenpastnine-ios-dev on 17/2/4.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSelectShopView.h"
#import "HYSelectShopCell.h"
@interface HYSelectShopView()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    CGFloat heigth;
    UIView *bgView;
    
    UIImageView *arrowImage;
}

@property (nonatomic, copy) shopModel block;
@end

@implementation HYSelectShopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)createViewInY:(CGFloat)y arrowImage:(UIImageView *)arrow handler:(shopModel)complete;
{
    if ([[HYShopMessage sharedModel] getShopListArray].count<=1)
    {
        return;
    }
    HYSelectShopView *shopView = [[HYSelectShopView alloc]initWithFrame:[UIScreen mainScreen].bounds createViewInY:y arrowImage:arrow  handler:complete];
    [shopView show];
}

- (instancetype)initWithFrame:(CGRect)frame createViewInY:(CGFloat)y  arrowImage:(UIImageView *)arrow handler:(shopModel)complete
{
    if (self = [super initWithFrame:frame])
    {
        self.block = complete;
        arrowImage = arrow;
        bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [bgView addGestureRecognizer:tap];
        bgView.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0];
        [self addSubview:bgView];
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0];
            heigth = HScale*50*([[[HYShopMessage sharedModel] getShopListArray] count]+1);
            if ((SCREEN_HEIGHT-y)<HScale*50*([[HYShopMessage sharedModel] getShopListArray].count+1))
            {
                heigth = SCREEN_HEIGHT-y;
            }
        tableview = [[UITableView alloc]initWithFrame:CGRectMake(WScale*12.5, y, SCREEN_WIDTH-WScale*25,0) style:UITableViewStylePlain];
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.tableFooterView = [UIView new];
        tableview.dataSource = self;
        tableview.delegate = self;
        tableview.layer.cornerRadius = WScale*4;
        [tableview registerCell:[HYSelectShopCell class]];
        [self addSubview:tableview];
        
    }
    return self;
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = tableview.frame;
        rect.size.height = heigth;
        tableview.frame = rect;
        bgView.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0.2];
         arrowImage.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    }];
}
- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = tableview.frame;
        rect.size.height = 0;
        tableview.frame = rect;
        bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        arrowImage.transform = CGAffineTransformMakeRotation(M_PI / 180.0);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[HYShopMessage sharedModel] getShopListArray] count]+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale*50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYSelectShopCell *cell = [HYSelectShopCell createCell:tableview];
        if (indexPath.row==0)
        {
            [cell bindData:LS(@"All")];
        }
        else
        {
            HYShopListModel *model = [[HYShopMessage sharedModel] getShopListArray][indexPath.row-1];
            [cell bindData:model.title];
        }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0)
    {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = tableview.frame;
            rect.size.height = 0;
            tableview.frame = rect;
            bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
              arrowImage.transform = CGAffineTransformMakeRotation(M_PI / 180.0);
        }completion:^(BOOL finished) {
            if (self.block)
            {
                self.block(LS(@"All"),@"0");
            }
            [self removeFromSuperview];
        }];
    }
    else
    {
        HYShopListModel *model = [[HYShopMessage sharedModel] getShopListArray][indexPath.row-1];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = tableview.frame;
            rect.size.height = 0;
            tableview.frame = rect;
            bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
              arrowImage.transform = CGAffineTransformMakeRotation(M_PI / 180.0);
        }completion:^(BOOL finished) {
            if (self.block)
            {
                self.block(model.title,model.mid);
            }
            [self removeFromSuperview];
        }];
    }
   
}

@end
