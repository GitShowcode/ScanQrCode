//
//  ScanQrViewController.h
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/8.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "QrCustomView.h"
@interface ScanQrViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (nonatomic,strong)AVCaptureSession * session;


@end
