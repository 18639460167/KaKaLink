//
//  HYNotiMessageTableViewCell.m
//  TourGuideShop
//
//  Created by tenpastnine-ios-dev on 16/12/12.
//  Copyright © 2016年 huanyou. All rights reserved.
//

#import "HYNotiMessageTableViewCell.h"

#import "HYNotimessageDetailViewController.h"

@implementation HYNotiMessageTableViewCell
@synthesize hourceLbl;
@synthesize timeLbl;
@synthesize messageLbl;
@synthesize titleLbl;
@synthesize redView;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        hourceLbl = [UILabel createCenterLbl:@"" fontSize:10 textColor:WHITE_COLOR fatherView:self.contentView];
        hourceLbl.backgroundColor = [UIColor subjectColor];
        hourceLbl.layer.cornerRadius = HScale*35/2;
        hourceLbl.layer.masksToBounds = YES;
        [hourceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(HScale*35, HScale*35));
            make.left.mas_equalTo(WScale*25);
        }];
        
        timeLbl = [UILabel createRightLbl:@"" fontSize:10 textColor:[UIColor nineSixColor] fatherView:self.contentView];
        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-WScale*25);
            make.top.equalTo(self.contentView).offset(HScale *17);
            make.size.mas_equalTo(CGSizeMake(WScale*65, HScale*12));
        }];
        
        titleLbl = [UILabel createLbl:@"" fontSize:15 textColor:[UIColor threeTwoColor] fatherView:self.contentView];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(hourceLbl.mas_right).offset(WScale*19);
            make.top.equalTo(self.contentView).offset(HScale*25/2);
            make.size.mas_equalTo(CGSizeMake(WScale*70, HScale*17));
        }];
        
        messageLbl = [UILabel createLbl:@"" fontSize:11 textColor:[UIColor sixFourColor] fatherView:self.contentView];
        [messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(hourceLbl.mas_right).offset(WScale*19);
            make.right.equalTo(self.contentView).offset(WScale*-25);
            make.bottom.equalTo(self.contentView).offset(HScale*-18);
            make.height.mas_equalTo(HScale*12);
        }];
        
        redView = [HYStyle createView:[UIColor redColor]];
        redView.layer.cornerRadius = HScale*3;
        redView.layer.masksToBounds = YES;
        [self.contentView addSubview:redView];
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLbl.mas_right).offset(WScale*3);
            make.top.equalTo(self.contentView).offset(HScale*(25/2));
            make.size.mas_equalTo(CGSizeMake(HScale*6, HScale*6));
        }];
        
        UIView *lineView = [HYStyle createView:[UIColor eOneColor]];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.left.equalTo(self.contentView).offset(WScale*12.5);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

+ (HYNotiMessageTableViewCell *)registerCell:(UITableView *)tableview bindData:(NotifiMessageModel *)model isAllReady:(BOOL)isAllready
{
    HYNotiMessageTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"HYNotiMessageTableViewCell"];
    if (!cell)
    {
        cell = [[HYNotiMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HYNotiMessageTableViewCell"];
    }
    [cell bindData:model isAllreay:isAllready];
    return cell;
}

- (void)bindData:(NotifiMessageModel *)model isAllreay:(BOOL)isAll
{
    redView.hidden = YES;
    redView.hidden = model.isRead;
    NSArray *strArr = [model.timeMessage componentsSeparatedByString:@" "];
    NSString *lastStr=[strArr lastObject];
    NSString *horceText  =[NSString stringWithFormat:@"%@:%@",[lastStr componentsSeparatedByString:@":"][0],[lastStr componentsSeparatedByString:@":"][1]];
    self.hourceLbl.text = horceText;
    timeLbl.text = strArr[0];
    self.messageLbl.text = model.content;
    if (model.messageType==2001)
    {
        self.titleLbl.text = LS(@"withdraw");
    }
    else
    {
        self.titleLbl.text = LS(@"Unknown message");
    }
    if (isAll)
    {
        redView.hidden = YES;
    }
    CGFloat width = [HYStyle getWidthWithTitle:self.titleLbl.text font:15]+3;
    [titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hourceLbl.mas_right).offset(WScale*19);
        make.top.equalTo(self.contentView).offset(HScale*25/2);
        make.size.mas_equalTo(CGSizeMake(width, HScale*17));
    }];
}
- (void)cellAction:(UIViewController *)vc messageModel:(NotifiMessageModel *)myModel
{
    if (myModel)
    {
        if (myModel.messageType == 2001)
        {
            HYNotimessageDetailViewController *nvc = [[HYNotimessageDetailViewController alloc]init];
            nvc.messageTime = myModel.timeMessage;
            nvc.content = myModel.content;
            nvc.messagetype = LS(@"Withdrawal");
            nvc.readAction = ^(){
                myModel.isRead = YES;
                redView.hidden = YES;
            };
            if (myModel.isRead==NO)
            {
                nvc.messageID = myModel.messageID;
            }
            [vc.navigationController pushViewController:nvc animated:YES];
        }
        else
        {
            return;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
