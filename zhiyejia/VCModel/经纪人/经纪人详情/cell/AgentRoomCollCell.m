//
//  AgentRoomCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentRoomCollCell.h"

@implementation AgentRoomCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_roomImg.image = [UIImage imageNamed:@"default_2"];
        }
    }];
    
    _titleL.text = dataDic[@"title"];
    _roomNumL.text = dataDic[@"house_name"];
    _houseTypeL.text = [NSString stringWithFormat:@"户型：%@",[dataDic[@"house_type"] integerValue]?dataDic[@"house_type_name"]:@""];
    _areaL.text = [NSString stringWithFormat:@"建面：%@㎡",dataDic[@"build_size"]];;
    _typeL.text = [NSString stringWithFormat:@"类型：%@",dataDic[@"property_type"]];;
    _priceL.text = [NSString stringWithFormat:@"%@万",dataDic[@"total_price"]];;
    _attentionL.text = [NSString stringWithFormat:@"关注：%@",dataDic[@"collect_num"]];;
    _seeL.text = [NSString stringWithFormat:@"浏览：%@",dataDic[@"browse_num"]];;
    _stateL.text = [dataDic[@"state"] integerValue] == 1?@"未售":@"已售";
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.contentMode = UIViewContentModeScaleAspectFill;
    _roomImg.clipsToBounds = YES;
    [self.contentView addSubview:_roomImg];
    
    _specialL = [[UILabel alloc] init];
    _specialL.backgroundColor = CLOrangeColor;
    _specialL.textColor = CLWhiteColor;
    _specialL.textAlignment = NSTextAlignmentCenter;
    _specialL.font = [UIFont systemFontOfSize:11 *SIZE];
    _specialL.hidden = YES;
    [_roomImg addSubview:_specialL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLNewTitleColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _roomNumL = [[UILabel alloc] init];
    _roomNumL.textColor = CLNewContentColor;
    _roomNumL.font = [UIFont systemFontOfSize:10 *SIZE];
    [self.contentView addSubview:_roomNumL];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLNewContentColor;
        label.font = [UIFont systemFontOfSize:10 *SIZE];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.textColor = CLContentLabColor;
        label1.textAlignment = NSTextAlignmentRight;
        label1.font = [UIFont systemFontOfSize:10 *SIZE];
        

        if (i == 0) {
            
            _houseTypeL = label;
            _stateL = label1;
            _stateL.textColor = [UIColor redColor];
            _stateL.font = [UIFont systemFontOfSize:13 *SIZE];
            
        }else if (i == 1){
            
            _areaL = label;
            _attentionL = label1;

        }else{
            
            _typeL = label;
            _seeL = label1;
        }
    }
    [self.contentView addSubview:_houseTypeL];
    [self.contentView addSubview:_areaL];
    [self.contentView addSubview:_typeL];
    
    [self.contentView addSubview:_stateL];
    [self.contentView addSubview:_attentionL];
    [self.contentView addSubview:_seeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLNewRedColor;
    _priceL.font = [UIFont systemFontOfSize:20 *SIZE];
    _priceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(19 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
        make.height.mas_equalTo(67 *SIZE);
    }];

    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(115 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
    }];
    
    [_stateL mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.right.equalTo(self.contentView).offset(-31 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
    }];
    
    [_roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(115 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(8 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(115 *SIZE);
        make.top.equalTo(self->_roomNumL.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-31 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(115 *SIZE);
        make.top.equalTo(self->_houseTypeL.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_attentionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_houseTypeL.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_roomImg.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
