//
//  DataAnalytical.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "DataAnalytical.h"

@implementation DataAnalytical

+ (NSString *)getStatusCode:(YTKRequest *)request {
    if (!request.responseData) {
        return @"0";
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
    NSNumber *code = nil;
    if (dic == nil) {
    } else {
        code = dic[@"code"];
    }
    return [NSString stringWithFormat:@"%@",code];
}

+ (NSDictionary *)getResponseDic:(YTKRequest *)request {
    if (!request.responseData) {
        return nil;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
    return dic;
}

@end
