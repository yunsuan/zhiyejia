//
//  SecHouseBuyDetailCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDetailCell.h"

#import "TagCollCell.h"

@interface SecHouseBuyDetailCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    
}
@end

@implementation SecHouseBuyDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _regionL.text = @"成都市青羊区";
    _statusL.text = @"待接单";
    _typeL.text = @"物业类型：住宅";
    _priceL.text = @"意向总价：80-90万";
    _areaL.text = @"意向总价：40-100㎡";
    _houseTypeL.text = @"意向户型：两室一厅";
    _useL.text = @"购买用途：自住";
    _decorateL.text = @"装修标准：精装";
    _otherL.text = @"其他要求：无";
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.font = FONT(12 *SIZE);
    cell.contentL.text = @"住宅";
    cell.contentView.backgroundColor = CLLineColor;
    
    return cell;
}

- (void)initUI{
    
//    self.contentView.backgroundColor = CLLineColor;
    
    _regionL = [[UILabel alloc] init];
    _regionL.textColor = CLTitleLabColor;
    _regionL.font = FONT(15 *SIZE);
    [self.contentView addSubview:_regionL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLContentLabColor;
    _statusL.font = FONT(13 *SIZE);
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLContentLabColor;
    _typeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_typeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLContentLabColor;
    _priceL.font = FONT(13 *SIZE);
    _priceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLContentLabColor;
    _areaL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_areaL];
    
    _houseTypeL = [[UILabel alloc] init];
    _houseTypeL.textColor = CLContentLabColor;
    _houseTypeL.font = FONT(13 *SIZE);
    _houseTypeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_houseTypeL];
    
    _useL = [[UILabel alloc] init];
    _useL.textColor = CLContentLabColor;
    _useL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_useL];
    
    _decorateL = [[UILabel alloc] init];
    _decorateL.textColor = CLContentLabColor;
    _decorateL.font = FONT(13 *SIZE);
    _decorateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_decorateL];
    
    _tagL = [[UILabel alloc] init];
    _tagL.textColor = CLContentLabColor;
    _tagL.font = FONT(13 *SIZE);
//    _tagL.numberOfLines = 0;
    _tagL.adjustsFontSizeToFitWidth = YES;
    _tagL.text = @"自定义标签：";
    [self.contentView addSubview:_tagL];
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:9 *SIZE];
    _flowLayout.itemSize = CGSizeMake(60 *SIZE, 27 *SIZE);
    _flowLayout.sectionInset = UIEdgeInsetsMake(4 *SIZE, 10 *SIZE, 4 *SIZE, 10 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_coll];
    
    _otherL = [[UILabel alloc] init];
    _otherL.textColor = CLContentLabColor;
    _otherL.font = FONT(13 *SIZE);
    _otherL.numberOfLines = 0;
    [self.contentView addSubview:_otherL];
    
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self.contentView).offset(17 *SIZE);
        make.width.mas_lessThanOrEqualTo(50 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self->_regionL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self->_typeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_useL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_tagL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_useL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(65 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self->_useL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(270 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_otherL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(15 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(250 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-15 *SIZE);
    }];
}

@end
