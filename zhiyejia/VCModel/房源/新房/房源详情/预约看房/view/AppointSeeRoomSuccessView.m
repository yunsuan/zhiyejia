//
//  AppointSeeRoomSuccessView.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AppointSeeRoomSuccessView.h"

@implementation AppointSeeRoomSuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAppointBtn:(UIButton *)btn{
    
    if (self.appointSeeRoomSuccessViewBlock) {
        
        self.appointSeeRoomSuccessViewBlock();
    }
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 167 *SIZE, 250 *SIZE, 331 *SIZE)];
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteView];

    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.text = @"恭喜您预约成功！";
    _titleL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = COLOR(182, 204, 212, 1);
    _contentL.font = [UIFont systemFontOfSize:13 *SIZE];
    _contentL.textAlignment = NSTextAlignmentCenter;
    _contentL.text = @"稍后会有工作人员与您电话联系";
    [_whiteView addSubview:_contentL];
    
    _appointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _appointBtn.frame = CGRectMake(0, 0, 203 *SIZE, 37 *SIZE);
    _appointBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_appointBtn addTarget:self action:@selector(ActionAppointBtn:) forControlEvents:UIControlEventTouchUpInside];
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.cornerRadius = 2 *SIZE;
    gradientLayer0.frame = _appointBtn.bounds;
    gradientLayer0.colors = @[
                              (id)[UIColor colorWithRed:28.0f/255.0f green:151.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:8.0f/255.0f green:182.0f/255.0f blue:251.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(1, 0)];
    [_appointBtn.layer addSublayer:gradientLayer0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 12 *SIZE, 203 *SIZE, 12 *SIZE)];
    label.textColor = CLWhiteColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"查看我的预约";
    [_appointBtn addSubview:label];
    [_whiteView addSubview:_appointBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(55 *SIZE);
        make.top.equalTo(self).offset(154 *SIZE);
        make.right.equalTo(self).offset(-55 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_whiteView).offset(116 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-15 *SIZE);
    }];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(21 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-15 *SIZE);
    }];
    
    [_appointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(24 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(26 *SIZE);
        make.width.equalTo(@(203 *SIZE));
        make.height.equalTo(@(37 *SIZE));
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-21 *SIZE);
    }];

}

@end
