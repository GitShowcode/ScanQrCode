//
//  QrCustomView.m
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/8.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "QrCustomView.h"

@implementation QrCustomView
- (void)drawRect:(CGRect)rect {

    CGSize screenSize =CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    CGRect screenDrawRect =CGRectMake(0, 0, screenSize.width,screenSize.height);
    //改变透明区域大小
    float mywidth=[ScanSetting getsetting].sizeX;
   //改变透明区域位置
    CGRect clearDrawRect = CGRectMake((SCREEN_WIDTH-mywidth)/2.0,(SCREEN_HEIGHT-mywidth+64)/2.0-[ScanSetting getsetting].space,mywidth,mywidth);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:ctx rect:screenDrawRect];
    [self addCenterClearRect:ctx rect:clearDrawRect];


}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextSetRGBFillColor(ctx, 40 / 255.0,40 / 255.0,40 / 255.0,0.6);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
}
- (void)addCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
