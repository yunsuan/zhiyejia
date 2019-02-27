//
//  MyMessageCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MyMessageCell.h"

@implementation MyMessageCell

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
    _headImg.layer.cornerRadius = 20 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CL170Color;
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.numberOfLines = 0;
    _contentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_contentL];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(13 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.height.mas_equalTo(40 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(64 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(21 *SIZE);
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.width.mas_equalTo(35 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(64 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(5 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
