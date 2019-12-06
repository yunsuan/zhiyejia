//
//  SecHouseCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecHouseCell.h"

@implementation SecHouseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(SecHouseModel *)model{
    
    if (model.img_url.length>0) {
        
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.img_url]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _headImg.image = [UIImage imageNamed:@"default_3"];
            }
        }];
    }
    else{
        _headImg.image = [UIImage imageNamed:@"default_3"];
    }
    
    if ([model.hide integerValue] == 0) {
        
        _hideView.hidden = YES;
    }else{
        
        _hideView.hidden = NO;
    }
    
    
    //    _titleL.text = [NSString stringWithFormat:@"%@(%@)",model.title,[model.hide integerValue] == 0?@"公开":@"非公开"];
    _titleL.text = model.title;
    _roomLevelL.text = model.level;
    _contentL.text = model.describe;
    
    if (model.price.length) {
        
        _priceL.text = [NSString stringWithFormat:@"%@万",model.price];
    }else{
        
        _priceL.text = @"暂无售价信息";
    }
    
    if (model.unit_price.length) {
        
        _averageL.text = [NSString stringWithFormat:@"%@元/㎡",model.unit_price];
    }else{
        
        _averageL.text = @"暂无均价信息";
    }
    
    _typeL.text = [NSString stringWithFormat:@"物业类型：%@",model.property_type];
    _storeL.text = [NSString stringWithFormat:@"所属门店：%@",model.store_name];
    if ([model.price_change integerValue] == 0) {
        
        _statusImg.image = [UIImage imageNamed:@""];
    }else if ([model.price_change integerValue] == 1){
        
        _statusImg.image = [UIImage imageNamed:@"rising"];
    }else{
        
        _statusImg.image = [UIImage imageNamed:@"falling"];
    }
    
//    [_tagView setData:model.project_tags];
//    [_tagView2 setData:model.house_tags];
    [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(self->_priceL.mj_textWidth + 5 *SIZE));
    }];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(12 *SIZE, 16 *SIZE, 100 *SIZE, 88 *SIZE)];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _hideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 88 *SIZE)];
    _hideView.backgroundColor = [UIColor blackColor];;
    _hideView.alpha = 0.4;
    _hideView.hidden = YES;
    [_headImg addSubview:_hideView];
    
    _hideL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 88 *SIZE)];
    //    _hideL.backgroundColor = YJBackColor;
    _hideL.textColor = [UIColor whiteColor];
    _hideL.font = [UIFont systemFontOfSize:11 *SIZE];
    _hideL.textAlignment = NSTextAlignmentCenter;
    _hideL.text = @"非公开";
    [_hideView addSubview:_hideL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _roomLevelL = [[UILabel alloc] init];
    _roomLevelL.textColor = CLContentLabColor;
    _roomLevelL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_roomLevelL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_contentL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = COLOR(255, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _statusImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_statusImg];
    
    _averageL = [[UILabel alloc] init];
    _averageL.textColor = CLContentLabColor;
    _averageL.font = [UIFont systemFontOfSize:11 *SIZE];
    //    _averageL.numberOfLines = 0;
    [self.contentView addSubview:_averageL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    //    _typeL.numberOfLines = 0;
    [self.contentView addSubview:_typeL];
    
    _storeL = [[UILabel alloc] init];
    _storeL.textColor = CLContentLabColor;
    _storeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _storeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_storeL];
    
//    _tagView = [[TagView alloc]initWithFrame:CGRectMake(10 *SIZE, 90 *SIZE, 340*SIZE, 17*SIZE)  type:@"1"];
//    _tagView.collectionview.userInteractionEnabled = NO;
//    _tagView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    [self.contentView addSubview:_tagView];
//
//    _tagView2 = [[TagView alloc]initWithFrame:CGRectMake(10 *SIZE, 109 *SIZE, 340*SIZE, 17*SIZE)  type:@"1"];
//    _tagView2.collectionview.userInteractionEnabled = NO;
//    _tagView2.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    [self.contentView addSubview:_tagView2];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-45 *SIZE);
    }];
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(320 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(self->_priceL.mj_textWidth + 5 *SIZE));
        make.width.mas_lessThanOrEqualTo(120 *SIZE);
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_priceL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(10 *SIZE);
        make.width.height.mas_equalTo(10 *SIZE);
    }];
    
    [_averageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(265 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-140 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(220 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}
@end
