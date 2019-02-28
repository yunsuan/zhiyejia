//
//  MyAttentionAgentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MyAttentionAgentCell.h"

@implementation MyAttentionAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = @"张三";
    _yearL.text = @"23岁";
    _genderImg.image = IMAGE_WITH_NAME(@"man");
    _statusL.text = @"当前状态：在线";
    _codeL.text = @"云算编号：LD3312311";
    
    _comprehensiveGradeL.text = @"综合评分：78分";
    _serviceGradeL.text = @"服务评分：78分";
    _professionalGradeL.text = @"专业评分：78分";
    
    _distanceL.text = @"距我500m";
    _serviceDistrictL.text = @"服务区域：成都市郫都区，成都市郫都区，成都市郫都区，成都市郫都区";
    
    [_nameL mas_updateConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
    }];
    
    [_yearL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_yearL.mj_textWith + 5 *SIZE);
    }];
    
    [_statusL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_statusL.mj_textWith + 5 *SIZE);
    }];
    
    [_codeL mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self->_codeL.mj_textWith + 5 *SIZE);
    }];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.cornerRadius = 30 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    for ( int i = 0; i < 9; i++) {
        
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
                _statusL = label;
                _statusL.font = FONT(11 *SIZE);
                _statusL.textColor = CL86Color;
                [self.contentView addSubview:_statusL];
                break;
            }
            case 3:
            {
                _codeL = label;
                _codeL.font = FONT(11 *SIZE);
                _codeL.textColor = CL86Color;
                [self.contentView addSubview:_codeL];
                break;
            }
            case 4:
            {
                _comprehensiveGradeL = label;
                _comprehensiveGradeL.font = FONT(11 *SIZE);
                _comprehensiveGradeL.textColor = CL86Color;
                _comprehensiveGradeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_comprehensiveGradeL];
                break;
            }
            case 5:
            {
                _professionalGradeL = label;
                _professionalGradeL.font = FONT(11 *SIZE);
                _professionalGradeL.textColor = CL86Color;
                _professionalGradeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_professionalGradeL];
                break;
            }
            case 6:
            {
                _serviceGradeL = label;
                _serviceGradeL.font = FONT(11 *SIZE);
                _serviceGradeL.textColor = CL86Color;
                _serviceGradeL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_serviceGradeL];
                break;
            }
            case 7:
            {
                _serviceDistrictL = label;
                _serviceDistrictL.font = FONT(11 *SIZE);
                _serviceDistrictL.textColor = CL86Color;
                _serviceDistrictL.numberOfLines = 0;
                [self.contentView addSubview:_serviceDistrictL];
                break;
            }
            case 8:
            {
                _distanceL = label;
                _distanceL.font = FONT(11 *SIZE);
                _distanceL.textColor = CLBlueBtnColor;
                _distanceL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_distanceL];
                break;
            }
            default:
                break;
        }
    }
    
    _phoneImg = [[UIImageView alloc] init];
    _phoneImg.image = IMAGE_WITH_NAME(@"phone");
    [self.contentView addSubview:_phoneImg];
    
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
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self.contentView).offset(41 *SIZE);
        make.width.mas_equalTo(self->_statusL.mj_textWith + 5 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(89 *SIZE);
        make.top.equalTo(self.contentView).offset(63 *SIZE);
        make.width.mas_equalTo(self->_codeL.mj_textWith + 5 *SIZE);
    }];
    
    [_comprehensiveGradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
    }];
    
    [_professionalGradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(42 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
    }];
    
    [_serviceGradeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(63 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
    }];
    
    [_phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.top.equalTo(self.contentView).offset(94 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_serviceDistrictL mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(46 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_distanceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(85 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(45 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self->_serviceDistrictL.mas_bottom).offset(14 *SIZE);
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
