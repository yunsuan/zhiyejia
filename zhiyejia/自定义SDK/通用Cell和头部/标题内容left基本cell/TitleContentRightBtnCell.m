//
//  TitleContentRightBtnCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "TitleContentRightBtnCell.h"

@implementation TitleContentRightBtnCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.titleContentRightBtnCellMoreBlock) {
    
        _moreBtn.userInteractionEnabled = NO;
        self.titleContentRightBtnCellMoreBlock();
        _moreBtn.userInteractionEnabled = YES;
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc]init];
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.numberOfLines = 0;
    _contentL.textColor = CLContentLabColor;
    [self.contentView addSubview:_contentL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@">>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:_lineView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-280 *SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(287 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(20 *SIZE));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_titleL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
