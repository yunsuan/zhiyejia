//
//  SecHouseSaleDemandDetailHouseCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandDetailHouseCell.h"

@implementation SecHouseSaleDemandDetailHouseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _titleL.text = [NSString stringWithFormat:@"小区名称：%@",dataDic[@"project_name"]];
//    _statusL.text = @"待勘察";
    _houseNumL.text = [NSString stringWithFormat:@"房间号码：%@",dataDic[@"house_info"]];
    _priceL.text = [NSString stringWithFormat:@"挂牌价：%@-%@万",dataDic[@"price_min"],dataDic[@"price_max"]];
    _timeL.text = [NSString stringWithFormat:@"发布时间：%@",dataDic[@"create_time"]];
//    _referencePriceL.text = @"参考价：80万";
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_titleL];
    
//    _statusL = [[UILabel alloc] init];
//    _statusL.textColor = CLContentLabColor;
//    _statusL.font = FONT(13 *SIZE);
//    _statusL.textAlignment = NSTextAlignmentRight;
//    [_whiteView addSubview:_statusL];
    
    _houseNumL = [[UILabel alloc] init];
    _houseNumL.textColor = CLContentLabColor;
    _houseNumL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_houseNumL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_priceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_timeL];
    
//    _referencePriceL = [[UILabel alloc] init];
//    _referencePriceL.textColor = CLContentLabColor;
//    _referencePriceL.font = FONT(13 *SIZE);
//    [self.contentView addSubview:_referencePriceL];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
//    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView).offset(-15 *SIZE);
//        make.top.equalTo(self.contentView).offset(17 *SIZE);
//        make.width.mas_lessThanOrEqualTo(50 *SIZE);
//    }];
    
    [_houseNumL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_houseNumL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];

//    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView).offset(-15 *SIZE);
//        make.top.equalTo(self->_houseNumL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_lessThanOrEqualTo(250 *SIZE);
//    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15 *SIZE);
    }];
    
    
}

@end
