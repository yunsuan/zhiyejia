//
//  SecRoomHouseMaintainCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/6.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecRoomHouseMaintainCell.h"

@implementation SecRoomHouseMaintainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = FONT(13 *SIZE);
    _contentL.adjustsFontSizeToFitWidth = YES;
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];
    
    _pointView = [[UIView alloc] init];
    _pointView.layer.cornerRadius = 5 *SIZE;
    _pointView.clipsToBounds = YES;
    _pointView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_pointView];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(30 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(310 *SIZE);
        make.top.equalTo(self.contentView).offset(-15 *SIZE);
    }];
    
    [_pointView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
//        make.top.equalTo(self->_contentL.mas_bottom).offset(15 *SIZE);
        make.width.height.mas_equalTo(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
    }];
}

@end
