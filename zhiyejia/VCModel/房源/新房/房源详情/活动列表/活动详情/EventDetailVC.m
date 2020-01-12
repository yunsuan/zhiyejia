//
//  EventDetailVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/9.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "EventDetailVC.h"

@interface EventDetailVC ()

@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *periodL;

@property (nonatomic, strong) UILabel *methodL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *myBtn;

@end

@implementation EventDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionMyBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"活动详情";
    
    _scroll = [[UIScrollView alloc] init];
    [self.view addSubview:_scroll];
    
    _titleL = [[UILabel alloc] init];
    _titleL.font = FONT(15 *SIZE);
    _titleL.textColor = CLTitleLabColor;
    _titleL.numberOfLines = 0;
    _titleL.adjustsFontSizeToFitWidth = YES;
    [_scroll addSubview:_titleL];
    
    _periodL = [[UILabel alloc] init];
    _periodL.font = FONT(13 *SIZE);
    _periodL.textColor = CLContentLabColor;
    _periodL.numberOfLines = 0;
    _periodL.adjustsFontSizeToFitWidth = YES;
    [_scroll addSubview:_periodL];
    
    _methodL = [[UILabel alloc] init];
    _methodL.font = FONT(13 *SIZE);
    _methodL.textColor = CLContentLabColor;
    _methodL.numberOfLines = 0;
    _methodL.adjustsFontSizeToFitWidth = YES;
    [_scroll addSubview:_methodL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.font = FONT(13 *SIZE);
    _addressL.textColor = CLContentLabColor;
    _addressL.numberOfLines = 0;
    _addressL.adjustsFontSizeToFitWidth = YES;
    [_scroll addSubview:_addressL];
    
    _contactL = [[UILabel alloc] init];
    _contactL.font = FONT(13 *SIZE);
    _contactL.textColor = CLContentLabColor;
    _contactL.numberOfLines = 0;
    _contactL.adjustsFontSizeToFitWidth = YES;
    [_scroll addSubview:_contactL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.font = FONT(13 *SIZE);
    _phoneL.textColor = CLContentLabColor;
    _phoneL.numberOfLines = 0;
    _phoneL.adjustsFontSizeToFitWidth = YES;
    [_scroll addSubview:_phoneL];
    
    _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_myBtn addTarget:self action:@selector(ActionMyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scroll addSubview:_myBtn];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(20 *SIZE);
        make.top.equalTo(_scroll).offset(15 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
    }];
    
    [_periodL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(20 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
    }];
    
    [_methodL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(20 *SIZE);
        make.top.equalTo(_periodL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(20 *SIZE);
        make.top.equalTo(_methodL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
    }];
    
    [_contactL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(20 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(20 *SIZE);
        make.top.equalTo(_contactL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
    }];
    
    [_myBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_scroll).offset(20 *SIZE);
        make.top.equalTo(_phoneL.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(320 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(_scroll.mas_bottom).offset(-20 *SIZE);
    }];
}

@end
