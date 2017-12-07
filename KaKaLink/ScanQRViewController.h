//
//  ScanQRViewController.h
//  TutwoTravel
//
//  Created by Christine on 3/19/15.
//  Copyright (c) 2015 Gamificationlife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HYSuperViewController.h"
#define TRIM(string) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

@interface BackView : UIView

@property (assign,nonatomic) CGRect rectWhite;

@end

@interface ScanQRViewController : HYSuperViewController <AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic, copy) NSString * shop_sn;
@property (nonatomic, copy) NSString * payMoney;
@property (nonatomic, copy) NSString *shop_id;


@end
