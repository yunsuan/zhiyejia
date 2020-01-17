//
//  SecHouseBuyDemandDetailRecommendDetailCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailRecommendDetailCell.h"

#import "TagCollCell.h"

@interface SecHouseBuyDemandDetailRecommendDetailCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_projectArr;
    NSMutableArray *_houseArr;;
}
@end

@implementation SecHouseBuyDemandDetailRecommendDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:IMAGE_WITH_NAME(@"default_2") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
        if (error) {
                
            self->_headImg.image = IMAGE_WITH_NAME(@"default_2");
        }
    }];
    if ([dataDic[@"client_request"] integerValue] == 0) {
        
        _statusL.text = @"";
    }else if ([dataDic[@"client_request"] integerValue] == 1){
        
        _statusL.text = @"感兴趣";
    }else{
        
        _statusL.text = @"不感兴趣";
    }
    
//    if ([_statusL.text isEqualToString:@"在售"]) {
//
//        _statusL.textColor = [UIColor greenColor];
//    }else{
//
//        _statusL.textColor = [UIColor redColor];
//    }
    _titleL.text = dataDic[@"title"];
    _priceL.text = dataDic[@"describe"];
    if ([dataDic[@"price_change"] integerValue] == 0) {
        
        _priceImg.image = IMAGE_WITH_NAME(@"");
    }else if ([dataDic[@"price_change"] integerValue] == 1){
        
        _priceImg.image = IMAGE_WITH_NAME(@"rising");
    }else{
        
        _priceImg.image = IMAGE_WITH_NAME(@"falling");
    }

    _typeL.text = dataDic[@"property_type"];
    
    _projectArr = [[NSMutableArray alloc] initWithArray:dataDic[@"project_tags"]];
    _houseArr = [[NSMutableArray alloc] initWithArray:dataDic[@"house_tags"]];
    
    [_coll reloadData];
    
    [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (_projectArr.count && _houseArr.count) {
        
        return 2;
    }else if (!_projectArr.count && !_houseArr.count){
        
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
        
        return _houseArr.count;
    }else{
        
        if (_projectArr.count) {
            
            return _projectArr.count;
        }else{
            
            return _houseArr.count;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 70 *SIZE, 20 *SIZE)];
    }
    
    if (indexPath.section == 1) {
        
        [cell setStyleByType:@"1" lab:_houseArr[indexPath.item]];
        
    }else{
        
        if (_projectArr.count) {
            
            [cell setStyleByType:@"0" lab:_projectArr[indexPath.item]];
        }else{
            
            [cell setStyleByType:@"1" lab:_houseArr[indexPath.item]];
        }
    }
    
    return cell;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _headImg = [[UIImageView alloc] init];
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImg];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = [UIColor redColor];
    _statusL.font = FONT(15 *SIZE);
    [_headImg addSubview:_statusL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = FONT(15 *SIZE);
    [self.contentView addSubview:_titleL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLTitleLabColor;
    _typeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_typeL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLTitleLabColor;
    _priceL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_priceL];
    
    _priceImg = [[UIImageView alloc] init];
    _priceImg.clipsToBounds = YES;
    [self.contentView addSubview:_priceImg];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLTitleLabColor;
    _areaL.font = FONT(13 *SIZE);
    _areaL.numberOfLines = 0;
    [self.contentView addSubview:_areaL];
    
    _unitL = [[UILabel alloc] init];
    _unitL.textColor = CLTitleLabColor;
    _unitL.font = FONT(13 *SIZE);
    _unitL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_unitL];
    
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:9 *SIZE];
    _flowLayout.itemSize = CGSizeMake(60 *SIZE, 27 *SIZE);
    _flowLayout.sectionInset = UIEdgeInsetsMake(4 *SIZE, 10 *SIZE, 4 *SIZE, 10 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_coll];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = CLTitleLabColor;
    _timeL.font = FONT(13 *SIZE);
//    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    _recommendL = [[UILabel alloc] init];
    _recommendL.textColor = CLTitleLabColor;
    _recommendL.font = FONT(13 *SIZE);
    _recommendL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_recommendL];
    
    _seeNumL = [[UILabel alloc] init];
    _seeNumL.textColor = CLTitleLabColor;
    _seeNumL.font = FONT(13 *SIZE);
    _seeNumL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_seeNumL];
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.height.mas_offset(80 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_headImg).offset(15 *SIZE);
        make.top.equalTo(self->_headImg).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(50 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(140 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_statusL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
    }];
    
    [_priceImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_priceL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self->_statusL.mas_bottom).offset(10 *SIZE);
        make.width.mas_offset(15 *SIZE);
        make.height.mas_offset(15 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(190 *SIZE);
        make.top.equalTo(self->_statusL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
        make.top.equalTo(self->_statusL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(90 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(80 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
    }];
    
    [_seeNumL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self->_seeNumL.mas_left).offset(-10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0 *SIZE);
    }];
    
}

@end
