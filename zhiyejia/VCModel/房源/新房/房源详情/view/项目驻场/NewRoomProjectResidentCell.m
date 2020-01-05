//
//  NewRoomProjectResidentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewRoomProjectResidentCell.h"

@implementation NewRoomProjectResidentCell

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
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.newRoomProjectResidentCellPhoneBlock) {
        
        self.newRoomProjectResidentCellPhoneBlock();
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
