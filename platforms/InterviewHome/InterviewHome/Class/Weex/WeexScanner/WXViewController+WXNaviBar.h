//
//  WXViewController+WXNaviBar.h
//  InterviewHome
//
//  Created by genglei on 2019/3/26.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXDefine.h"

@interface UIViewController (WXNaviBar)

/**
 *  back button click action
 *  @param sender responder
 */
- (void)backButtonClicked:(id)sender;

- (void)setupNaviBar;

@end


