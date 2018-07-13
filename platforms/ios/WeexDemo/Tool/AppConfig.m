//
//  AppConfig.m
//  WeexDemo
//
//  Created by genglei on 2018/7/13.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

+ (void)setUp {
    [self svPreferrenceConf];
}

#pragma mark --- SVProgressHUD 偏好设置
+ (void)svPreferrenceConf {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
    [SVProgressHUD setFont:FONT_SYSTEM_SIZE(14)];
}

@end
