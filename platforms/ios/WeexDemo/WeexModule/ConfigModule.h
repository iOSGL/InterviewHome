//
//  ConfigModule.h
//  WeexDemo
//
//  Created by genglei on 2018/8/7.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK.h>

typedef void (^WXModuleKeepAliveCallback)(id result, BOOL keepAlive);

@interface ConfigModule : NSObject <WXModuleProtocol>

@end
