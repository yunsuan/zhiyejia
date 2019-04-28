//
//  AgentCompanyCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentCompanyCell.h"

@implementation AgentCompanyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.text = @"云算科技";
    [self.contentView addSubview:_titleL];
    
    _storeL = [[UILabel alloc] init];
    _storeL.textColor = CLContentLabColor;
    _storeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _storeL.text = @"所属门店：销售部门";
    [self.contentView addSubview:_storeL];
    
    _departL = [[UILabel alloc] init];
    _departL.textColor = CLContentLabColor;
    _departL.font = [UIFont systemFontOfSize:11 *SIZE];
    _departL.text = @"所属部门：销售部门";
    [self.contentView addSubview:_departL];
    
    _positionL = [[UILabel alloc] init];
    _positionL.textColor = CLContentLabColor;
    _positionL.font = [UIFont systemFontOfSize:11 *SIZE];
    _positionL.text = @"职位：销售经理";
    [self.contentView addSubview:_positionL];
    
    _scoreL = [[UILabel alloc] init];
    _scoreL.textColor = CLContentLabColor;
    _scoreL.font = [UIFont systemFontOfSize:11 *SIZE];
    _scoreL.text = @"专业评分：78分";
    _scoreL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_scoreL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _typeL.text = @"类型：带看经纪人";
    _typeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_typeL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.text = @"入职日期：2017-10-15";
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(67 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-17 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(88 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(88 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_departL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(88 *SIZE);
        make.top.equalTo(self->_storeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_positionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(88 *SIZE);
        make.top.equalTo(self->_departL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_scoreL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
}

@end
