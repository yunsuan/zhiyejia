//
//  SecHouseSaleDemandDealVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandDealVC.h"

@interface SecHouseSaleDemandDealVC ()

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *agentL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UIButton *commentBtn;

@end

@implementation SecHouseSaleDemandDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    
}

- (void)ActionCommentBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.text = @"成交详情";
    
    _priceL = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, NAVIGATION_BAR_HEIGHT + 20 *SIZE, SCREEN_Width - 40 *SIZE, 18 *SIZE)];
    _priceL.textAlignment = NSTextAlignmentCenter;
    _priceL.textColor = [UIColor redColor];
    [self.view addSubview:_priceL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, NAVIGATION_BAR_HEIGHT + 50 *SIZE, SCREEN_Width - 40 *SIZE, 18 *SIZE)];
    _timeL.textColor = [UIColor redColor];
    [self.view addSubview:_timeL];
    
    _agentL = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, NAVIGATION_BAR_HEIGHT + 70 *SIZE, SCREEN_Width - 40 *SIZE, 18 *SIZE)];
    _agentL.textColor = [UIColor redColor];
    [self.view addSubview:_agentL];
    
    _companyL = [[UILabel alloc] initWithFrame:CGRectMake(20 *SIZE, NAVIGATION_BAR_HEIGHT + 90 *SIZE, SCREEN_Width - 40 *SIZE, 18 *SIZE)];
    _companyL.textColor = [UIColor redColor];
    [self.view addSubview:_companyL];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.frame = CGRectMake(130 *SIZE, NAVIGATION_BAR_HEIGHT + 140 *SIZE, 100 *SIZE, 40 *SIZE);
    [_commentBtn setTitle:@"评价经纪人" forState:UIControlStateNormal];
    [_commentBtn setBackgroundColor:CLBlueBtnColor];
    _commentBtn.titleLabel.font = FONT(13 *SIZE);
    _commentBtn.layer.cornerRadius = 5 *SIZE;
    _commentBtn.clipsToBounds = YES;
    [_commentBtn addTarget:self action:@selector(ActionCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentBtn];
}

@end
