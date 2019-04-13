//
//  UrlArgumentFilter.h
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlArgumentFilter : NSObject <YTKUrlFilterProtocol>

+ (UrlArgumentFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;


@end
