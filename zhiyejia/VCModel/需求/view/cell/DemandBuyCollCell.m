//
//  DemandBuyCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "DemandBuyCollCell.h"

@implementation DemandBuyCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _titleL.text = [NSString stringWithFormat:@"%@%@",dataDic[@"city_name"],dataDic[@"district"]];
    _statusL.text = dataDic[@"current_state_name"];
    _typeL.text = [NSString stringWithFormat:@"物业类型：%@",dataDic[@"type_name"]];
    _priceL.text = [NSString stringWithFormat:@"意向总价：%@-%@万",dataDic[@"price_min"],dataDic[@"price_max"]];
    NSMutableAttributedString *priceAttr = [[NSMutableAttributedString alloc] initWithString:_priceL.text];
    [priceAttr addAttribute:NSForegroundColorAttributeName value:CLNewContentColor range:NSMakeRange(0, 5)];
    _priceL.attributedText = priceAttr;
    _areaL.text = [NSString stringWithFormat:@"意向面积：%@-%@㎡",dataDic[@"area_min"],dataDic[@"area_max"]];
    NSMutableAttributedString *areaAttr = [[NSMutableAttributedString alloc] initWithString:_areaL.text];
    [areaAttr addAttribute:NSForegroundColorAttributeName value:CLNewContentColor range:NSMakeRange(0, 5)];
    _areaL.attributedText = areaAttr;
}

- (void)ActionTap{
    
    if (self.demandBuyCollCellBlock) {
        
        self.demandBuyCollCellBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    [self.contentView addSubview:_whiteView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLNewTitleColor;
    _titleL.font = FONT(15 *SIZE);
    [_whiteView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLNewTitleColor;
    _statusL.font = FONT(15 *SIZE);
    _statusL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_statusL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLNewContentColor;
    _typeL.font = FONT(14 *SIZE);
    [_whiteView addSubview:_typeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLNewRedColor;
    _priceL.font = FONT(14 *SIZE);
    [_whiteView addSubview:_priceL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLNewRedColor;
    _areaL.font = FONT(14 *SIZE);
    [_whiteView addSubview:_areaL];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(338 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_whiteView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(14 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(19 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(14 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
//        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-29 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(14 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-29 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_whiteView).offset(-26 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(17 *SIZE);
        make.width.mas_lessThanOrEqualTo(55 *SIZE);
    }];
}

@end
