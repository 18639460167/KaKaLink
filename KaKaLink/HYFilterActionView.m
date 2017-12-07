//
//  HYFilterActionView.m
//  TourGuidShop
//
//  Created by Black on 17/6/22.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYFilterActionView.h"

@interface HYFilterActionView()<UICollectionViewDataSource,UICollectionViewDelegate>

{
    UIView *rightView;
}

@property (nonatomic, strong) UICollectionView *collectionview;

@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, assign) NSInteger payWay;
@property (nonatomic, assign) NSInteger timeWay;
@property (nonatomic, copy)   NSString *payWayID;
@property (nonatomic, copy)   NSString *timeWayID;

@end

@implementation HYFilterActionView
@synthesize payWay;
@synthesize payWayID;
@synthesize timeWay;
@synthesize timeWayID;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)createFilterView:(UIViewController *)vc timeID:(NSString *)timeID payID:(NSString *)payID complate:(void (^)(NSString *, NSString *))complete
{
    [HYProgressHUD showLoading:@"" rootView:vc.view];
    [HYCommonViewModel commonPaymentChannel:^(NSString *status, NSMutableArray *modelArray) {
        [HYProgressHUD hideLoading:vc.view];
        if ([status isEqualToString:REQUEST_SUCCESS])
        {
            NSMutableArray *dataArray = [NSMutableArray new];
            for (int i=0; i<3; i++)
            {
                HYMessageModel *model = [HYMessageModel createDic:[NSDictionary new]];
                if (i==0)
                {
                    model.tID = @"2";
                    model.title = LS(@"All");
                    model.isSelect = YES;
                }
                else
                {
                    if (i==1)
                    {
                        model.title = LS(@"Today");
                        model.tID = @"0";
                        model.icon_url = @"check_today";
                    }
                    else
                    {
                        model.title = LS(@"Before");
                        model.tID = @"1";
                        model.icon_url = @"check_before";
                    }
                }
                [dataArray addObject:model];
                
            }
            HYFilterActionView *view = [[HYFilterActionView alloc]initWithFrame:[UIScreen mainScreen].bounds modelArray:[NSMutableArray arrayWithObjects:modelArray,dataArray, nil] timeID:timeID payID:payID complate:complete];
            [view show];
        }
        [HYProgressHUD handlerDataError:status currentVC:vc handler:nil];
    }];
}

- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSMutableArray *)array timeID:(NSString *)timeID payID:(NSString *)payID complate:(void (^)(NSString *, NSString *))complete
{
    if (self = [super initWithFrame:frame])
    {
        self.modelArray = array;
        self.payWayID = payID;
        self.timeWayID = timeID;
        
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0];
        UIView *bgView = [HYStyle createView:[UIColor clearColor]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAction)];
        [bgView addGestureRecognizer:tap];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
        
        rightView = [HYStyle createView:WHITE_COLOR];
        rightView.frame = CGRectMake(SCREEN_WIDTH, 0, WScale*270, SCREEN_HEIGHT);
        [self addSubview:rightView];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.headerReferenceSize = CGSizeMake(WScale*270, HScale*60);
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, WScale*270, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.backgroundColor = WHITE_COLOR;
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        [_collectionview registerClass:[HYFilterCollectionViewCell class] forCellWithReuseIdentifier:@"HYFilterCollectionViewCell"];
        [_collectionview registerClass:[HYHeardCollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYHeardCollectionReusableView"];
        [rightView addSubview:_collectionview];
        [_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(rightView);
            make.bottom.equalTo(rightView).offset(HScale*-40);
        }];
        
        HYWeakSelf;
        UIButton *replaceBtn = [UIButton createNoLayerBtn:LS(@"Replace") titColor:[UIColor subjectColor] bgColor:WHITE_COLOR font:15 btnAction:^{
            HYStrongSelf;
            payWayID = @"0";
            timeWayID = @"2";
            [sSelf reloadView];
        }];
        [rightView addSubview:replaceBtn];
        [replaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(rightView);
            make.height.mas_equalTo(HScale*40);
            make.width.mas_equalTo(rightView.mas_width).multipliedBy(0.5);
        }];
        
        UIButton *confirmBtn = [UIButton createBtnWithbgColor:[UIColor subjectColor] title:LS(@"Finish") textColor:WHITE_COLOR font:15 handler:^{
            HYStrongSelf;
            [UIView animateWithDuration:0.3 animations:^{
                rightView.frame = CGRectMake(SCREEN_WIDTH, 0, WScale*270, SCREEN_HEIGHT);
                sSelf.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0];
            } completion:^(BOOL finished) {
                if (complete)
                {
                    complete(payWayID,timeWayID);
                }
                [sSelf removeFromSuperview];
            }];
        }];
        [rightView addSubview:confirmBtn];
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(rightView);
            make.height.mas_equalTo(HScale*40);
            make.width.mas_equalTo(rightView.mas_width).multipliedBy(0.5);
        }];
        
        [self reloadView];
    }
    
    return self;
}

#pragma mark - tableview datasource delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width=(WScale*270-WScale*30)/2;
    return CGSizeMake(width, HScale*35);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return WScale*10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return WScale*10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(WScale*0, WScale*10, WScale*0,WScale*10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HYHeardCollectionReusableView *cell = (HYHeardCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYHeardCollectionReusableView" forIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        cell.titleLbl.text = LS(@"Pay_Way");
    }
    else
    {
        cell.titleLbl.text = LS(@"Pay_Time");
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.modelArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *mArray = self.modelArray[section];
    return [mArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HYFilterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYFilterCollectionViewCell" forIndexPath:indexPath];
    BOOL isFirst = NO;
    if (indexPath.section == 0)
    {
        isFirst = YES;
    }
    [cell bindMessageModel:self.modelArray[indexPath.section][indexPath.row] isOne:isFirst];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == self.payWay)
        {
            return;
        }
        HYMessageModel *model = self.modelArray[indexPath.section][self.payWay];
        model.isSelect = NO;
        HYMessageModel *selModel = self.modelArray[indexPath.section][indexPath.row];
        selModel.isSelect = YES;
        self.payWay = indexPath.row;
        payWayID = selModel.tID;
    }
    else
    {
        if (indexPath.row == self.timeWay)
        {
            return;
        }
        HYMessageModel *model = self.modelArray[indexPath.section][self.timeWay];
        model.isSelect = NO;
        HYMessageModel *selModel = self.modelArray[indexPath.section][indexPath.row];
        selModel.isSelect = YES;
        self.timeWay = indexPath.row;
        timeWayID = selModel.tID;
    }
    [_collectionview reloadData];
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        rightView.frame = CGRectMake(SCREEN_WIDTH-WScale*270, 0, WScale*270, SCREEN_HEIGHT);
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0.3];
    }];
}
- (void)hideAction
{
    [UIView animateWithDuration:0.3 animations:^{
        rightView.frame = CGRectMake(SCREEN_WIDTH, 0, WScale*270, SCREEN_HEIGHT);
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)reloadView
{
    if (self.modelArray.count>1)
    {
        NSArray *payArray = self.modelArray[0];
        for (int i=0;i<payArray.count;i++)
        {
            HYMessageModel *model = payArray[i];
            if ([model.tID isEqualToString:payWayID])
            {
                model.isSelect = YES;
                payWay = i;
            }
            else
            {
                model.isSelect = NO;
            }
        }
        
        NSArray *timeArray = self.modelArray[1];
        for (int j=0;j<timeArray.count;j++)
        {
            HYMessageModel *model = timeArray[j];
            if ([model.tID isEqualToString:timeWayID])
            {
                model.isSelect = YES;
                timeWay = j;
            }
            else
            {
                model.isSelect = NO;
            }
        }
    }
    [self.collectionview reloadData];
}
@end
