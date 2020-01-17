//
//  DeamandSaleCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "DeamandSaleCell.h"

@implementation DeamandSaleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _titleL.text = dataDic[@"project_name"];
    _statusL.text = dataDic[@"current_state_name"];
    _houseNumL.text = dataDic[@"house_info"];
    _priceL.text = [NSString stringWithFormat:@"挂牌价：%@-%@万",dataDic[@"price_min"],dataDic[@"price_max"]];
//    NSString *str = [NSString stringWithFormat:@"电话：%@",@""];
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
//    [attr addAttribute:NSForegroundColorAttributeName value:CLBlueBtnColor range:NSMakeRange(3, str.length - 3)];
//    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(3, str.length - 3)];
//    _phoneL.attributedText = attr;

    _timeL.text = dataDic[@"create_time"];
}

- (void)ActionTap{
    
    if (self.deamandSaleCellBlock) {
        
        self.deamandSaleCellBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 2 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = FONT(15 *SIZE);
    [_whiteView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLContentLabColor;
    _statusL.font = FONT(13 *SIZE);
    _statusL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_statusL];
    
    _houseNumL = [[UILabel alloc] init];
    _houseNumL.textColor = CLContentLabColor;
    _houseNumL.font = FONT(13 *SIZE);
    [_whiteView addSubview:_houseNumL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = FONT(13 *SIZE);
    [_whiteView addSubview:_priceL];
    
//    _line = [[UIView alloc] init];
//    _line.backgroundColor = CLLineColor;
//    [self.contentView addSubview:_line];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = FONT(13 *SIZE);
    [_whiteView addSubview:_timeL];
    
//    _phoneL = [[UILabel alloc] init];
//    _phoneL.textColor = CLContentLabColor;
//    _phoneL.font = FONT(13 *SIZE);
//    _phoneL.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
//    [_phoneL addGestureRecognizer:tap];
//    [_whiteView addSubview:_phoneL];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(7 *SIZE);
        make.width.mas_equalTo(330 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_whiteView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(230 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_whiteView).offset(-15 *SIZE);
        make.top.equalTo(self->_whiteView).offset(17 *SIZE);
        make.width.mas_lessThanOrEqualTo(70 *SIZE);
    }];
    
    [_houseNumL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_houseNumL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
//    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
//        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_equalTo(330 *SIZE);
//        make.height.mas_equalTo(1 *SIZE);
//    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_line.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-15 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(15 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
