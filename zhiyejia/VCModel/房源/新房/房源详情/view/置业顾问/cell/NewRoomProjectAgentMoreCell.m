//
//  NewRoomProjectAgentMoreCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewRoomProjectAgentMoreCell.h"

@implementation NewRoomProjectAgentMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = @"利用";
//    _professionL.text = @"专业评分：20";
//    _serviceL.text = @"服务评分：50";
    _typeL.text = @"金牌置业顾问";
}

- (void)ActionPraiseBtn:(UIButton *)btn{
    
    if (self.newRoomProjectAgentMoreCellPraiseBlock) {
        
        self.newRoomProjectAgentMoreCellPraiseBlock();
    }
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.newRoomProjectAgentMoreCellPhoneBlock) {
        
        self.newRoomProjectAgentMoreCellPhoneBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _headImg = [[UIImageView alloc] init];
//    _headImg.textColor = CLTitleLabColor;
//    _headImg.font = FONT(13 *SIZE);
    [self.contentView addSubview:_headImg];
    
    _goldImg = [[UIImageView alloc] init];
    //    _headImg.textColor = CLTitleLabColor;
    //    _headImg.font = FONT(13 *SIZE);
    [self.contentView addSubview:_goldImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_nameL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_typeL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_nameL];
    
    NSArray *arr = @[@"浏览量",@"点赞数",@"活跃度"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * SCREEN_Width / 3 , 100 *SIZE, SCREEN_Width / 3, 15 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = FONT(13 *SIZE);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        [self.contentView addSubview:label];
    }
    
    _allL = [[UILabel alloc] init];
    _allL.textColor = CLTitleLabColor;
    _allL.font = FONT(13 *SIZE);
    _allL.textAlignment = NSTextAlignmentCenter;
    _allL.text = @"123";
    [self.contentView addSubview:_allL];
    
    _praiseL = [[UILabel alloc] init];
    _praiseL.textColor = CLTitleLabColor;
    _praiseL.font = FONT(13 *SIZE);
    _praiseL.textAlignment = NSTextAlignmentCenter;
    _praiseL.text = @"123";
    [self.contentView addSubview:_praiseL];
    
    _activityL = [[UILabel alloc] init];
    _activityL.textColor = CLTitleLabColor;
    _activityL.font = FONT(13 *SIZE);
    _activityL.textAlignment = NSTextAlignmentCenter;
    _activityL.text = @"123";
    [self.contentView addSubview:_activityL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_phoneBtn];
    
    _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_praiseBtn addTarget:self action:@selector(ActionPraiseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_praiseBtn];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.height.mas_equalTo(50 *SIZE);
    }];


    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_allL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_praiseL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(130 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_activityL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-30 *SIZE);
        make.top.equalTo(self->_allL.mas_bottom).offset(50 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.left.equalTo(self.contentView).offset(30 *SIZE);
        make.top.equalTo(self->_allL.mas_bottom).offset(50 *SIZE);
//        make.top.equalTo(self.contentView.mas_bottom).offset(10 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
