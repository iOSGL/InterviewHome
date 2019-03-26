//
//  BaseProcessHandler.m
//  WeexDemo
//
//  Created by genglei on 2018/7/29.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "BaseProcessHandler.h"
#import "WXViewController.h"
#import "WXDefine.h"

NSString *const serviceTypeWeb = @"web";

@implementation BaseProcessHandler
IMP_SINGLETON

- (void)mediatorViewController:(UIViewController *)viewController
      didSelectServiceCategory:(NSString *)serviceCategory
                         param:(NSDictionary *)param {
    if ([serviceCategory isEqualToString:serviceTypeWeb]) {
        NSString *path = nil;
        if ([self isFileExist:@"bundlejs"]) {
            path = [NSString stringWithFormat:@"%@/page/webview.js",DOCUMENT_URL];
        } else {
          path = [NSString stringWithFormat:@"file://%@/bundlejs/page/webview.js",[NSBundle mainBundle].bundlePath];
        }
        NSString *webUrl = [NSString stringWithFormat:@"?weburl=%@",param[@"url"]];
        path = [path stringByAppendingString:webUrl];
        UIViewController *demo = [[WXViewController alloc] init];
        ((WXViewController *)demo).url = [NSURL URLWithString:path];
        [viewController.navigationController pushViewController:demo animated:YES];
    }
}

//判断文件是否已经在沙盒中已经存在？
-(BOOL)isFileExist:(NSString *)fileName {
    NSString *filePath = [DOCUMENT_PATH stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

@end
