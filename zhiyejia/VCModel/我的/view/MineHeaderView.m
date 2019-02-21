//
//  MineHeaderView.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.layer.cornerRadius = 3 *SIZE;
    self.clipsToBounds = YES;
    
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.cornerRadius = 3.3333333333333335;
    gradientLayer0.frame = self.bounds;
    gradientLayer0.colors = @[
                              (id)[UIColor colorWithRed:28.0f/255.0f green:151.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor,
                              (id)[UIColor colorWithRed:8.0f/255.0f green:182.0f/255.0f blue:251.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(0, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(1, 0)];
    [self.layer addSublayer:gradientLayer0];
    
    _roomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _roomBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    UILabel *rooLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 46 *SIZE, 113 *SIZE, 13 *SIZE)];
    rooLabel.textColor = CLWhiteColor;
    rooLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    rooLabel.textAlignment = NSTextAlignmentCenter;
    rooLabel.text = @"关注房源";
    [_roomBtn addSubview:rooLabel];
    UIImageView *roomImg = [[UIImageView alloc] initWithFrame:CGRectMake(46 *SIZE, 18 *SIZE, 20 *SIZE, 20 *SIZE)];
    roomImg.image = IMAGE_WITH_NAME(@"housing");
    [_roomBtn addSubview:roomImg];
    
    [self addSubview:_roomBtn];
    
    _agentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _agentBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    UILabel *agentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 46 *SIZE, 113 *SIZE, 13 *SIZE)];
    agentLabel.textColor = CLWhiteColor;
    agentLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    agentLabel.textAlignment = NSTextAlignmentCenter;
    agentLabel.text = @"关注经纪人";
    [_agentBtn addSubview:agentLabel];
    UIImageView *agentImg = [[UIImageView alloc] initWithFrame:CGRectMake(46 *SIZE, 18 *SIZE, 20 *SIZE, 20 *SIZE)];
    agentImg.image = IMAGE_WITH_NAME(@"agent");
    [_agentBtn addSubview:agentImg];
    [self addSubview:_agentBtn];
    
    _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _historyBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    UILabel *historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 46 *SIZE, 113 *SIZE, 13 *SIZE)];
    historyLabel.textColor = CLWhiteColor;
    historyLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    historyLabel.textAlignment = NSTextAlignmentCenter;
    historyLabel.text = @"浏览历史";
    [_historyBtn addSubview:historyLabel];
    //    [_roomBtn setTitle:@"关注房源" forState:UIControlStateNormal];
    UIImageView *historyImg = [[UIImageView alloc] initWithFrame:CGRectMake(46 *SIZE, 18 *SIZE, 20 *SIZE, 20 *SIZE)];
    historyImg.image = IMAGE_WITH_NAME(@"browse");
    [_historyBtn addSubview:historyImg];
//    [_historyBtn setTitle:@"浏览历史" forState:UIControlStateNormal];
//    [_historyBtn setImage:IMAGE_WITH_NAME(@"browse") forState:UIControlStateNormal];
    [self addSubview:_historyBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_roomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(113 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
    
    [_agentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(113 *SIZE);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(113 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
    
    [_historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(227 *SIZE);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(113 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
}

@end
