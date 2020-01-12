//
//  SecRoomProjectAgentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/12.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecRoomProjectAgentCell.h"

@implementation SecRoomProjectAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = @"利用";
    _professionL.text = @"综合评分：20";
    _companyL.text = @"大唐";
    _historyL.text = @"成交历史（买卖10套 租赁0套）近30天带看10次";
}

- (void)ActionWorkBtn:(UIButton *)btn{
    
    if (self.secRoomProjectAgentCellWorkBlock) {
        
        self.secRoomProjectAgentCellWorkBlock();
    }
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.secRoomProjectAgentCellPhoneBlock) {
        
        self.secRoomProjectAgentCellPhoneBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _headImg = [[UIImageView alloc] init];
//    _headImg.textColor = CLTitleLabColor;
//    _headImg.font = FONT(13 *SIZE);
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_nameL];
    
    _professionL = [[UILabel alloc] init];
    _professionL.textColor = CLContentLabColor;
    _professionL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_professionL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CLContentLabColor;
    _companyL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_companyL];
    
    _historyL = [[UILabel alloc] init];
    _historyL.textColor = CLContentLabColor;
    _historyL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_historyL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_phoneBtn];
    
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
    
    [_professionL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_nameL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(100 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(100 *SIZE);
    }];

    [_historyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self.contentView.mas_bottom).offset(50 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
