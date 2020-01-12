//
//  SecHouseBuyDemandDetailRecommendLookRecordCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/7.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailRecommendLookRecordCell.h"

@implementation SecHouseBuyDemandDetailRecommendLookRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _timeL.text = @"看房时间：2020.1.1";
    _priceL.text = @"出价金额：20万";
    _agentL.text = @"带看经纪人：50";
    _companyL.text = @"成都大唐";
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.secHouseBuyDemandDetailRecommendLookRecordCellPhoneBlock) {
        
        self.secHouseBuyDemandDetailRecommendLookRecordCellPhoneBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLTitleLabColor;
    _timeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_timeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_priceL];
    
    _agentL = [[UILabel alloc] init];
    _agentL.textColor = CLContentLabColor;
    _agentL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_agentL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CLContentLabColor;
    _companyL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_companyL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_phoneBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        
    }];
    
    [_agentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_agentL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self.contentView.mas_bottom).offset(50 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0 *SIZE);
    }];
}

@end
