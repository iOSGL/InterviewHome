//
//  BaseProcessHandler.m
//  WeexDemo
//
//  Created by genglei on 2018/7/29.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "BaseProcessHandler.h"
#import "WXDemoViewController.h"
#import "DemoDefine.h"

NSString *const serviceTypeWeb = @"web";

@implementation BaseProcessHandler
IMP_SINGLETON

- (void)mediatorViewController:(UIViewController *)viewController
      didSelectServiceCategory:(NSString *)serviceCategory
                         param:(NSDictionary *)param {
    if ([serviceCategory isEqualToString:serviceTypeWeb]) {
        NSString *path = nil;
        if ([self isFileExist:@"bundlejs"]) {
            
        } else {
          path = [NSString stringWithFormat:@"file://%@/bundlejs/page/webview.js",[NSBundle mainBundle].bundlePath];
        }
        NSString *webUrl = [NSString stringWithFormat:@"?weburl=%@",param[@"url"]];
        path = [path stringByAppendingString:webUrl];
        UIViewController *demo = [[WXDemoViewController alloc] init];
        ((WXDemoViewController *)demo).url = [NSURL URLWithString:path];
        [viewController.navigationController pushViewController:demo animated:YES];
    }
}

//判断文件是否已经在沙盒中已经存在？
-(BOOL)isFileExist:(NSString *)fileName {
    NSString *filePath = [DOCUMENT_PATH stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

@end
