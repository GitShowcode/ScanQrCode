//
//  ScanQrViewController.m
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/8.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "ScanQrViewController.h"
#import "CreateQrViewController.h"
#import "QrCustomView.h"
#import "ScanSetting.h"
@interface ScanQrViewController ()

@end

@implementation ScanQrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];

    
    self.title=@"二维码/条形码";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"  style:UIBarButtonItemStylePlain  target:self  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(create)];
    [self.navigationItem setRightBarButtonItem:bar];

   
    
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //[session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"结果：" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        [self.session stopRunning];
    }
}
-(void)scanQr{
    
    if (self.session==nil) {
        
        
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //创建输入流
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        //创建输出流
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        //设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //初始化链接对象
        self.session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        
        [self.session addInput:input];
        [self.session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode];
        //,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code
        
        AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        layer.frame=self.view.layer.bounds;
        layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
//        [self.view.layer insertSublayer:layer atIndex:0];
        [self.view.layer addSublayer:layer];
        
        //设置 真实扫描区域
        float mywidth=[ScanSetting getsetting].sizeX;

        CGRect rect = CGRectMake(SCREEN_WIDTH/2-mywidth/2.0,(SCREEN_HEIGHT-mywidth+64)/2.0-[ScanSetting getsetting].space , mywidth, mywidth);
        CGRect intertRect = [layer metadataOutputRectOfInterestForRect:rect];
        CGRect layerRect = [layer rectForMetadataOutputRectOfInterest:intertRect];
        
        
        NSLog(@"%@,  %@",NSStringFromCGRect(intertRect),NSStringFromCGRect(layerRect));
        
        
        [output setRectOfInterest:intertRect];
      //  output.rectOfInterest=CGRectMake(0.5,0,0.5, 1);
        
  
    
 
        //开始捕获
        [self.session startRunning];
        
        QrCustomView *myView=[QrCustomView new];
        myView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        myView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:myView];
    }
    else{
        if ([self.session isRunning]) {
            
        }
        else{
            [self.session startRunning];
            
        }
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [self scanQr];
    [super viewDidAppear:animated];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.session startRunning];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)create{
    CreateQrViewController *VC=[[CreateQrViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
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
