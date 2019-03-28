//
//  SecRoomOfficeInfoCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomOfficeInfoCell.h"

@interface SecRoomOfficeInfoCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}
@end

@implementation SecRoomOfficeInfoCell

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
        
        [cell setStyleByType:@"0" lab:_propertyArr[indexPath.item]];
    }
    
    return cell;
}

- (void)initUI{

    _markView = [[UIView alloc] init];
    _markView.backgroundColor = COLOR(244, 244, 244, 1);
    [self.contentView addSubview:_markView];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 1:
            {
                _timeL = label;
                [self.contentView addSubview:_timeL];
                break;
            }
            case 2:
            {
                _yearL = label;
                [self.contentView addSubview:_yearL];
                break;
            }
            case 3:
            {
                _floorL = label;
                [self.contentView addSubview:_floorL];
                break;
            }
            case 4:
            {
                _rentTimeL = label;
                [self.contentView addSubview:_rentTimeL];
                break;
            }
            case 5:
            {
                _rentPriceL = label;
                [self.contentView addSubview:_rentPriceL];
                break;
            }
            case 6:
            {
                _referRentPriceL = label;
                [self.contentView addSubview:_referRentPriceL];
                break;
            }
            case 7:
            {
                _markL = label;
                [_markView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(4 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];

    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));

    }];
    
    [_rentTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_yearL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_rentPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_floorL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        
    }];
    
    [_referRentPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_rentTimeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_referRentPriceL.mas_bottom).offset(16 *SIZE);
        make.width.equalTo(@(340 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_markView).offset(4 *SIZE);
        make.top.equalTo(self->_markView).offset(15 *SIZE);
        make.width.equalTo(@(330 *SIZE));
        make.bottom.equalTo(self->_markView).offset(-15 *SIZE);
    }];
    
}
@end
