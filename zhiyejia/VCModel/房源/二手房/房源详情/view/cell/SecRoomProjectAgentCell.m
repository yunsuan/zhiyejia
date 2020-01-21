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
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"head_img"]]] placeholderImage:IMAGE_WITH_NAME(@"") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_headImg.image = IMAGE_WITH_NAME(@"def_head");
        }
    }];
    _nameL.text = dataDic[@"agent_name"];
//    _professionL.text = @"综合评分：20";
    _companyL.text = dataDic[@"company_name"];
//    _historyL.text = @"成交历史（买卖10套 租赁0套）近30天带看10次";
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
    _headImg.clipsToBounds = YES;
    _headImg.layer.cornerRadius = 25 *SIZE;
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
    _companyL.numberOfLines = 0;
    [self.contentView addSubview:_companyL];
    
    _historyL = [[UILabel alloc] init];
    _historyL.textColor = CLContentLabColor;
    _historyL.font = FONT(13 *SIZE);
    _historyL.numberOfLines = 0;
    [self.contentView addSubview:_historyL];
    
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn setImage:IMAGE_WITH_NAME(@"phone1") forState:UIControlStateNormal];
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
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];

    [_historyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_companyL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_historyL.mas_bottom).offset(15 *SIZE);
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
