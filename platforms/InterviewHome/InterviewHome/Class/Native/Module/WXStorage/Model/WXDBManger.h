//
//  WXDBManger.h
//  InterviewHome
//
//  Created by genglei on 2019/3/26.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXDatabase.h"

@interface WXDBManger : NSObject

+ (WXDBManger *)shareInstance;

+ (WXDatabase *)database;

@end


