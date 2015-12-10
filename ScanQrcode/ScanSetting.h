//
//  ScanSetting.h
//  ScanQrcode
//
//  Created by jiapeixin on 15/12/10.
//  Copyright © 2015年 Gencare_Jia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanSetting : NSObject
@property (nonatomic,assign)float sizeX;
@property (nonatomic,assign)float space;

+(ScanSetting *)getsetting;

@end
