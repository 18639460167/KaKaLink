//
//  HYCardCouponsViewController.h
//  KaKaLink
//
//  Created by 张帅 on 2017/8/19.
//  Copyright © 2017年 Black. All rights reserved.
//

#import "HYSuperViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HYCardCouponsViewController : HYSuperViewController<AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>
{
    int num;
    BOOL upOrDown;
    NSTimer *timer;
}
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, strong) UIImageView *line;

@end
