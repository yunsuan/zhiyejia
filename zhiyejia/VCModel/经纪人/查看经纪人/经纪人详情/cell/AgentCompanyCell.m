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
    [self.contentView addSubview:_scoreL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _typeL.text = @"类型：带看经纪人";
    [self.contentView addSubview:_typeL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.text = @"入职日期：2017-10-15";
    [self.contentView addSubview:_timeL];
    
    
}

@end
