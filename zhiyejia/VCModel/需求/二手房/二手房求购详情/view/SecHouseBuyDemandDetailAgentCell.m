//
//  SecHouseBuyDemandDetailAgentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailAgentCell.h"

@implementation SecHouseBuyDemandDetailAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"agent_img"]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_headImg.image = IMAGE_WITH_NAME(@"def_head");
        }
    }];
    _nameL.text = dataDic[@"agent_name"];
//    _professionL.text = @"专业评分：20";
    _professionL.text = @" ";
//    _serviceL.text = @"服务评分：50";
    _serviceL.text = @" ";
    _typeL.text = dataDic[@"store_name"];
}

- (void)ActionWorkBtn:(UIButton *)btn{
    
    if (self.secHouseBuyDemandDetailAgentCellWorkBlock) {
        
        self.secHouseBuyDemandDetailAgentCellWorkBlock();
    }
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.secHouseBuyDemandDetailAgentCellPhoneBlock) {
        
        self.secHouseBuyDemandDetailAgentCellPhoneBlock();
    }
}

- (void)ActionChangeBtn:(UIButton *)btn{
    
    if (self.secHouseBuyDemandDetailAgentCellChangeBlock) {
        
        self.secHouseBuyDemandDetailAgentCellChangeBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _headImg = [[UIImageView alloc] init];
//    _headImg.textColor = CLTitleLabColor;
//    _headImg.font = FONT(13 *SIZE);
    _headImg.layer.cornerRadius = 25 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_nameL];
    
    _professionL = [[UILabel alloc] init];
    _professionL.textColor = CLContentLabColor;
    _professionL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_professionL];
    
    _serviceL = [[UILabel alloc] init];
    _serviceL.textColor = CLContentLabColor;
    _serviceL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_serviceL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_typeL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setImage:IMAGE_WITH_NAME(@"phone1") forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_changeBtn];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.height.mas_equalTo(50 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
        
    }];
    
    [_professionL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(100 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_serviceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_professionL.mas_right).offset(15 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(100 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self.contentView).offset(50 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self.contentView.mas_bottom).offset(10 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
    //        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
