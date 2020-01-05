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

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _typeImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_typeImg];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.numberOfLines = 2;
    [self.contentView addSubview:self.contentL];
    
    [self MasonyUI];
}

- (void)MasonyUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(70 *SIZE);
    }];
    
    [_typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(20 *SIZE);
        make.height.mas_equalTo(15 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(105 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15 *SIZE);
    }];
}

@end
