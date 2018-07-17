//
//  SkillTableView.h
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkillsTableViewCell.h"

@protocol SkillTableViewDelegate <NSObject>

- (void)tabeleViewDidSelectCellModel:(PageListModel *)pageModel;

@end;

@interface SkillTableView : UITableView

@property (nonatomic, weak) id <SkillTableViewDelegate> cellDelegate;

@end
