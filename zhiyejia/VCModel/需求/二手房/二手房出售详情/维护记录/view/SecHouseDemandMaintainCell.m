//
//  SecHouseDemandMaintainCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseDemandMaintainCell.h"

@implementation SecHouseDemandMaintainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _agentL.text = @"带看经纪人：来说都";
    _companyL.text = @"所属公司：阿萨德马上都";
//    _timeL.text = @"带看日期：2020.1.1";
    _detailL.text = @"维护内容：奥术大师大";
//    _priceL.text = @"买方出价：131";
//    _commentL.text = @"买房评论：1231231";
}


- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.secHouseDemandMaintainCellPhoneBlock) {
        
        self.secHouseDemandMaintainCellPhoneBlock();
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
    
    _detailL = [[UILabel alloc] init];
    _detailL.textColor = CLTitleLabColor;
    _detailL.font = FONT(13 *SIZE);
    _detailL.numberOfLines = 0;
    [self.contentView addSubview:_detailL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(20 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(300 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_detailL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self.contentView.mas_bottom).offset(50 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
