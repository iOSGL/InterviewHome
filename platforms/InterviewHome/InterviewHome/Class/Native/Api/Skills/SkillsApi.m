//
//  SkillsApi.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "SkillsApi.h"

@implementation SkillsApi

- (NSString *)requestUrl {
    return @"/skill/homeList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

@end
