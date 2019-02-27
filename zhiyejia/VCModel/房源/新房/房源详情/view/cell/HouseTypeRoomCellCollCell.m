//
//  HouseTypeRoomCellCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "HouseTypeRoomCellCollCell.h"

@implementation HouseTypeRoomCellCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _typeImg = [[UIImageView alloc] init];
    _typeImg.contentMode = UIViewContentModeScaleAspectFill;
    _typeImg.clipsToBounds = YES;
    [self.contentView addSubview:_typeImg];
    
    _letterL = [[UILabel alloc] init];
    _letterL.textColor = CLTitleLabColor;
    _letterL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_letterL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLTitleLabColor;
    _areaL.font = [UIFont systemFontOfSize:12 *SIZE];
    //    _areaL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_areaL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = COLOR(27, 152, 255, 1);
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_statusL];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_typeImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.height.mas_equalTo(103 *SIZE);
    }];
    
    [_letterL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_typeImg.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(103 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_letterL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(103 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(103 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(103 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-12 *SIZE);
    }];
}

@end
