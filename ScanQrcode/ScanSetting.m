//
//  ScanSetting.m
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/10.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import "ScanSetting.h"
static ScanSetting *setting = nil;
@implementation ScanSetting

+(ScanSetting *)getsetting{
    ScanSetting *setting = [[ScanSetting alloc] init];
    setting.sizeX=250;
    setting.space=60;
    
    return setting;
    
    
}

@end
