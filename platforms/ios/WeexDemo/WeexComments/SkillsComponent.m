//
//  SkillsComponent.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "SkillsComponent.h"
#import "SkillTableView.h"

@interface SkillsComponent () <SkillTableViewDelegate>

@end

NSString *const pushAction = @"pushPageList";

@implementation SkillsComponent {
    BOOL _pushPageList;
}

- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance {
    self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance];
    if (self) {
        
    }
    return self;
}

- (UIView *)loadView {
    return [[SkillTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (void)viewDidLoad {
    ((SkillTableView *)self.view).cellDelegate = self;
}

- (void)addEvent:(NSString *)eventName {
    if ([eventName isEqualToString:pushAction]) {
        _pushPageList = true;
    }
}

- (void)removeEvent:(NSString *)eventName {
    if ([eventName isEqualToString:pushAction]) {
        _pushPageList = false;
    }
}

#pragma mark - SkillTableViewDelegate

- (void)tabeleViewDidSelectCellModel:(PageListModel *)pageModel {
    if (_pushPageList) {
        [self fireEvent:pushAction params:@{@"pageID":pageModel.pageID}];
    }
}


@end
