//
//  DemandBuyCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "DemandBuyCell.h"

@implementation DemandBuyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _regionL.text = @"成都市青羊区";
    _statusL.text = @"待接单";
    _typeL.text = @"物业类型：住宅";
    _priceL.text = @"意向总价：80-90万";
    _areaL.text = @"意向总价：40-100㎡";
    _houseTypeL.text = @"意向户型：两室一厅";
    _useL.text = @"购买用途：自住";
    _decorateL.text = @"装修标准：精装";
    _otherL.text = @"其他要求：无";
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 2 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _regionL = [[UILabel alloc] init];
    _regionL.textColor = CLTitleLabColor;
    _regionL.font = FONT(15 *SIZE);
    [_whiteView addSubview:_regionL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLContentLabColor;
    _statusL.font = FONT(13 *SIZE);
    _statusL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_statusL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = FONT(13 *SIZE);
    [_whiteView addSubview:_typeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = FONT(13 *SIZE);
    _priceL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_priceL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLContentLabColor;
    _areaL.font = FONT(13 *SIZE);
    [_whiteView addSubview:_areaL];
    
    _houseTypeL = [[UILabel alloc] init];
    _houseTypeL.textColor = CLContentLabColor;
    _houseTypeL.font = FONT(13 *SIZE);
    _houseTypeL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_houseTypeL];
    
    _useL = [[UILabel alloc] init];
    _useL.textColor = CLContentLabColor;
    _useL.font = FONT(13 *SIZE);
    [_whiteView addSubview:_useL];
    
    _decorateL = [[UILabel alloc] init];
    _decorateL.textColor = CLContentLabColor;
    _decorateL.font = FONT(13 *SIZE);
    _decorateL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_decorateL];
    
    _otherL = [[UILabel alloc] init];
    _otherL.textColor = CLContentLabColor;
    _otherL.font = FONT(13 *SIZE);
    _otherL.numberOfLines = 0;
    [_whiteView addSubview:_otherL];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(330 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8 *SIZE);
    }];
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_whiteView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_whiteView).offset(-15 *SIZE);
        make.top.equalTo(self->_whiteView).offset(17 *SIZE);
        make.width.mas_lessThanOrEqualTo(50 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_whiteView).offset(-15 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_whiteView).offset(-15 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_useL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_whiteView).offset(-15 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_otherL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_useL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        make.bottom.equalTo(self->_whiteView).offset(-15 *SIZE);
    }];
}

@end
