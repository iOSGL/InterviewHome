//
//  DataAnalytical.h
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataAnalytical : NSString

+ (NSString *)getStatusCode:(YTKRequest *)request;

+ (NSDictionary *)getResponseDic:(YTKRequest *)request;

@end
