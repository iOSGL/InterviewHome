//
//  SkillsTableViewCell.h
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkillsModel.h"

@interface SkillsTableViewCell : UITableViewCell

+ (SkillsTableViewCell *)cellForTableView:(UITableView *)tableView;

+ (CGFloat)heightForCell;

- (void)setData:(PageListModel *)model;

@end
