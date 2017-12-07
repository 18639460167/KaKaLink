//
//  HYCardCouponsViewController.m
//  KaKaLink
//
//  Created by 张帅 on 2017/8/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYCardCouponsViewController.h"
#import "ScanQRViewController.h"

@interface HYCardCouponsViewController ()

@property (nonatomic, strong) UIImageView *imgBK;
@property (nonatomic, strong) BackView *viewBk;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) HYNoCardvertifyView *noCardvertifyView;
@property (nonatomic, strong) HYCardHeardView *navHeaderView;

@end

@implementation HYCardCouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navHeaderView = [HYCardHeardView createCardView:self isOpen:YES];
    
    self.noCardvertifyView = [HYNoCardvertifyView createNoCardVertify:self];
    self.noCardvertifyView.hidden = YES;

    
    self.viewBk = [[BackView alloc]initWithFrame:CGRectMake(0, NAV_HEIGT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGT)];
    self.viewBk.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.viewBk];
    self.imgBK = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-HScale *250)/2, HScale*90+NAV_HEIGT,HScale *250, HScale *250)];
    self.imgBK.backgroundColor = [UIColor clearColor];
    self.imgBK.image = [UIImage imageNamed:@"scan_box.png"];
    [self.view addSubview:self.imgBK];
    self.line = [[UIImageView alloc]initWithFrame:CGRectMake(0, -270, HScale*225, 2)];
    self.line.image = [UIImage imageNamed:@"scan_ico.png"];
    [self.view addSubview:self.line];
    
    _line.center = self.imgBK.center;
    
    self.viewBk.rectWhite = CGRectMake((SCREEN_WIDTH-HScale *250)/2, HScale*90,HScale *250, HScale *250);

    UIButton *interBtn = [UIButton createBgImageBtn:LS(@"Input_Card_Number") font:16 bgColor:@"kq_inter" height:HScale*50 btnAction:^{
        [self pushAction:[HYInputCardnumberViewController new]];
    }];
    CGFloat width = [HYStyle getWidthWithTitle:LS(@"Input_Card_Number") font:16];
    if (width < HScale*200)
    {
        width = HScale*200;
    }
    [self.view addSubview:interBtn];
    [interBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(width, width/4));
        make.top.equalTo(self.imgBK.mas_bottom).offset(HScale*50);
    }];
}

- (void)setUpCamera
{
    if (![self isCameraAvailable])
    {
        return;
    }
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码状态
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeITF14Code];
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = CGRectMake(0, NAV_HEIGT, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGT);
     [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [_session startRunning];
    
    
}

- (void)animation1
{
    CGRect frame  =_line.frame;
    if (upOrDown == NO)
    {
        num++;
        frame.origin.y = self.imgBK.frame.origin.y + 2*num;
        _line.frame = frame;
        if (2*num >= self.imgBK.bounds.size.height - 20)
        {
            upOrDown = YES;
        }
    }
    else
    {
        num --;
        frame.origin.y = self.imgBK.frame.origin.y + 2*num ;
        _line.frame = frame;
        if (num == 10)
        {
            upOrDown = NO;
        }
    }
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    [timer invalidate];
    //[self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%@", stringValue);
    [self barCodeAction:stringValue];
}

- (void)barCodeAction:(NSString *)stringValue
{
    if (stringValue.length != 20)
    {
        [UIAlertView HYAlertTitle:[NSString stringWithFormat:@"%@%@ %@",LS(@"Card_Number"),stringValue,LS(@"Not_Find")] alertAction:^(NSInteger index) {
            [_session startRunning];
            timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
        }];
    }
    else
    {
        NSString *checkStringValue = TRIM(stringValue);
        [HYProgressHUD show];
        [HYCardVertifyViewModel cardVerification:checkStringValue withComplete:^(id model, NSString *status) {
            [HYProgressHUD dismiss];
            if ([status isEqualToString:REQUEST_SUCCESS])
            {
                HYVertifyDetailViewController *vc = [[HYVertifyDetailViewController alloc]init];
                vc.hyOrderID = ((HYCardVertifyModel *)model).hyOrderID;
                [self pushAction:vc];
            }
            else
            {
                [UIAlertView HYAlertTitle:status alertAction:^(NSInteger index) {
                    [_session startRunning];
                    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
                }];
            }
        }];
    }
}

- (BOOL)isCameraAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    return [videoDevices count] > 0;
}

- (void)dealloc
{
    [timer invalidate];
    timer = nil;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.preview removeFromSuperlayer];
    [_session stopRunning];
    [timer invalidate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [timer invalidate];
    timer = nil;
    if ([READ_USER_MESSAGE(SHOP_COUPON_ENABLE) isEqualToString:@""])
    {
        self.noCardvertifyView.hidden = NO;
         [self.navHeaderView reloadData:NO];
        [self.view bringSubviewToFront:self.noCardvertifyView];
    }
    else
    {
        [self.navHeaderView reloadData:YES];
        self.noCardvertifyView.hidden = YES;
        [self.view sendSubviewToBack:self.noCardvertifyView];
        
        NSString *str = READ_SHOP_CAMERA;
        if ([str isEqualToString:@""])
        {
            SET_USER_DEFAULT(@"是第一次", SHOP_CAMERA_OPEN);
            SYN_USER_DEFAULT;
            [self setUpCamera];
            timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
        }
        else
        {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusAuthorized)
            {
                [self setUpCamera];
                
                timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
            }
            else
            {
                [HYProgressHUD showLoading:LS(@"Set_Album_Permission") time:2.0 currentView:self.view];
            }
        }

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
