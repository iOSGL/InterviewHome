//
//  SkillsViewController.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "SkillsViewController.h"
#import "UIViewController+WXDemoNaviBar.h"

@interface SkillsViewController ()

@end

@implementation SkillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"测试代码";
    [self setupNaviBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
