//
//  DemandAgentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DemandAgentCell.h"

@implementation DemandAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = @"张三";//_dataDic[@"name"];
    _yearL.text = @"23岁";//_dataDic[@"age"]?[NSString stringWithFormat:@"%@岁",_dataDic[@"age"]]:@"";
    _genderImg.image = [_dataDic[@"age"] integerValue] == 1? IMAGE_WITH_NAME(@"man"):[_dataDic[@"age"] integerValue] == 2? IMAGE_WITH_NAME(@"girl"):IMAGE_WITH_NAME(@"");
    _codeL.text = [NSString stringWithFormat:@"云算编号：%@",_dataDic[@"account"]];
    
    _comprehensiveGradeL.text = @"综合评分：78分";
    _timeL.text = @"接单时间：2008-11-10 14：30";
    
    [_nameL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_yearL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_yearL.mj_textWith + 5 *SIZE);
    }];
    
    [_codeL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_codeL.mj_textWith + 5 *SIZE);
    }];
    
    [_timeL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_timeL.mj_textWith + 5 *SIZE);
    }];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 30 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    for ( int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                [self.contentView addSubview:_nameL];
                break;
            }
            case 1:
            {
                _yearL = label;
                _yearL.font = FONT(11 *SIZE);
                _yearL.textColor = CL86Color;
                [self.contentView addSubview:_yearL];
                break;
            }
            case 2:
            {

                _codeL = label;
                _codeL.font = FONT(11 *SIZE);
                _codeL.textColor = CL86Color;
                [self.contentView addSubview:_codeL];
                break;
            }
            case 3:
            {
                _comprehensiveGradeL = label;
                _comprehensiveGradeL.font = FONT(11 *SIZE);
                _comprehensiveGradeL.textColor = CL86Color;
                _comprehensiveGradeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_comprehensiveGradeL];
                break;
            }
            case 4:
            {
                
                _timeL = label;
                _timeL.font = FONT(11 *SIZE);
                _timeL.textColor = CL86Color;
                [self.contentView addSubview:_timeL];
                break;
            }
            default:
                break;
        }
    }
    
    _phoneImg = [[UIImageView alloc] init];
    _phoneImg.image = IMAGE_WITH_NAME(@"phone");
    [self.contentView addSubview:_phoneImg];
    
    _comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
//    [_comfirmBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    _comfirmBtn.layer.cornerRadius = 2 *SIZE;
    _comfirmBtn.clipsToBounds = YES;
    [_comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_comfirmBtn setBackgroundColor:CLOrangeColor];
    [self.contentView addSubview:_comfirmBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(60 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_nameL.mas_right).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(self->_yearL.mj_textWith + 5 *SIZE);
    }];
    
    [_genderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_yearL.mas_right).offset(7 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.height.mas_equalTo(12 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(self->_codeL.mj_textWith + 5 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self->_codeL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(self->_timeL.mj_textWith + 5 *SIZE);
    }];
    
    [_comprehensiveGradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
    }];
    
    [_phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.top.equalTo(self.contentView).offset(36 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(59 *SIZE);
        make.width.mas_equalTo(57 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self->_comfirmBtn.mas_bottom).offset(8 *SIZE);
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
