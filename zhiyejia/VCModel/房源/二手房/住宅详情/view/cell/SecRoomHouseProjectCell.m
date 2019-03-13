//
//  SecRoomHouseProjectCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomHouseProjectCell.h"

@implementation SecRoomHouseProjectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setHouseModel:(SecRoomHouseDetailModel *)houseModel{
    
    if (houseModel.project_img_url.length > 0) {
        
        [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,houseModel.project_img_url]] placeholderImage:[UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                self->_roomImg.image = [UIImage imageNamed:@"default_1"];
            }
        }];
    }else{
        _roomImg.image = [UIImage imageNamed:@"default_1"];
    }
    
    
    if (![houseModel.project_average_price integerValue]) {
        
        _priceL.text = @"参考均价：暂无数据";
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"参考均价：%@元/m²",houseModel.project_average_price];
    }
    
    if (![houseModel.project_total_build integerValue]) {
        
        _buildL.text = @"楼栋总数：暂无数据";
    }else{
        
        _buildL.text = [NSString stringWithFormat:@"楼栋总数：%@栋",houseModel.project_total_build];
    }
    
    _roomL.text = @"房屋总数：暂无数据";
}

- (void)initUI{
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLTitleLabColor;
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _priceL.numberOfLines = 0;
    [self.contentView addSubview:_priceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLTitleLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.numberOfLines = 0;
    [self.contentView addSubview:_timeL];
    
    _buildL = [[UILabel alloc] init];
    _buildL.textColor = CLTitleLabColor;
    _buildL.font = [UIFont systemFontOfSize:13 *SIZE];
    _buildL.numberOfLines = 0;
    [self.contentView addSubview:_buildL];
    
    _roomL = [[UILabel alloc] init];
    _roomL.textColor = CLTitleLabColor;
    _roomL.font = [UIFont systemFontOfSize:13 *SIZE];
    _roomL.numberOfLines = 0;
    [self.contentView addSubview:_roomL];
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_roomImg];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_buildL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_buildL.mas_bottom).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
        
    }];
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-11 *SIZE);
    }];
    
   
}

@end
