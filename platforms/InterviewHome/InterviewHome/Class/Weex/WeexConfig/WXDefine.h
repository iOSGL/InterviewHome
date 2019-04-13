/**
 * Created by Weex.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the Apache Licence 2.0.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>

#define CURRENT_IP @"your computer device ip"

#if TARGET_IPHONE_SIMULATOR
    #define APP_HOST @"192.168.0.102"
#else
    #define APP_HOST CURRENT_IP
#endif

#define DEMO_URL(path) [NSString stringWithFormat:@"http://%@:12580/%s", APP_HOST, #path]

#define HOME_URL [NSString stringWithFormat:@"http://%@:8080/dist/index.js", APP_HOST]

#define BUNDLE_URL [NSString stringWithFormat:@"file://%@/bundlejs/index.js",[NSBundle mainBundle].bundlePath]

#define UITEST_HOME_URL @"http://test?_wx_tpl=http://localhost:12580/test/build/TC__Home.js"

#define WEEX_COLOR [UIColor colorWithRed:0.27 green:0.71 blue:0.94 alpha:1]
