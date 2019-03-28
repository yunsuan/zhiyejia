//
//  NewRoomHouseInfoCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomHouseInfoCell.h"

@implementation NewRoomHouseInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _typeL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 11 *SIZE, 200 *SIZE, 12 *SIZE)];
    _typeL.textColor = CLTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_typeL];
    
    _areaL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 36 *SIZE, 300 *SIZE, 12 *SIZE)];
    _areaL.textColor = CLContentLabColor;
    _areaL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_areaL];
    
    _houseDisL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 60 *SIZE, 300 *SIZE, 12 *SIZE)];
    _houseDisL.textColor = CLContentLabColor;
    _houseDisL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_houseDisL];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 93 *SIZE, 300 *SIZE, 14 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.numberOfLines = 0;
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_contentL];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(self.contentView).offset(120 *SIZE);
        make.right.equalTo(self.contentView).offset(-16 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-23 *SIZE);
    }];
}

@end
