//
//  UpdateApi.m
//  WeexDemo
//
//  Created by genglei on 2018/7/29.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "UpdateApi.h"

@implementation UpdateApi {
    NSString * _version;
}

- (instancetype)initWithLocakVersion:(NSString *)version {
    self = [super init];
    if (self) {
        _version = [version copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return @"https://www.mianshihome.com:8080/mianshi/rest/release/chickRelease";
}

- (id)requestArgument {
    return @{ @"version": _version};
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
