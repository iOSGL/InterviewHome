//
//  SkillsModel.h
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "BaseModel.h"

@class PageListModel;

@interface SkillsModel : BaseModel

@property (nonatomic , copy) NSString *groupId;

@property (nonatomic , copy) NSString *content;

@property (nonatomic , copy) NSString *totalNum;

@property (nonatomic , copy) NSString *unlockTotal;

@property (nonatomic , assign) BOOL openFolder;

@property (nonatomic , copy) NSArray<PageListModel *> *pageList;

@end

@interface PageListModel : BaseModel

@property (nonatomic , copy) NSString *pageID;

@property (nonatomic , copy) NSString *showContent;

@property (nonatomic , copy) NSString *integral;

@property (nonatomic , copy) NSString *title;

@property (nonatomic , assign) BOOL islock;

@property (nonatomic , copy) NSString *questcount;

@end

@interface SkillsListModel : BaseModel

@property (nonatomic , copy) NSArray<SkillsModel *> *data;

@end
