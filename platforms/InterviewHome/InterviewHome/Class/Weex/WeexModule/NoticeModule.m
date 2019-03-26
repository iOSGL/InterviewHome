//
//  NoticeModule.m
//  WeexDemo
//
//  Created by genglei on 2018/7/31.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "NoticeModule.h"

@implementation NoticeModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(postNotificationName:params:))

- (void)postNotificationName:(NSString *)name params:(NSDictionary *)params {
    [weexInstance fireGlobalEvent:name params:params];
}

@end
