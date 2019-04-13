//
//  WXViewController+WXNaviBar.m
//  InterviewHome
//
//  Created by genglei on 2019/3/26.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import "WXViewController+WXNaviBar.h"

@implementation UIViewController (WXNaviBar)

- (void)setupNaviBar
{
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePanGestureRecognizer.delegate = self;
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
    
    //    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    //    if ([[ver objectAtIndex:0] intValue] >= 7) {
    //        // iOS 7.0 or later
    //        self.navigationController.navigationBar.barTintColor = WEEX_COLOR;
    //        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //        self.navigationController.navigationBar.translucent = NO;
    //    }else {
    //        // iOS 6.1 or earlier
    //        self.navigationController.navigationBar.tintColor = WEEX_COLOR;
    //    }
    
    //    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
    //                                                                      [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    //    self.navigationItem.title = @"Weex Playground";
    
    
    self.navigationController.navigationBar.barTintColor = UIColorHex(0xfafafa);
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                     NSForegroundColorAttributeName :UIColorHex(0x333333),
                                     };
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    
    UIImage *backImage = [[UIImage imageNamed:@"navigaitonback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, 0, 32, 32);
    [backButton setImage:backImage forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer*)edgePanGestureRecognizer
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
        return NO;
    }
    return YES;
}

- (UIBarButtonItem *)backButtonItem
{
    UIBarButtonItem *backButtonItem = objc_getAssociatedObject(self, _cmd);
    if (!backButtonItem) {
        backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigaitonback"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(backButtonClicked:)];
        objc_setAssociatedObject(self, _cmd, backButtonItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backButtonItem;
}

- (void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
