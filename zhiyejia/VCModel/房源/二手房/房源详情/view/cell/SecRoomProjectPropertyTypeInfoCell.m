//
//  SecRoomProjectPropertyTypeInfoCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomProjectPropertyTypeInfoCell.h"

@implementation SecRoomProjectPropertyTypeInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _titleL.text = @"物业类型信息";
    _houseL.text = @"住宅";
    _houseDetailL.text = [NSString stringWithFormat:@"在售：%@套",dataDic[@"house_num"]];
    _storeL.text = @"商铺";
    _storeDetailL.text = [NSString stringWithFormat:@"在售：%@套",dataDic[@"shop_num"]];
    _buildL.text = @"写字楼";
    _buildDetailL.text = [NSString stringWithFormat:@"在售：%@套",dataDic[@"office_num"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    [_whiteView addSubview:_titleL];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *img = [[UIImageView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.textColor = CLTitleLabColor;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            
            _houseImg = img;
            [_whiteView addSubview:_houseImg];
            
            _houseL = label;
            [_whiteView addSubview:_houseL];
            
            _houseDetailL = label1;
            [_whiteView addSubview:_houseDetailL];
        }else if ( i == 1){
            
            _storeImg = img;
            [_whiteView addSubview:_storeImg];
            
            _storeL = label;
            [_whiteView addSubview:_storeL];
            
            _storeDetailL = label1;
            [_whiteView addSubview:_storeDetailL];
        }else{
            
            _buildImg = img;
            [_whiteView addSubview:_buildImg];
            
            _buildL = label;
            [_whiteView addSubview:_buildL];
            
            _buildDetailL = label1;
            [_whiteView addSubview:_buildDetailL];
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(2 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(133 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-2 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(7 *SIZE);
        make.top.equalTo(self->_whiteView).offset(8 *SIZE);
        make.right.equalTo(self->_whiteView).offset(-7 *SIZE);
    }];
    
    [_houseImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(45 *SIZE);
        make.top.equalTo(self->_whiteView).offset(44 *SIZE);
        make.width.mas_equalTo(23 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_houseL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_whiteView).offset(79 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
    }];
    
    [_houseDetailL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_whiteView).offset(100 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
    }];
    
    [_storeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(158 *SIZE);
        make.top.equalTo(self->_whiteView).offset(44 *SIZE);
        make.width.mas_equalTo(23 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(113 *SIZE);
        make.top.equalTo(self->_whiteView).offset(79 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
    }];
    
    [_storeDetailL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(113 *SIZE);
        make.top.equalTo(self->_whiteView).offset(100 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
    }];
    
    [_buildImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(272 *SIZE);
        make.top.equalTo(self->_whiteView).offset(44 *SIZE);
        make.width.mas_equalTo(23 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_buildL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(227 *SIZE);
        make.top.equalTo(self->_whiteView).offset(79 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
    }];
    
    [_buildDetailL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(227 *SIZE);
        make.top.equalTo(self->_whiteView).offset(100 *SIZE);
        make.width.mas_equalTo(113 *SIZE);
    }];
}

@end
