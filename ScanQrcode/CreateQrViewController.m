//
//  CreateQrViewController.m
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/8.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "CreateQrViewController.h"

@interface CreateQrViewController ()
{
    UIView *qrimgView;
    UIView *bgView;

}
@end

@implementation CreateQrViewController
- (UILabel*) createLabelWithFrame: (CGRect) frame Font:(UIFont *)font Text:(NSString *)text  Textcolor:(UIColor *)color TextAlignment:(NSTextAlignment )textAlignment{
    
    UILabel *alabel=[[UILabel alloc] initWithFrame:frame];
    alabel.font=font;
    alabel.textColor=color;
    alabel.text=text;
    if (textAlignment==0) {
        //默认剧中
        alabel.textAlignment=NSTextAlignmentCenter;
        
    }
    else{
        alabel.textAlignment=textAlignment;
        
    }
    
    return alabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"生成二维码";
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label=[self createLabelWithFrame:CGRectMake(0, 30+64, SCREEN_WIDTH, 30) Font:[UIFont systemFontOfSize:25] Text:@"二维码" Textcolor:[UIColor blackColor] TextAlignment:0];
    [self.view addSubview:label];
    
    
    bgView=[[UIView alloc] initWithFrame:CGRectMake((int)(SCREEN_WIDTH-240)/2, 100+64, 240, 240)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.layer.borderColor=[UIColor grayColor].CGColor;
    bgView.layer.borderWidth=0.5;
    bgView.layer.cornerRadius=5;
    [self.view addSubview:bgView];
    
    
    [self creatQr:@"http://www.cnbeta.com/"];
    
    
    UIButton *btn= [self createButtonWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 240+100+50+64, 150, 45) Target:self Selector:@selector(changeQr) Image:@""];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"切换二维码" forState:UIControlStateNormal];
    
    btn.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:btn];

}
-(void)changeQr{
    
    
    
    [qrimgView removeFromSuperview];
    
    NSString *str=[NSString stringWithFormat:@"%@---%d",[self dateToString:[NSDate date]],arc4random()%100];
    [self creatQr:str];
    
    
    
}
/**创建二维码一*/
-(void)creatQr:(NSString *)qrstr{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"]; [filter setDefaults];
    NSData *data = [qrstr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:1. orientation:UIImageOrientationUp];
    UIImage *resized = [self resizeImage:image withQuality:kCGInterpolationNone rate:10.0];
    NSLog(@"%@",NSStringFromCGSize(resized.size));
    
    qrimgView  =[[UIImageView alloc]initWithImage:resized]; qrimgView.frame = CGRectMake(0, 0, 240, 240);
    for (UIView *iview in bgView.subviews) {
        [iview removeFromSuperview];
    }
    qrimgView.userInteractionEnabled=YES;
    [bgView addSubview:qrimgView];
    CGImageRelease(cgImage);
    
    
}
- (UIImage *)resizeImage:(UIImage *)image withQuality:(CGInterpolationQuality)quality rate:(CGFloat)rate {
    
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate; CGFloat height = image.size.height * rate;
    UIGraphicsBeginImageContext(CGSizeMake(width, height)); CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetInterpolationQuality(context, quality); [image drawInRect:CGRectMake(0, 0, width, height)]; resized = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return resized;
}
- (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    button.adjustsImageWhenHighlighted=NO;
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
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
