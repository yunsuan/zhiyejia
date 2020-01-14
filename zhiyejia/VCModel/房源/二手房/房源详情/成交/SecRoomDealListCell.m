//
//  SecRoomDealListCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecRoomDealListCell.h"

@implementation SecRoomDealListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            self->_headImg.image = [UIImage imageNamed:@"default_3"];
        }
    }];
    
    
    
    //    _titleL.text = [NSString stringWithFormat:@"%@(%@)",model.title,[model.hide integerValue] == 0?@"公开":@"非公开"];
    _titleL.text = [NSString stringWithFormat:@"%@ %@",dataDic[@"project_name"],dataDic[@"house_type"]];
    _contentL.text = [NSString stringWithFormat:@"%@ %@㎡",dataDic[@"build_name"],dataDic[@"build_area"]];
    _timeL.text = [NSString stringWithFormat:@"成交时间：%@",dataDic[@"contract_time"]];
    _priceL.text = [NSString stringWithFormat:@"成交总价：%@元",dataDic[@"deal_money"]];
    _companyL.text = [NSString stringWithFormat:@"公司：%@",dataDic[@"company_name"]];
    _storeL.text = [NSString stringWithFormat:@"门店：%@",dataDic[@"store_name"]];
    _agentL.text = [NSString stringWithFormat:@"经纪人：%@",dataDic[@"agent_name"]];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(12 *SIZE, 16 *SIZE, 100 *SIZE, 88 *SIZE)];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_contentL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = COLOR(255, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _priceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceL];

    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CLContentLabColor;
    _companyL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_companyL];
    
    _storeL = [[UILabel alloc] init];
    _storeL.textColor = CLContentLabColor;
    _storeL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _storeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_storeL];
    
    _agentL = [[UILabel alloc] init];
    _agentL.textColor = CLContentLabColor;
    _agentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _agentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_agentL];

    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-45 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(8 *SIZE);
        make.width.mas_lessThanOrEqualTo(115 *SIZE);
    }];
        
    [_agentL mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(8 *SIZE);
        make.width.mas_lessThanOrEqualTo(115 *SIZE);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_agentL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}

@end
