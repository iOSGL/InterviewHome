//
//  SkillTableView.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "SkillTableView.h"
#import "SkillsApi.h"
#import "SkillsTableViewCell.h"

@interface SkillTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , strong) SkillsListModel *listModel;

@end

@implementation SkillTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self loadData];
    }
    return self;
}

#pragma mark - Load Data

- (void)loadData {
    SkillsApi *api = [[SkillsApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([[DataAnalytical getStatusCode:request] isEqualToString:@"200"]) {
            self.listModel = [SkillsListModel yy_modelWithDictionary:[DataAnalytical getResponseDic:request]];
            [self reloadData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listModel.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SkillsModel *model = (SkillsModel *)self.listModel.data[section];
    if (model.openFolder) {
        return model.pageList.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SkillsModel *model = (SkillsModel *)self.listModel.data[indexPath.section];
    SkillsTableViewCell *cell = [SkillsTableViewCell cellForTableView:tableView];
    [cell setData:model.pageList[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SkillsModel *model = self.listModel.data[section];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.tag = section;
    view.backgroundColor = [UIColor whiteColor];
    BaseImageView *leftIcon = [[BaseImageView alloc]init];
    leftIcon.contentMode = UIViewContentModeScaleAspectFill;
    if (model.openFolder) {
        leftIcon.image = [UIImage imageNamed:@"Arrow-down"];
    } else {
         leftIcon.image = [UIImage imageNamed:@"Arrow-right"];
    }
    [view addSubview:leftIcon];
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.centerY.equalTo(view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = model.content;
    nameLabel.textColor = UIColorHex(0x333333);
    nameLabel.font = [UIFont systemFontOfSize:17.f];
    [view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(leftIcon.mas_right).offset(15);
    }];
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.text = [NSString stringWithFormat:@"%@/%@",model.unlockTotal, model.totalNum];
    rightLabel.textColor = UIColorHex(0x666666);
    rightLabel.font = [UIFont systemFontOfSize:14.f];
    [view addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.right.equalTo(view.mas_right).offset(-15);
    }];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 44-ONE_PX_LINE, SCREEN_WIDTH, ONE_PX_LINE);
    layer.backgroundColor = UIColorHex(0xeeeeee).CGColor;
    [view.layer addSublayer:layer];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(folderAction:)];
    [view addGestureRecognizer:tap];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SkillsTableViewCell heightForCell];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SkillsModel *model = (SkillsModel *)self.listModel.data[indexPath.section];
    PageListModel *pageModel = (PageListModel *)model.pageList[indexPath.row];
    if (pageModel.islock) {
        
    } else {
        NSInteger number = [pageModel.integral integerValue] / 20;
        NSString *message = [NSString stringWithFormat:@"您当前积分不足,可邀请%zi位好友帮您解锁",number];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - Events

- (void)folderAction:(UITapGestureRecognizer *)event {
    UIView *view = (UIView *)event.view;
    SkillsModel *model = self.listModel.data[view.tag];
    model.openFolder = !model.openFolder;
    [self reloadSection:view.tag withRowAnimation:UITableViewRowAnimationNone];
}

@end
