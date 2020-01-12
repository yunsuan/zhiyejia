//
//  NewRoomDiscountCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewRoomDiscountCell.h"

@implementation NewRoomDiscountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.newRoomDiscountCellBlock) {
        
        self.newRoomDiscountCellBlock();
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.text = @"优惠促销";
    [self.contentView addSubview:_titleL];
    
//    _typeImg = [[UIImageView alloc] init];
//    [self.contentView addSubview:_typeImg];
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = [UIColor redColor];
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _typeL.layer.borderWidth = SIZE;
    _typeL.textAlignment = NSTextAlignmentCenter;
    _typeL.layer.borderColor = [UIColor redColor].CGColor;
    [self.contentView addSubview:_typeL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _contentL.numberOfLines = 2;
    [self.contentView addSubview:self.contentL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(287 *SIZE, 13 *SIZE, 65 *SIZE, 20 *SIZE);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonyUI];
}

- (void)MasonyUI{
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(70 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_titleL.mas_right).offset(3 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(_typeL.mj_textWidth + 5 *SIZE);
        make.height.mas_equalTo(15 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_typeL.mas_right).offset(3 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-80 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15 *SIZE);
    }];
}

@end
