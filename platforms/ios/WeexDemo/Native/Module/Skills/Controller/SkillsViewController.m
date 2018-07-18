//
//  SkillsViewController.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "SkillsViewController.h"
#import "UIViewController+WXDemoNaviBar.h"
#import "SkillTableView.h"

@interface SkillsViewController ()

@property (nonatomic , strong) SkillTableView *tableView;

@end

@implementation SkillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationItem.title = @"测试代码";
    [self setupNaviBar];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Lazy Load

- (SkillTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[SkillTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
