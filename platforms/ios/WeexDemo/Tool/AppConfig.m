//
//  AppConfig.m
//  WeexDemo
//
//  Created by genglei on 2018/7/13.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "AppConfig.h"
#import "UrlArgumentFilter.h"

NSString *const JSBundleVersion = @"jsbundle_version";

@interface AppConfig ()

@property (nonatomic, assign) BOOL isServerJS;

@property (nonatomic , copy) NSString *jsBundleVersion;

@end

@implementation AppConfig
IMP_SINGLETON

+ (void)setUp {
    [self svPreferrenceConf];
    [self setupRequestFilters];
    [self setIsServerJsBundle:[self checkLocalResource]]; // load sandbox js
    [self setJsBundleVersion:[[NSUserDefaults standardUserDefaults]stringForKey:JSBundleVersion]]; // set current jsbundle version
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
    config.cdnUrl = @"https://mianshizhijia.oss-cn-hangzhou.aliyuncs.com";
    NSDictionary *dic = nil;
    UrlArgumentFilter *urlFilter = [UrlArgumentFilter filterWithArguments:dic];
    [config addUrlFilter:urlFilter];
}

+ (void)clearRequestFilters {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    [config clearUrlFilter];
}

+ (BOOL)checkLocalResource {
    NSFileManager *manger = [NSFileManager defaultManager];
    return [manger fileExistsAtPath:DOCUMENT_BUNDLEJS_PATH];
}

#pragma mark - Global property

+ (BOOL)isServerJS {
    return [AppConfig sharedInstance].isServerJS;
}

+ (void)setIsServerJsBundle:(BOOL)isServer {
    [AppConfig sharedInstance].isServerJS = isServer;
}

+ (NSString *)jsBundleVersion {
    return [AppConfig sharedInstance].jsBundleVersion;
}

+ (void)setJsBundleVersion:(NSString *)version {
    [AppConfig sharedInstance].jsBundleVersion = version;
}

@end
