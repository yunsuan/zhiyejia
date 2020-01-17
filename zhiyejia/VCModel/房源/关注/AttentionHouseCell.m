//
//  AttentionHouseCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/16.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "AttentionHouseCell.h"

@interface AttentionHouseCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation AttentionHouseCell

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

- (void)setModel:(AttentionHouseModel *)model{
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
    
    
    
    _titleL.text = model.title;
    _contentL.text = model.describe;
    
    if (model.price.length) {
        
        _priceL.text = [NSString stringWithFormat:@"%@万",model.price];
    }else{
        
        _priceL.text = @"暂无售价信息";
    }
    
    if ([model.unit_price integerValue]) {
        
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
    
    [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(_priceL.mj_textWidth + 5 *SIZE));
    }];
    
    _propertyArr = [NSMutableArray arrayWithArray:model.project_tags];
    _tagArr = [NSMutableArray arrayWithArray:model.house_tags];
    [_propertyColl reloadData];
    
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    _reasonL.text = model.comment;
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
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return _tagArr.count > 4 ? 4:_tagArr.count;
    }else{
        
        if (_propertyArr.count) {
            
            return _propertyArr.count > 4 ? 4:_propertyArr.count;
        }else{
            
            return _tagArr.count > 4 ? 4:_tagArr.count;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 65 *SIZE, 17 *SIZE)];
    }
    
    if (indexPath.section == 1) {
        
        [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        
    }else{
        
        if (_propertyArr.count) {
            
            [cell setStyleByType:@"1" lab:_propertyArr[indexPath.item]];
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
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = CLContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = COLOR(255, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _statusImg = [[UIImageView alloc] init];
    //    _statusImg.image = [UIImage imageNamed:@"rising"];
    [self.contentView addSubview:_statusImg];
    
    _averageL = [[UILabel alloc] init];
    _averageL.textColor = CLContentLabColor;
    _averageL.font = [UIFont systemFontOfSize:11 *SIZE];
    _averageL.numberOfLines = 0;
    [self.contentView addSubview:_averageL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _typeL.numberOfLines = 0;
    [self.contentView addSubview:_typeL];
    
    _storeL = [[UILabel alloc] init];
    _storeL.textColor = CLContentLabColor;
    _storeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _storeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_storeL];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 90 *SIZE, 340 *SIZE, 40 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    _reasonL = [[UILabel alloc] init];
    _reasonL.textColor = CLContentLabColor;
    _reasonL.numberOfLines = 0;
    _reasonL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_reasonL];
    
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
        make.top.equalTo(_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.width.equalTo(@(_priceL.mj_textWidth + 5 *SIZE));
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_priceL.mas_right).offset(10 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(10 *SIZE);
        make.width.height.mas_equalTo(10 *SIZE);
    }];
    
    [_averageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_statusImg.mas_right).offset(44 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-140 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(220 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_headImg.mas_bottom).offset(5 *SIZE);
        make.width.equalTo(@(340 *SIZE));
        //        make.height.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    [_reasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_propertyColl.mas_bottom).offset(9 *SIZE);
        make.width.equalTo(@(340 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_reasonL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}

@end
