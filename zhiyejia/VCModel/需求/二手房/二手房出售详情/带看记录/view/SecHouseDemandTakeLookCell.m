//
//  SecHouseDemandTakeLookCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseDemandTakeLookCell.h"

@implementation SecHouseDemandTakeLookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _agentL.text = [NSString stringWithFormat:@"带看经纪人：%@",dataDic[@"agent_name"]];
    _companyL.text = [NSString stringWithFormat:@"所属公司：%@",dataDic[@"agent_name"]];
    _timeL.text = [NSString stringWithFormat:@"带看日期：%@",dataDic[@"take_time"]];
    _detailL.text = [NSString stringWithFormat:@"带看情况：%@",dataDic[@"take_time"]];
    _priceL.text = [NSString stringWithFormat:@"买方出价：%@",[dataDic[@"price"] integerValue]?dataDic[@"price"]:@"无"];
    _commentL.text = [NSString stringWithFormat:@"买房评论：%@",dataDic[@"take_time"]];
}


- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.secHouseDemandTakeLookCellPhoneBlock) {
        
        self.secHouseDemandTakeLookCellPhoneBlock();
    }
}


- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _agentL = [[UILabel alloc] init];
    _agentL.textColor = CLTitleLabColor;
    _agentL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_agentL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CLTitleLabColor;
    _companyL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_companyL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLTitleLabColor;
    _timeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_timeL];
    
    _detailL = [[UILabel alloc] init];
    _detailL.textColor = CLTitleLabColor;
    _detailL.font = FONT(13 *SIZE);
    _detailL.numberOfLines = 0;
    [self.contentView addSubview:_detailL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLTitleLabColor;
    _priceL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_priceL];
    
    _commentL = [[UILabel alloc] init];
    _commentL.textColor = CLTitleLabColor;
    _commentL.font = FONT(13 *SIZE);
    _commentL.numberOfLines = 0;
    [self.contentView addSubview:_commentL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setImage:IMAGE_WITH_NAME(@"phone1") forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    [_agentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(300 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self->_agentL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(300 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(300 *SIZE);
    }];
    
    [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(300 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self->_detailL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(300 *SIZE);
    }];

    [_commentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(300 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_commentL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self.contentView).offset(50 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
