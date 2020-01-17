//
//  FailView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "FailView.h"

@implementation FailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionBackBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.failViewBlock) {
        
        self.failViewBlock(_reasonTV.text);
    }
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 230 *SIZE, 250 *SIZE, 270 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 *SIZE, 250 *SIZE, 16 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:17 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.text = @"取消发布";
    [_whiteView addSubview:_titleL];
    
    _reasonTV = [[UITextView alloc] initWithFrame:CGRectMake(42 *SIZE, 44 *SIZE, 167 *SIZE, 100 *SIZE)];
    _reasonTV.layer.cornerRadius = 5 *SIZE;
    _reasonTV.clipsToBounds = YES;
    _reasonTV.layer.borderColor = CLLineColor.CGColor;
    _reasonTV.layer.borderWidth = SIZE;
    [_whiteView addSubview:_reasonTV];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(42 *SIZE, 154 *SIZE, 167 *SIZE, 37 *SIZE);
    btn1.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    _confirmBtn = btn1;
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    _confirmBtn.layer.borderWidth = SIZE;
    _confirmBtn.layer.borderColor = [UIColor redColor].CGColor;
    [_whiteView addSubview:_confirmBtn];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(42 *SIZE, 200 *SIZE, 167 *SIZE, 37 *SIZE);
    btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    _backBtn = btn;
    [_backBtn addTarget:self action:@selector(ActionBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setBackgroundColor:CLBlueBtnColor];
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _backBtn.layer.cornerRadius = 2 *SIZE;
    _backBtn.clipsToBounds = YES;
    [_whiteView addSubview:_backBtn];
    
//    [self masonryUI];
}
//
//- (void)masonryUI{
//
//    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self).offset(55 *SIZE);
//        make.top.equalTo(self).offset(154 *SIZE);
//        make.right.equalTo(self).offset(-55 *SIZE);
//    }];
//
//    [_ mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_whiteView).offset(22 *SIZE);
//        make.top.equalTo(_whiteView).offset(69 *SIZE);
//        make.right.equalTo(_whiteView).offset(-22 *SIZE);
//    }];
//    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_whiteView).offset(22 *SIZE);
//        make.top.equalTo(_reasonL.mas_bottom).offset(12 *SIZE);
//        make.right.equalTo(_whiteView).offset(-22 *SIZE);
//    }];
//    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_whiteView).offset(42 *SIZE);
//        make.top.equalTo(_timeL.mas_bottom).offset(31 *SIZE);
//        make.right.equalTo(_whiteView).offset(-42 *SIZE);
//        make.height.equalTo(@(37 *SIZE));
//        make.bottom.equalTo(_whiteView.mas_bottom).offset(-24 *SIZE);
//    }];
//}

@end
