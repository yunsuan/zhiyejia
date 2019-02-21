//
//  NewRoomCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomCell.h"

@implementation NewRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(NewRoomModel *)model{
    
   [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.img_url]] placeholderImage:IMAGE_WITH_NAME(@"default_2") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_roomImg.image = IMAGE_WITH_NAME(@"default_2");
        }
    }];
    
    _titleL.text = model.project_name;
//    NSAttributedString *attr = [NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.pri]
//    _priceL.attributedText =
    _priceL.text = @"均价：";
    _addressL.text = [NSString stringWithFormat:@"%@-%@-%@",model.province_name,model.city_name,model.district_name];
//    _statusL.text = model.sale_state;
}

- (void)initUI{
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.contentMode = UIViewContentModeScaleAspectFill;
    _roomImg.clipsToBounds = YES;
    [self.contentView addSubview:_roomImg];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLContentLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        switch (i) {
            case 0:
            {
                _titleL = label;
                _titleL.font = FONT(13);
                _titleL.textColor = CLTitleLabColor;
                [self.contentView addSubview:_titleL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _addressL = label;
                [self.contentView addSubview:_addressL];
                break;
            }
            case 3:
            {
                _statusL = label;
                _statusL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_statusL];
                break;
            }
            default:
                break;
        }
    }
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(13 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(124 *SIZE);
        make.top.equalTo(self.contentView).offset(12 *SIZE);
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(124 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(310 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(124 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_roomImg.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
