//
//  CreateQrIMG.m
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/10.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "CreateQrIMG.h"

@implementation CreateQrIMG
+(CreateQrIMG *)changeQr:(NSString *)mycontent andnewRect:(CGRect)rect{
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"]; [filter setDefaults];
    NSData *data = [mycontent dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:1. orientation:UIImageOrientationUp];
    UIImage *resized = [self resizeImage:image withQuality:kCGInterpolationNone rate:10.0];
    NSLog(@"%@",NSStringFromCGSize(resized.size));
    CreateQrIMG *IMG=[[CreateQrIMG alloc] initWithImage:resized];
    IMG.frame = rect;
    IMG.userInteractionEnabled=YES;
    CGImageRelease(cgImage);
    return IMG;
    
    
}

+ (UIImage *)resizeImage:(UIImage *)image withQuality:(CGInterpolationQuality)quality rate:(CGFloat)rate {
    
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate; CGFloat height = image.size.height * rate;
    UIGraphicsBeginImageContext(CGSizeMake(width, height)); CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetInterpolationQuality(context, quality); [image drawInRect:CGRectMake(0, 0, width, height)]; resized = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return resized;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
