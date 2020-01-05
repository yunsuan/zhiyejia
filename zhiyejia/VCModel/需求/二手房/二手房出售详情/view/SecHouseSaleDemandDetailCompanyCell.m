//
//  SecHouseSaleDemandDetailCompanyCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandDetailCompanyCell.h"

@implementation SecHouseSaleDemandDetailCompanyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{

    _priceL.text = @"挂牌价：60万";
    _companyL.text = @"中介公司：123123";
    _numL.text = @"1";
    _statusL.text = @"勘察中";
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.secHouseSaleDemandDetailCompanyCellPhoneBlock) {
        
        self.secHouseSaleDemandDetailCompanyCellPhoneBlock();
    }
}

- (void)ActionExitBtn:(UIButton *)btn{
    
    if (self.secHouseSaleDemandDetailCompanyCellExitBlock) {
        
        self.secHouseSaleDemandDetailCompanyCellExitBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CLTitleLabColor;
    _companyL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_companyL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_priceL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = CLContentLabColor;
    _numL.font = FONT(13 *SIZE);
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.layer.cornerRadius = 15 *SIZE;
    _numL.clipsToBounds = YES;
    _numL.backgroundColor = CLLineColor;
    [self.contentView addSubview:_numL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLContentLabColor;
    _statusL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_statusL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_phoneBtn];
    
    _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _exitBtn.layer.cornerRadius = 3 *SIZE;
    _exitBtn.clipsToBounds = YES;
    [_exitBtn setTitle:@"解除服务" forState:UIControlStateNormal];
    _exitBtn.titleLabel.font = FONT(13 *SIZE);
    [_exitBtn setBackgroundColor:CLBlueBtnColor];
    [_exitBtn addTarget:self action:@selector(ActionExitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_exitBtn];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(60 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(60 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(100 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_companyL.mas_right).offset(15 *SIZE);
        make.top.equalTo(self.contentView.mas_bottom).offset(15 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
    }];
    
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.left.equalTo(self->_phoneBtn.mas_right).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
    //        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
