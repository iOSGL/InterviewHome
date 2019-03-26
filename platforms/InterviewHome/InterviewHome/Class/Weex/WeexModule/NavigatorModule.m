//
//  NavigatorModule.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "NavigatorModule.h"
#import "MethodsUtil.h"
#import "BaseNavigationController.h"

@implementation NavigatorModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(pushViewController:params:animation:))
WX_EXPORT_METHOD(@selector(popToViewController:toRoot:animation:))

- (void)pushViewController:(NSString *)className params:(NSDictionary *)params animation:(BOOL)animation {
    Class targetClass = NSClassFromString(className);
    id target = [[targetClass alloc] init];
    if (target == nil) {
        [SVProgressHUD showErrorWithStatus:@"暂时不能打开"];
        return;
    } else {
        unsigned int outCount = 0;
        NSMutableArray *keyArray = [NSMutableArray array];
        objc_property_t *propertys = class_copyPropertyList([targetClass class], &outCount);
        for (unsigned int i = 0; i < outCount; i ++) {
            objc_property_t property = propertys[i];
            NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keyArray addObject:propertyName];
        }
        free(propertys);
        
        NSDictionary *parameterDic = params;
        if (parameterDic.allKeys.count > 0) {
            NSArray *array = parameterDic.allKeys;
            for (NSInteger i = 0; i < array.count; i++) {
                NSString *key = array[i];
                if ([keyArray containsObject:key]) {
                    [target setValue:parameterDic[key] forKey:key];
                }
            }
        }
        [weexInstance.viewController.navigationController pushViewController:target animated:YES];
    }
}

- (void)popToViewController:(NSString *)className toRoot:(BOOL)root animation:(BOOL)animation {
    if ([self containsClassName:className]) {
        UIViewController *controller =[self indexWithClassName:className];
        if (controller) {
            [weexInstance.viewController.navigationController popToViewController:controller animated:animation];
        } else {
            if (root) {
                [weexInstance.viewController.navigationController popToRootViewControllerAnimated:animation];
            } else {
                [weexInstance.viewController.navigationController popViewControllerAnimated:animation];
            }
        }
    }
}

- (BOOL)containsClassName:(NSString *)className {
    NSArray *classArray = weexInstance.viewController.navigationController.viewControllers;
    Class targetClass = NSClassFromString(className);
    for (UIViewController *control in classArray) {
        if (control.class == targetClass) {
            return YES;
        } else {
            return false;
        }
    }
    return false;
}

- (id)indexWithClassName:(NSString *)className {
    NSArray *classArray = weexInstance.viewController.navigationController.viewControllers;
    Class targetClass = NSClassFromString(className);
    for (NSInteger i = 0; i < classArray.count; i++) {
        UIViewController *control = classArray[i];
        if (control.class == targetClass) {
            return control;
        }
    }
    return nil;
}

@end
