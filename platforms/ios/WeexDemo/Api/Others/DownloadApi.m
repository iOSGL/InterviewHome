//
//  DownloadApi.m
//  WeexDemo
//
//  Created by genglei on 2018/8/7.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "DownloadApi.h"

@implementation DownloadApi

- (NSString *)requestUrl {
    return @"/app_version/mianshi.zip";
}

- (BOOL)useCDN {
    return YES;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSString *)resumableDownloadPath {
    NSLog(@"%@",DOCUMENT_PATH);
    return DOCUMENT_PATH;
}

@end
