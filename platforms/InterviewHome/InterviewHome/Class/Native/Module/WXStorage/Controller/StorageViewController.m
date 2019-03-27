//
//  StorageViewController.m
//  WeexDemo
//
//  Created by genglei on 2019/3/25.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import "StorageViewController.h"
#import "WXDBManger.h"

@interface StorageViewController ()

@end

@implementation StorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
//    [self loadData];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationItem.title = @"测试存储";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //  创建表
//    [[WXDBManger database]createAllSubjectTable];
//    [[WXDBManger database]createAllClassTable];
//    [[WXDBManger database] createQuestionsTable];
    
}


#pragma mark - Load Data

- (void)loadData {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://www.mianshihome.com/skill/homeList/group/json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *value = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         [[WXDBManger database]insertSubjects:value];
    }];
    [task resume];
    
//    NSURL *questionUrl = [NSURL URLWithString:@"https://www.mianshihome.com/skill/article/json"];
//    NSURLSessionTask *questionTabsk = [session dataTaskWithURL:questionUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSArray *value = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        [[WXDBManger database]insertAllQuestions:value];
//    }];
//    [questionTabsk resume];
}

@end
