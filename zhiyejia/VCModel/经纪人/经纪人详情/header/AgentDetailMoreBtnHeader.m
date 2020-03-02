//
//  AgentDetailMoreBtnHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentDetailMoreBtnHeader.h"

@implementation AgentDetailMoreBtnHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
//        [self initUI];
    }
    return self;
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.agentDetailMoreBtnHeaderMoreBlock) {
        
        self.agentDetailMoreBtnHeaderMoreBlock();
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.agentDetailMoreBtnHeaderAddBlock) {
        
        self.agentDetailMoreBtnHeaderAddBlock();
    }
}


- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.colorView = [[UIView alloc] init];//WithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 7 *SIZE, 13 *SIZE)];
    self.colorView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:self.colorView];
    
    self.titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(28 *SIZE, 13 *SIZE, 230 *SIZE, 15 *SIZE)];
    self.titleL.textColor = CLTitleLabColor;
    self.titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:self.titleL];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12 *SIZE];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitle:@"推荐历史 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CL170Color forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"我也评价" forState:UIControlStateNormal];
    [_addBtn setBackgroundColor:CLBlueBtnColor];
    _addBtn.layer.cornerRadius = 15 *SIZE;
    _addBtn.clipsToBounds = YES;
    _addBtn.titleLabel.font = FONT(11 *SIZE);
    [self.contentView addSubview:_addBtn];
    
    self.lineView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width , SIZE)];
    self.lineView.backgroundColor = CLLineColor;
    [self.contentView addSubview:self.lineView];
    
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-100 *SIZE);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(5 *SIZE);
        make.width.mas_equalTo(90 *SIZE);
        make.height.mas_equalTo(30 *SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-105 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(75 *SIZE);
        make.height.mas_equalTo(25 *SIZE);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(39 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
