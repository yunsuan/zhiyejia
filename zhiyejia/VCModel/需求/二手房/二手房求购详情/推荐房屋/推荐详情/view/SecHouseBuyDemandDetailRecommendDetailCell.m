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
    
    _statusL.text = @"在售";
    _titleL.text = @"【天鹅湖小区】  临街门面  转角双开间";
    _priceL.text = @"150万";
    _areaL.text = @"24㎡";
    _typeL.text = @"别墅";
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
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
    
    self.contentView.backgroundColor = CLWhiteColor;;
    
    _headImg = [[UIImageView alloc] init];
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headImg];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = CLTitleLabColor;
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
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
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
