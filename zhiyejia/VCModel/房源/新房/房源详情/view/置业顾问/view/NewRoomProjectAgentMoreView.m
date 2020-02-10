//
//  NewRoomProjectAgentMoreView.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/8.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewRoomProjectAgentMoreView.h"

@implementation NewRoomProjectAgentMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_headImg.image = IMAGE_WITH_NAME(@"def_head");
        }
    }];
    _nameL.text = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
    _allL.text = [NSString stringWithFormat:@"%@",dataDic[@"browse_num"]];
    _praiseL.text = [NSString stringWithFormat:@"%@",dataDic[@"awesome_num"]];
    _activityL.text = [NSString stringWithFormat:@"%@",dataDic[@"active_num"]];
    
    _serverL.text = [NSString stringWithFormat:@"%@",dataDic[@"visit_num"]];
    
    _dealL.text = [NSString stringWithFormat:@"%@",dataDic[@"deal_num"]];
    
    if ([dataDic[@"total_num"] integerValue] <= 1500) {
        
        _typeL.text = @"铜牌置业顾问";
        _goldImg.image = IMAGE_WITH_NAME(@"铜牌工厂");
    }else if ([dataDic[@"total_num"] integerValue] <= 3000){
        
        _typeL.text = @"银牌置业顾问";
        _goldImg.image = IMAGE_WITH_NAME(@"银牌工厂");
    }else{
        
        _typeL.text = @"金牌置业顾问";
        _goldImg.image = IMAGE_WITH_NAME(@"金牌工厂");
    }
}

- (void)ActionPraiseBtn:(UIButton *)btn{
    
    if (self.newRoomProjectAgentMoreViewPraiseBlock) {
        
        self.newRoomProjectAgentMoreViewPraiseBlock();
    }
}

- (void)ActionPhoneBtn:(UIButton *)btn{
    
    if (self.newRoomProjectAgentMoreViewPhoneBlock) {
        
        self.newRoomProjectAgentMoreViewPhoneBlock();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.2;
    [self addSubview:alphaView];
    
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = CLWhiteColor;;
    self.whiteView.layer.cornerRadius = 10 *SIZE;
    self.whiteView.clipsToBounds = YES;
    [self addSubview:self.whiteView];
    
    _headImg = [[UIImageView alloc] init];
//    _headImg.textColor = CLTitleLabColor;
//    _headImg.font = FONT(13 *SIZE);
    [self.whiteView addSubview:_headImg];
    
    _goldImg = [[UIImageView alloc] init];
    //    _headImg.textColor = CLTitleLabColor;
    //    _headImg.font = FONT(13 *SIZE);
    [self.whiteView addSubview:_goldImg];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = FONT(13 *SIZE);
    [self.whiteView addSubview:_nameL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = FONT(13 *SIZE);
    [self.whiteView addSubview:_typeL];
    
//    _nameL = [[UILabel alloc] init];
//    _nameL.textColor = CLTitleLabColor;
//    _nameL.font = FONT(13 *SIZE);
//    [self.whiteView addSubview:_nameL];
    
    NSArray *arr = @[@"浏览量",@"点赞数",@"活跃度"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100 *SIZE, 100 *SIZE, 100 *SIZE, 15 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = FONT(13 *SIZE);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        [self.whiteView addSubview:label];
    }
    
    NSArray *arr1 = @[@"服务客户",@"成交客户"];
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100 *SIZE, 160 *SIZE, 100 *SIZE, 15 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = FONT(13 *SIZE);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr1[i];
        [self.whiteView addSubview:label];
    }
    
    _allL = [[UILabel alloc] init];
    _allL.textColor = CLTitleLabColor;
    _allL.font = FONT(13 *SIZE);
    _allL.textAlignment = NSTextAlignmentCenter;
    _allL.text = @"123";
    [self.whiteView addSubview:_allL];
    
    _praiseL = [[UILabel alloc] init];
    _praiseL.textColor = CLTitleLabColor;
    _praiseL.font = FONT(13 *SIZE);
    _praiseL.textAlignment = NSTextAlignmentCenter;
    _praiseL.text = @"123";
    [self.whiteView addSubview:_praiseL];
    
    _serverL = [[UILabel alloc] init];
    _serverL.textColor = CLTitleLabColor;
    _serverL.font = FONT(13 *SIZE);
    _serverL.textAlignment = NSTextAlignmentCenter;
    _serverL.text = @"123";
    [self.whiteView addSubview:_serverL];
    
    _dealL = [[UILabel alloc] init];
    _dealL.textColor = CLTitleLabColor;
    _dealL.font = FONT(13 *SIZE);
    _dealL.textAlignment = NSTextAlignmentCenter;
    _dealL.text = @"123";
    [self.whiteView addSubview:_dealL];
    
    
    _activityL = [[UILabel alloc] init];
    _activityL.textColor = CLTitleLabColor;
    _activityL.font = FONT(13 *SIZE);
    _activityL.textAlignment = NSTextAlignmentCenter;
    _activityL.text = @"123";
    [self.whiteView addSubview:_activityL];
    
    _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_phoneBtn setImage:IMAGE_WITH_NAME(@"phone1") forState:UIControlStateNormal];
    [_phoneBtn addTarget:self action:@selector(ActionPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:_phoneBtn];
    
    _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_praiseBtn setImage:IMAGE_WITH_NAME(@"praise") forState:UIControlStateNormal];
    [_praiseBtn addTarget:self action:@selector(ActionPraiseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:_praiseBtn];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(30 *SIZE);
        make.top.equalTo(self).offset(250 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(240 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.whiteView).offset(80 *SIZE);
        make.top.equalTo(self.whiteView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(120 *SIZE);
    }];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.whiteView).offset(15 *SIZE);
        make.top.equalTo(self.whiteView).offset(17 *SIZE);
        make.width.height.mas_equalTo(50 *SIZE);
    }];
    
    [_goldImg mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(self.whiteView).offset(-15 *SIZE);
        make.top.equalTo(self.whiteView).offset(15 *SIZE);
        make.width.height.mas_equalTo(50 *SIZE);
    }];


    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_nameL.mas_right).offset(5 *SIZE);
        make.top.equalTo(self.whiteView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(100 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_allL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.whiteView).offset(10 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_praiseL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_serverL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.whiteView).offset(10 *SIZE);
        make.top.equalTo(self->_allL.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_dealL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_allL.mas_bottom).offset(40 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_activityL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.whiteView).offset(210 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.whiteView).offset(-30 *SIZE);
        make.top.equalTo(self->_serverL.mas_bottom).offset(50 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.whiteView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.left.equalTo(self.whiteView).offset(30 *SIZE);
        make.top.equalTo(self->_serverL.mas_bottom).offset(50 *SIZE);
//        make.top.equalTo(self.contentView.mas_bottom).offset(10 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
