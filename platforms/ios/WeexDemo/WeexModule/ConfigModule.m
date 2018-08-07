//
//  ConfigModule.m
//  WeexDemo
//
//  Created by genglei on 2018/8/7.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "ConfigModule.h"

@implementation ConfigModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(getSandBoxDocumentUrl:))

- (void)getSandBoxDocumentUrl:(WXModuleKeepAliveCallback)callback{
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:[NSString stringWithFormat:@"%@",DOCUMENT_BUNDLEJS_PATH]]) {
        callback([NSString stringWithFormat:@"%@/index.js",DOCUMENT_URL], true);
    } else {
        callback(@"", false);
    }
}

@end
