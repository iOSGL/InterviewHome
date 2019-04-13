//
//  DownloadApi.m
//  WeexDemo
//
//  Created by genglei on 2018/8/7.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "DownloadApi.h"

@implementation DownloadApi {
    NSString *_url;
}

- (instancetype)initWithUrl:(NSString *)sourceUrl {
    self = [super init];
    if (self) {
        _url = [sourceUrl copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return _url;
}

- (BOOL)useCDN {
    return YES;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSString *)resumableDownloadPath {
    return DOCUMENT_PATH;
}

@end
