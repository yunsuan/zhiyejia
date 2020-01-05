//
//  RightBtnColorHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "RightBtnColorHeader.h"

@implementation RightBtnColorHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.rightBtnColorHeaderMoreBlock) {
    
        _moreBtn.userInteractionEnabled = NO;
        self.rightBtnColorHeaderMoreBlock();
        _moreBtn.userInteractionEnabled = YES;
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _colorView = [[UIView alloc] init];
    _colorView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:_colorView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"小区详情 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    //    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.equalTo(@(300 *SIZE));
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(287 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.equalTo(@(65 *SIZE));
        make.height.equalTo(@(20 *SIZE));
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(325 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        //        make.bottom.equalTo(self.contentView).offset(10 *SIZE);
        make.width.equalTo(@(20 *SIZE));
        make.height.equalTo(@(20 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(13 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(SIZE));
    }];
}

@end
