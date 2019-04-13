//
//  BaseProcessHandler.h
//  WeexDemo
//
//  Created by genglei on 2018/7/29.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const serviceTypeWeb;

@interface BaseProcessHandler : NSObject
DEF_SINGLETON(BaseProcessHandler)


@property (nonatomic, weak) UIViewController* viewController;
@property (nonatomic, copy) void (^successBlock)(id, NSString* error);
@property (nonatomic, copy) void (^failureBlock)(id, NSString* error);

- (void)mediatorViewController:(UIViewController *)viewController
      didSelectServiceCategory:(NSString *)serviceCategory
                         param:(NSDictionary *)param;

@end
