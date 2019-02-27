//
//  MyAppointCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MyAppointCell.h"

@implementation MyAppointCell

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
    _titleL.numberOfLines = 2;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textAlignment = NSTextAlignmentRight;
    _statusL.font = [UIFont systemFontOfSize:13 *SIZE];
    _statusL.textColor = CLContentLabColor;
    [self.contentView addSubview:_statusL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.numberOfLines = 2;
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_contentL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.textColor = CLContentLabColor;
    [self.contentView addSubview:_timeL];
    
    _markL = [[UILabel alloc] init];
    _markL.numberOfLines = 2;
    _markL.font = [UIFont systemFontOfSize:13 *SIZE];
    _markL.textColor = CLContentLabColor;
    [self.contentView addSubview:_markL];

    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(121 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(121 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(121 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(121 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
    }];
    
}

@end
