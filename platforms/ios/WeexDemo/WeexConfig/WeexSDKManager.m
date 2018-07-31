//
//  WeexSDKManager.m
//  WeexDemo
//
//  Created by yangshengtao on 16/11/14.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "WeexSDKManager.h"
#import "DemoDefine.h"
#import <WeexSDK/WeexSDK.h>
#import "WXDemoViewController.h"
#import "WXImgLoaderDefaultImpl.h"
#import "UM_WeexModule.h"

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
    [WXSDKEngine registerModule:@"UM_Event" withClass:NSClassFromString(@"UM_WeexModule")];
    [WXSDKEngine registerModule:@"NV_Navigator" withClass:NSClassFromString(@"NavigatorModule")];
    [WXSDKEngine registerModule:@"NV_Notice" withClass:NSClassFromString(@"NoticeModule")];
    [WXSDKEngine registerComponent:@"NV_SkillCompent" withClass:NSClassFromString(@"SkillsComponent")];
    
#ifdef DEBUG
    [WXLog setLogLevel:WXLogLevelLog];
#endif
}

+ (void)loadCustomContainWithScannerWithUrl:(NSURL *)url
{
    UIViewController *demo = [[WXDemoViewController alloc] init];
    ((WXDemoViewController *)demo).url = url;
    [[UIApplication sharedApplication] delegate].window.rootViewController = [[WXRootViewController alloc] initWithRootViewController:demo];
}

@end
