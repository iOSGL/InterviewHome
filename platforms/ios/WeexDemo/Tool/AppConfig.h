//
//  AppConfig.h
//  WeexDemo
//
//  Created by genglei on 2018/7/13.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const JSBundleVersion;

@interface AppConfig : NSObject
DEF_SINGLETON(AppConfig)

+ (void)setUp;

/**
Check if local resources are available
 */
+ (BOOL)isServerJS;
+ (void)setIsServerJsBundle:(BOOL)isServer;


/**
 Record jsbunlde version deafult is nil
 */
+ (NSString *)jsBundleVersion;
+ (void)setJsBundleVersion:(NSString *)version;


@end
