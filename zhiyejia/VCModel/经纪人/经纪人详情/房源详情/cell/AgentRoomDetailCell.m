//
//  AgentRoomDetailCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentRoomDetailCell.h"

@implementation AgentRoomDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
//    self.projectName = _dataDic[@"project_name"];
    _projectL.text = [NSString stringWithFormat:@"所属项目：%@",dataDic[@"project_name"]];
    
    _propertyL.text = dataDic[@"property_type"];
    _attentL.text = [NSString stringWithFormat:@"关注：%@",dataDic[@"collect_num"]];
    _seeL.text = [NSString stringWithFormat:@"浏览：%@",dataDic[@"browse_num"]];
    
    _roomNumL.text = [NSString stringWithFormat:@"房号：%@%@%@",dataDic[@"build_name"],[dataDic[@"unit_name"] length]?[NSString stringWithFormat:@"%@",dataDic[@"unit_name"]]:@"",dataDic[@"house_name"]];
    _priceL.text = [NSString stringWithFormat:@"价格：%@万",dataDic[@"total_price"]];
    _areaL.text = [NSString stringWithFormat:@"面积：%@㎡",dataDic[@"build_size"]];
    _stateL.text = [dataDic[@"state"] integerValue] == 1?@"未售":@"已售";
}

- (void)initUI{
    
    _roomNumL = [[UILabel alloc] init];
    _roomNumL.textColor = CLTitleLabColor;
    _roomNumL.font = [UIFont systemFontOfSize:11 *SIZE];
    _roomNumL.text = @"房号：";
    [self.contentView addSubview:_roomNumL];
        
    _propertyL = [[UILabel alloc] init];
    _propertyL.textColor = CLWhiteColor;
    _propertyL.textAlignment = NSTextAlignmentCenter;
    _propertyL.backgroundColor = CLBlueBtnColor;
    _propertyL.layer.cornerRadius = 2 *SIZE;
    _propertyL.clipsToBounds = YES;
    _propertyL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_propertyL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLTitleLabColor;
    _priceL.font = [UIFont systemFontOfSize:11 *SIZE];
    _priceL.text = @"价格：";
    [self.contentView addSubview:_priceL];
    
    _attentL = [[UILabel alloc] init];
    _attentL.textColor = CLTitleLabColor;
    _attentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _attentL.text = @"关注：";
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attentL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLTitleLabColor;
    _areaL.font = [UIFont systemFontOfSize:11 *SIZE];
    _areaL.text = @"面积：";
    [self.contentView addSubview:_areaL];
    
    _seeL = [[UILabel alloc] init];
    _seeL.textColor = CLTitleLabColor;
    _seeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _seeL.text = @"浏览：";
    _seeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_seeL];
    
    _projectL = [[UILabel alloc] init];
    _projectL.textColor = CLTitleLabColor;
    _projectL.font = [UIFont systemFontOfSize:11 *SIZE];
    _projectL.text = [NSString stringWithFormat:@"所属项目："];
    [self.contentView addSubview:_projectL];
    
    _stateL = [[UILabel alloc] init];
    _stateL.textColor = CLTitleLabColor;
    _stateL.textAlignment = NSTextAlignmentRight;
    _stateL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_stateL];
    
    [_roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_roomNumL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_roomNumL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(240 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_stateL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
}

@end
