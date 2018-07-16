//
//  AppConfig.m
//  WeexDemo
//
//  Created by genglei on 2018/7/13.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "AppConfig.h"
#import "UrlArgumentFilter.h"

@implementation AppConfig

+ (void)setUp {
    [self svPreferrenceConf];
    [self setupRequestFilters];
    
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

#pragma mark - Config  Request

+ (void)setupRequestFilters {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    [config clearUrlFilter];
    config.debugLogEnabled = YES;
    config.baseUrl = @"https://www.mianshihome.com";
    config.cdnUrl = @"https://www.mianshihome.com";
    NSDictionary *dic = nil;
    UrlArgumentFilter *urlFilter = [UrlArgumentFilter filterWithArguments:dic];
    [config addUrlFilter:urlFilter];
}

+ (void)clearRequestFilters {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    [config clearUrlFilter];
}

@end
