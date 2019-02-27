//
//  MySubscibeCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MySubscibeCell.h"

@implementation MySubscibeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLBlueBtnColor;
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_statusL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = CLContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_addressL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(121 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(121 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-40 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(25 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(121 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(-40 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
