//
//  SecHouseBuyDemandDetailHouseCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailRecommendCell.h"

@implementation SecHouseBuyDemandDetailRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    NSInteger recommend = 0;
    NSInteger intent = 0;
    NSInteger see = 0;
    _recommendL.text = [NSString stringWithFormat:@"%ld",dataArr.count];
    for (int i = 0; i < dataArr.count; i++) {
        
        if ([dataArr[i][@"client_request"] integerValue] == 1) {
            
            intent += 1;
        }
    }
    _intentL.text = [NSString stringWithFormat:@"%ld",intent];
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_agentImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"house"][@"agent_img"]]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_agentImg.image = IMAGE_WITH_NAME(@"def_head");
        }
    }];
//    _recommendL.text = @"4";
//    _intentL.text = @"2";
    _agentL.text = dataDic[@"house"][@"agent_name"];
//    _seeL.text = @"2";
    _companyL.text = dataDic[@"house"][@"store_name"];
    _timeL.text = [NSString stringWithFormat:@"推荐时间：%@",dataDic[@"house"][@"accept_time"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"推荐房屋",@"我感兴趣",@"我看过的"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60 + 100 *SIZE * i, 15 *SIZE, 100 *SIZE, 13 *SIZE)];
        label.textColor = CLBlueBtnColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(60 + 100 *SIZE * i, 35 *SIZE, 100 *SIZE, 11 *SIZE)];
        label1.textColor = CLContentLabColor;
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.adjustsFontSizeToFitWidth = YES;
        label1.text = titleArr[i];
        [self.contentView addSubview:label1];
        switch (i) {
            case 0:
            {
                _recommendL = label;
                [self.contentView addSubview:_recommendL];
                break;
            }
            case 1:
            {
                
                _intentL = label;
                [self.contentView addSubview:_intentL];
                
                break;
            }
            case 2:
            {
                _seeL = label;
                [self.contentView addSubview:_seeL];
                
                break;
            }
            default:
                break;
        }
    }
    
    _agentL = [[UILabel alloc] init];
    _agentL.textColor = CLContentLabColor;
    _agentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _agentL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_agentL];
    
    _companyL = [[UILabel alloc] init];
    _companyL.textColor = CLContentLabColor;
    _companyL.font = [UIFont systemFontOfSize:12 *SIZE];
    _companyL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_companyL];
    
    _timeL = [[UILabel alloc] init];//WithFrame:CGRectMake(60 + 100 *SIZE * i, 35 *SIZE, 100 *SIZE, 11 *SIZE)];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _timeL.textAlignment = NSTextAlignmentRight;
//    _timeL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_timeL];
    
    _agentImg = [[UIImageView alloc] init];
    _agentImg.layer.cornerRadius = 25 *SIZE;
    _agentImg.clipsToBounds = YES;
    [self.contentView addSubview:_agentImg];
    
    [_agentImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.height.mas_equalTo(50 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_agentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_agentImg.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width / 2);
    }];

    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_agentL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width / 2);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_agentL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width / 2);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
