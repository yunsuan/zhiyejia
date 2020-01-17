//
//  SecHouseCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecHouseCell.h"

@interface SecHouseCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}
@end

@implementation SecHouseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initDataSource];
        [self initUI];
    }
    return self;
}

- (void)initDataSource{
    
    _propertyArr = [@[] mutableCopy];
    _tagArr = [@[] mutableCopy];
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

    _titleL.text = [NSString stringWithFormat:@"%@",model.title];
    _roomLevelL.text = [NSString stringWithFormat:@"%@",model.level];
    _contentL.text = [NSString stringWithFormat:@"%@",model.describe];
    
    if (model.price.length) {
        
        _priceL.text = [NSString stringWithFormat:@"%@万",model.price];
    }else{
        
        _priceL.text = @"暂无售价信息";
    }
    
    if ([model.unit_price floatValue]) {
        
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
    
    _tagArr = [NSMutableArray arrayWithArray:model.project_tags];
    _propertyArr = [NSMutableArray arrayWithArray:model.house_tags];
    
    [_propertyColl reloadData];
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(self->_priceL.mj_textWidth + 5 *SIZE));
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (_propertyArr.count && _tagArr.count) {
        
        return 2;
    }else if (!_propertyArr.count && !_tagArr.count){
        
        return 0;
    }else{
        
        return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(260 *SIZE, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return _tagArr.count;
    }else{
        
        if (_propertyArr.count) {
            
            return _propertyArr.count;
        }else{
            
            return _tagArr.count;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 70 *SIZE, 20 *SIZE)];
    }
    
    if (indexPath.section == 1) {
        
        [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        
    }else{
        
        if (_propertyArr.count) {
            
            [cell setStyleByType:@"0" lab:_propertyArr[indexPath.item]];
        }else{
            
            [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        }
    }
    
    return cell;
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
    
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(70 *SIZE, 20 *SIZE);
        
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 33 *SIZE + CGRectGetMaxY(_headImg.frame), 260 *SIZE, 20 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = CLWhiteColor;
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
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
    
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_headImg.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}
@end
