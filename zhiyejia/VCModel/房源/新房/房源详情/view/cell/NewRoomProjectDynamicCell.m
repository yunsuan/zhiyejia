//
//  NewRoomProjectDynamicCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomProjectDynamicCell.h"

@implementation NewRoomProjectDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.newRoomProjectDynamicCellBlock) {
        
        self.newRoomProjectDynamicCellBlock();
    }
}

- (void)initUI{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 65 *SIZE, 15 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"项目动态";
    [self.contentView addSubview:label];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 3 *SIZE, 15 *SIZE, 120 *SIZE, 15 *SIZE)];
    _numL.textColor = COLOR(27, 152, 255, 1);
    _numL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_numL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(287 *SIZE, 13 *SIZE, 65 *SIZE, 20 *SIZE);
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _contentL = [[UILabel alloc] init];
    //    _contentL.numberOfLines = 2;
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.numberOfLines = 2;
    [self.contentView addSubview:self.contentL];
    
    [self MasonyUI];
}

- (void)MasonyUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(56 *SIZE);
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.bottom.equalTo(self->_timeL.mas_top).offset(-10 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.bottom.equalTo(self->_contentL.mas_top).offset(-15 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.height.equalTo(@(32 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
