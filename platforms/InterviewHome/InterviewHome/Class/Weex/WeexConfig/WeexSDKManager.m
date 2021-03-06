//
//  WeexSDKManager.m
//  WeexDemo
//
//  Created by yangshengtao on 16/11/14.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "WeexSDKManager.h"
#import "WXDefine.h"
#import <WeexSDK/WeexSDK.h>
#import "WXViewController.h"
#import "WXImgLoaderDefaultImpl.h"
#import "UM_WeexModule.h"
#import "WXNavigatorHandle.h"
#import "WXDatabaseModule.h"

@implementation WeexSDKManager

+ (void)setup;
{
    NSURL *url = nil;
#if DEBUG
    //If you are debugging in device , please change the host to current IP of your computer.
    url = [NSURL URLWithString:BUNDLE_URL];
#else
    url = [NSURL URLWithString:BUNDLE_URL];
#endif
    NSString * entryURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"WXEntryBundleURL"];
    if (entryURL) {
        if ([entryURL hasPrefix:@"http"]) {
            url = [NSURL URLWithString:entryURL];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSBundle bundleForClass:self] resourceURL].absoluteString, entryURL]];
        }
    }
    
#ifdef UITEST
    url = [NSURL URLWithString:UITEST_HOME_URL];
#endif
    
    
    if ([AppConfig isServerJS]) {
        NSString *path = [NSString stringWithFormat:@"%@/index.js",DOCUMENT_URL];
        url = [NSURL URLWithString:path];
    }
    
    [self initWeexSDK];
    [self loadCustomContainWithScannerWithUrl:url];
}

+ (void)initWeexSDK
{
    [WXAppConfiguration setAppGroup:@"mianshihome"];
    [WXAppConfiguration setAppName:@"面试之家"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    [WXAppConfiguration setExternalUserAgent:@"mianshizhijia"];
    
    [WXSDKEngine initSDKEnvironment];
    
    [WXSDKEngine registerHandler:[WXImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];
    [WXSDKEngine registerHandler:[WXNavigatorHandle new] withProtocol:@protocol(WXNavigationProtocol)];
    [WXSDKEngine registerModule:@"UM_Event" withClass:NSClassFromString(@"UM_WeexModule")];
    [WXSDKEngine registerModule:@"NV_Navigator" withClass:NSClassFromString(@"NavigatorModule")];
    [WXSDKEngine registerModule:@"NV_Notice" withClass:NSClassFromString(@"NoticeModule")];
    [WXSDKEngine registerModule:@"NV_ConfigModule" withClass:NSClassFromString(@"ConfigModule")];
    [WXSDKEngine registerModule:@"GL_DatabaseModule" withClass:NSClassFromString(@"WXDatabaseModule")];
    [WXSDKEngine registerComponent:@"NV_SkillCompent" withClass:NSClassFromString(@"SkillsComponent")];
    
#ifdef DEBUG
    [WXLog setLogLevel:WXLogLevelLog];
#endif
    
}

+ (void)loadCustomContainWithScannerWithUrl:(NSURL *)url
{
    UIViewController *demo = [[WXViewController alloc] init];
    ((WXViewController *)demo).url = url;
    [[UIApplication sharedApplication] delegate].window.rootViewController = [[WXRootViewController alloc] initWithRootViewController:demo];
}

@end
