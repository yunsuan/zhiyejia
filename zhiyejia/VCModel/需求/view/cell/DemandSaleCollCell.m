//
//  DemandSaleCollCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "DemandSaleCollCell.h"

@implementation DemandSaleCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _titleL.text = dataDic[@"project_name"];
    _statusL.text = dataDic[@"current_state_name"];
    _houseNumL.text = [NSString stringWithFormat:@"房间号码：%@",dataDic[@"house_info"]];
    _priceL.text = [NSString stringWithFormat:@"%@-%@万",dataDic[@"price_min"],dataDic[@"price_max"]];

    _timeL.text = dataDic[@"create_time"];
}

- (void)ActionTap{
    
    if (self.demandSaleCollCellBlock) {
        
        self.demandSaleCollCellBlock();
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    [self.contentView addSubview:_whiteView];
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.contentMode = UIViewContentModeScaleAspectFill;
    _roomImg.clipsToBounds = YES;
    _roomImg.image = IMAGE_WITH_NAME(@"default_2");
    [_whiteView addSubview:_roomImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLNewTitleColor;
    _titleL.font = FONT(15 *SIZE);
    [_whiteView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLNewTitleColor;
    _statusL.font = FONT(15 *SIZE);
    _statusL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_statusL];
    
    _houseNumL = [[UILabel alloc] init];
    _houseNumL.textColor = CLNewContentColor;
    _houseNumL.font = FONT(10 *SIZE);
    [_whiteView addSubview:_houseNumL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLNewRedColor;
    _priceL.font = FONT(14 *SIZE);
    [_whiteView addSubview:_priceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLNewContentColor;
    _timeL.font = FONT(8 *SIZE);
    _timeL.textAlignment = NSTextAlignmentRight;
    [_whiteView addSubview:_timeL];

    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(338 *SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0 *SIZE);
    }];
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(12 *SIZE);
        make.top.equalTo(_whiteView).offset(23 *SIZE);
        make.width.mas_equalTo(103 *SIZE);
        make.height.mas_equalTo(86 *SIZE);
        make.bottom.equalTo(_whiteView).offset(-26 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(134 *SIZE);
        make.top.equalTo(self->_whiteView).offset(26 *SIZE);
        make.width.mas_lessThanOrEqualTo(135 *SIZE);
    }];
    
    [_houseNumL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(134 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(17 *SIZE);
        make.width.mas_lessThanOrEqualTo(120 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(134 *SIZE);
        make.top.equalTo(self->_houseNumL.mas_bottom).offset(8 *SIZE);
        make.width.mas_lessThanOrEqualTo(120 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_whiteView).offset(-26 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(17 *SIZE);
        make.width.mas_lessThanOrEqualTo(55 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_whiteView.mas_right).offset(-28 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(16 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
//        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(-15 *SIZE);
    }];
}

@end
