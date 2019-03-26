//
//  StorageViewController.m
//  WeexDemo
//
//  Created by genglei on 2019/3/25.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import "StorageViewController.h"

@interface StorageViewController ()

@end

@implementation StorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationItem.title = @"测试存储";
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
