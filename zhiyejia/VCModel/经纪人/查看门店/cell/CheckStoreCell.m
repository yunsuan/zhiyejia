//
//  CheckStoreCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CheckStoreCell.h"

@implementation CheckStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.text = @"链家大禹东路店";
    [self.contentView addSubview:_titleL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = CL86Color;
    _codeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _codeL.text = @"授权编号：LD123123123";
    [self.contentView addSubview:_codeL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = CL86Color;
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    _addressL.text = @"门店地址：成都市郫都区大禹东路94号";
    [self.contentView addSubview:_addressL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setImage:IMAGE_WITH_NAME(@"") forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    
    _distanceL = [[UILabel alloc] init];
    _distanceL.textColor = CLBlueBtnColor;
    _distanceL.font = [UIFont systemFontOfSize:11 *SIZE];
    _distanceL.text = @"距我200m";
    _distanceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_distanceL];
    
    _navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_navBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_navBtn setBackgroundColor:CLOrangeColor];
    _navBtn.titleLabel.font = FONT(11 *SIZE);
    _navBtn.layer.cornerRadius = 2 *SIZE;
    _navBtn.clipsToBounds = YES;
    [_navBtn setTitle:@"快速导航" forState:UIControlStateNormal];
    [self.contentView addSubview:_navBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(67 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(83 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.mas_equalTo(240 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-6 *SIZE);
        make.top.equalTo(self.contentView).offset(9 *SIZE);
        make.width.height.mas_equalTo(26 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(83 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
    }];
    
    [_distanceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(83 *SIZE);
        make.top.equalTo(self->_codeL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_codeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(57 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
