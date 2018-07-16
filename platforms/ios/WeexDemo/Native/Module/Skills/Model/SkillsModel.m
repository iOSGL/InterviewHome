//
//  SkillsModel.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "SkillsModel.h"

@implementation SkillsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pageList" : NSClassFromString(@"PageListModel") };
}

@end

@implementation PageListModel

@end

@implementation SkillsListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"SkillsModel") };
}

@end
