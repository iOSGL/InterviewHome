//
//  SkillsTableViewCell.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "SkillsTableViewCell.h"
#import "UM_WeexModule.h"

@interface SkillsTableViewCell ()

@property (nonatomic , strong) CALayer *lineLayer;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *totalLabel;

@property (nonatomic , strong) UILabel *showMessageLabel;

@property (nonatomic , strong) BaseImageView *lockImageView;

@property (nonatomic , strong) UILabel *shareLabel;

@property (nonatomic , strong) PageListModel *model;


@end

@implementation SkillsTableViewCell

static CGFloat cell_Height = 88;

static NSString *identifier = @"listCell";

+ (SkillsTableViewCell *)cellForTableView:(UITableView *)tableView {
    SkillsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SkillsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Open Method

+ (CGFloat)heightForCell {
    return cell_Height;
}

- (void)setData:(PageListModel *)model {
    self.model = model;
    self.nameLabel.text = model.title;
    self.totalLabel.text = [NSString stringWithFormat:@"%@道题",model.questcount];
    self.showMessageLabel.text = model.showContent;
    if (!model.islock) {
        self.shareLabel.text = @"分享试题";
        self.shareLabel.backgroundColor = UIColorHex(0x2FA833);
        self.lockImageView.hidden = YES;
    } else {
        self.shareLabel.text = @"邀请好友";
        self.shareLabel.backgroundColor = UIColorHex(0xFF0000);
        self.lockImageView.hidden = false;
    }
}

#pragma mark - Config UI

- (void)configUI {
    [self.contentView.layer addSublayer:self.lineLayer];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.contentView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.contentView addSubview:self.showMessageLabel];
    [self.showMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    [self.contentView addSubview:self.lockImageView];
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showMessageLabel.mas_right).offset(10);
        make.centerY.equalTo(self.showMessageLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.contentView addSubview:self.shareLabel];
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalLabel.mas_right);
        make.bottom.equalTo(self.showMessageLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 25));
    }];
}

#pragma mark - Events

- (void)shareAction:(UITapGestureRecognizer *)event {
    if (self.model.islock) {
        UM_WeexModule *sharModule = [[UM_WeexModule alloc]init];
        NSDictionary *parames = @{
                                  @"type":@"link",
                                  @"title":@"面试之家一款不错的应用",
                                  @"des":@"面试之家你想要的全都有",
                                  @"picUrl":@"https://ws4.sinaimg.cn/large/006tKfTcgy1ft89152cmuj30z20yumx8.jpg",
                                  @"linkUrl":@"https://m.you.163.com/act/pub/DxDpYNfbBd.html"
                                  };
        [sharModule shareEvent:parames callback:^(id result, BOOL keepAlive) {
            
        }];
    } else {
        UM_WeexModule *sharModule = [[UM_WeexModule alloc]init];
        NSDictionary *parames = @{
                                  @"type":@"link",
                                  @"title":@"面试之家一款不错的应用",
                                  @"des":@"面试之家你想要的全都有",
                                  @"picUrl":@"https://ws4.sinaimg.cn/large/006tKfTcgy1ft89152cmuj30z20yumx8.jpg",
                                  @"linkUrl":@"https://m.you.163.com/act/pub/DxDpYNfbBd.html"
                                  };
        [sharModule shareEvent:parames callback:^(id result, BOOL keepAlive) {
            
        }];
    }
}

#pragma mark - Lazy Load

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = UIColorHex(0x333333);
        _nameLabel.font = [UIFont systemFontOfSize:16.f];
    }
    return _nameLabel;
}

- (UILabel *)totalLabel {
    if (_totalLabel == nil) {
        _totalLabel = [[UILabel alloc]init];
        _totalLabel.textColor = UIColorHex(0x666666);
        _totalLabel.font = [UIFont systemFontOfSize:13.f];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalLabel;
}

- (UILabel *)showMessageLabel {
    if (_showMessageLabel == nil) {
        _showMessageLabel = [[UILabel alloc]init];
        _showMessageLabel.textColor = UIColorHex(0x333333);
        _showMessageLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _showMessageLabel;
}

- (BaseImageView *)lockImageView {
    if (_lockImageView == nil) {
        _lockImageView = [BaseImageView new];
        _lockImageView.contentMode = UIViewContentModeScaleAspectFill;
        _lockImageView.image = [UIImage imageNamed:@"lock"];
    }
    return _lockImageView;
}

- (UILabel *)shareLabel {
    if (_shareLabel == nil) {
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.textColor = [UIColor whiteColor];
        _shareLabel.font = [UIFont systemFontOfSize:13.f];
        _shareLabel.layer.cornerRadius = 3;
        _shareLabel.backgroundColor = UIColorHex(0x2FA833);
        _shareLabel.textAlignment = NSTextAlignmentCenter;
        _shareLabel.layer.masksToBounds = YES;
        _shareLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareAction:)];
        [_shareLabel addGestureRecognizer:tap];
    }
    return _shareLabel;
}

- (CALayer *)lineLayer {
    if (_lineLayer == nil) {
        _lineLayer = [CALayer layer];
        _lineLayer.frame = CGRectMake(0, cell_Height - ONE_PX_LINE, SCREEN_WIDTH, ONE_PX_LINE);
        _lineLayer.backgroundColor = UIColorHex(0xeeeeee).CGColor;
    }
    return _lineLayer;
}


@end
