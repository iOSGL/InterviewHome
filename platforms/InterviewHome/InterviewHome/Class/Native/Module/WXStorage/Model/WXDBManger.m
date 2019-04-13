//
//  WXDBManger.m
//  InterviewHome
//
//  Created by genglei on 2019/3/26.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import "WXDBManger.h"

@interface WXDBManger ()

@property (nonatomic , strong) WXDatabase *database;

@end


@implementation WXDBManger

static WXDBManger *_manger = nil;

+ (WXDBManger *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manger = [[self alloc]init];
    });
    return _manger;
}

+ (WXDatabase *)database {
    WXDatabase *wxdatabase = [self shareInstance].database;
    if (!wxdatabase) {
        wxdatabase = [[WXDatabase alloc]init];
        [self shareInstance].database = wxdatabase;
    }
    return wxdatabase;
}

@end
