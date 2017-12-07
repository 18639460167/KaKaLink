//
//  ScanQRViewController.m
//  TutwoTravel
//
//  Created by Christine on 3/19/15.
//  Copyright (c) 2015 Gamificationlife. All rights reserved.
//

#import "ScanQRViewController.h"
#import "InputBarCodeViewController.h"
#import "QRCode.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import<AssetsLibrary/AssetsLibrary.h>

@implementation BackView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.5f);
    CGContextFillRect(context, rect);
    CGContextClearRect(context, self.rectWhite);
}

@end

@interface ScanQRViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgBK;
@property (weak, nonatomic) IBOutlet BackView *viewBK;
@property (weak, nonatomic) IBOutlet UIView *BgView;

@property (weak, nonatomic) IBOutlet UIButton *buttonInputBarCode;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelectFromAlbum;
- (IBAction)clickInputBarCode:(id)sender;
- (IBAction)clickSelectFromAlbum:(id)sender;
- (void)barCodeAction:(NSString *)barCodeContent isFindGoods:(BOOL)isFindGoods;
@end

@implementation ScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadHaveLeftBtn:YES navStyle:HYNavitionStyle_Normal title:LS(@"Scan") didBackAction:nil];
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(0, -100, 227, 3)];
    _line.image = [UIImage imageNamed:@"scan_ico.png"];
    [self.view addSubview:_line];
    
    self.titleLbl.text = LS(@"Scan_Message");
    
    self.buttonInputBarCode.layer.cornerRadius = 5;
    self.buttonInputBarCode.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.buttonSelectFromAlbum setTitle:LS(@"Select_Picture") forState:UIControlStateNormal];
    [self.buttonInputBarCode setTitle:LS(@"Input_Bar_Code") forState:UIControlStateNormal];
    self.buttonSelectFromAlbum.adjustsImageWhenDisabled  = YES;
    self.buttonSelectFromAlbum.layer.cornerRadius = 5;
    [self.buttonInputBarCode setImage:[UIImage imageNamed:@"scan_num.png"] forState:UIControlStateNormal];
    [self.buttonSelectFromAlbum setImage:[UIImage imageNamed:@"scan_pic.png"] forState:UIControlStateNormal];
    [self.view sendSubviewToBack:self.viewBK];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.viewBK.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    
    _line.center = self.imgBK.center;
    
    self.viewBK.rectWhite = self.imgBK.frame;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *str = READ_SHOP_CAMERA;
    if ([str isEqualToString:@""])
    {
        SET_USER_DEFAULT(@"是第一次", SHOP_CAMERA_OPEN);
        SYN_USER_DEFAULT;
        [self setupCamera];
        timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    }
    else
    {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusAuthorized)
        {
            [self setupCamera];
            
            timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
        }
        else
        {
            [HYLoadingView showLoading:LS(@"Set_Album_Permission")];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    [self.preview removeFromSuperlayer];
    
    [_session stopRunning];
    
    [timer invalidate];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animation1
{
    CGRect frame = _line.frame;
    if (upOrdown == NO) {
        num ++;
        frame.origin.y = self.imgBK.frame.origin.y + 2*num+64;
        _line.frame = frame;
        if (2*num >= self.imgBK.bounds.size.height - 20) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        frame.origin.y = self.imgBK.frame.origin.y + 2*num+64;
        _line.frame = frame;
        if (num == 10) {
            upOrdown = NO;
        }
    }
}

- (void)setupCamera
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
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
   // _output.metadataObjectTypes = _output.availableMetadataObjectTypes;
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}

- (BOOL)isCameraAvailable;
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    return [videoDevices count] > 0;
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
    [self barCodeAction:stringValue isFindGoods:NO];
}

- (IBAction)clickInputBarCode:(id)sender
{
    InputBarCodeViewController *inputBarCodeController = [[InputBarCodeViewController alloc] initWithNibName:nil bundle:nil];
    inputBarCodeController.clickHandler = ^BOOL(NSString *barCode)
    {
        if (barCode.length == 0)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"KAKALink" message:LS(@"Please_Enter_Code") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
        else
        {
            [self barCodeAction:barCode isFindGoods:YES];
            return YES;
        }
    };
    [self.navigationController pushViewController:inputBarCodeController animated:YES];
}

- (IBAction)clickSelectFromAlbum:(id)sender
{
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    controller.mediaTypes = mediaTypes;
    controller.delegate = self;
    if ([controller.navigationBar respondsToSelector:@selector(setBarTintColor:)])
    {
        [controller.navigationBar setBarTintColor:[UIColor subjectColor]];
        [controller.navigationBar setTranslucent:NO];
        [controller.navigationBar setTintColor:[UIColor whiteColor]];
    }
    else
    {
        [controller.navigationBar setBackgroundColor:[UIColor subjectColor]];
    }
    controller.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *attributes = @{NSFontAttributeName:FONTSIZE(18),NSForegroundColorAttributeName:[UIColor whiteColor]};
    [controller.navigationBar setTitleTextAttributes:attributes];
    [self presentViewController:controller animated:YES completion:nil];
//        HYWeakSelf;
//        HYSelectPhotoViewController *vc = [[HYSelectPhotoViewController alloc]init];
//        NavigationViewController *navigationVC = [[NavigationViewController alloc] initWithRootViewController:vc];
//        vc.selCompete = ^(UIImage *image){
//            HYStrongSelf;
//            NSString * barCode = nil;
//            barCode = [QRCode getCodeWithImage:image];
//            if (barCode.length == 0)
//            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"U-Travel" message:LS(@"Could not identify") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            else
//            {
//                [sSelf barCodeAction:barCode isFindGoods:NO];
//            }
//        };
//        [self presentViewController:navigationVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *barCode = nil;
    NSString *mediaType= [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        barCode = [QRCode getCodeWithImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        if (barCode.length == 0)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"KAKALink" message:LS(@"Could not identify") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            [self barCodeAction:barCode isFindGoods:NO];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)barCodeAction:(NSString *)barCodeContent isFindGoods:(BOOL)isFindGoods
{
    if ([NSString isPureNumandCharacters:barCodeContent])
    {
        [HYProgressHUD showLoading:@"" rootView:self.view];
        [HYTransViewModel getTransDetail:barCodeContent handler:^(NSString *status, HYTransModel *model) {
            [HYProgressHUD hideLoading:self.view];
            if ([status isEqualToString:REQUEST_SUCCESS]) {
                HYTransDerailViewController *vc = [[HYTransDerailViewController alloc]init];
                vc.transModel = model;
                [self pushAction:vc];
            }
            else
            {
                [UIAlertView HYAlertTitle:[NSString stringWithFormat:@"%@: %@ %@",LS(@"Qr_Code"),barCodeContent,LS(@"Order_Not_Find")] alertAction:^(NSInteger index) {
                    [_session startRunning];
                    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
//                    if (index==1)
//                    {
//                        [_session startRunning];
//                        timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
//                    }
                }];
            }
        }];
    
    }
    else
    {
       [UIAlertView HYAlertTitle:[NSString stringWithFormat:@"%@: %@ %@",LS(@"Qr_Code"),barCodeContent,LS(@"Order_Not_Find")] alertAction:^(NSInteger index) {
            if (index==1)
            {
                [_session startRunning];
                timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
            }
        }];
    }
}

- (void)dealloc
{
    [timer invalidate];
    timer = nil;
}
@end
