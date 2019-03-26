//
//  BaseNavigationController.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method

- (void)configNavigation {
    self.navigationBar.barTintColor = UIColorHex(0xfafafa);
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     };
    [self.navigationBar setTitleTextAttributes:textAttributes];
    self.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *backImage = [[UIImage imageNamed:@"navigaitonback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        backButton.frame = CGRectMake(0, 0, 32, 32);
        [backButton setImage:backImage forState:UIControlStateNormal];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(leftBtnItemAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - action

- (void)leftBtnItemAction {
    [self popViewControllerAnimated:YES];
}

@end
