//
//  SecHouseBuyDemandDetailHouseCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailHouseCell.h"

#import "TagCollCell.h"

@interface SecHouseBuyDemandDetailHouseCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation SecHouseBuyDemandDetailHouseCell

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
    _houseTypeL.text = @"两室一厅";
    _areaL.text = @"24㎡";
    _decorateL.text = @"精装";
    _typeL.text = @"别墅";
    _refencePriceL.text = @"参考价：150万";
    _numL.text = @"看房人数：1231231";
    _addressL.text = @"详细地址：1231231";
    _intentL.text = @"关注量：1231231";
    _mySeeL.text = @"我的看房次数：1231231";
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
    [self.contentView addSubview:_statusL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = FONT(15 *SIZE);
    [self.contentView addSubview:_titleL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = CLTitleLabColor;
    _priceL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_priceL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = CLTitleLabColor;
    _areaL.font = FONT(13 *SIZE);
    _areaL.numberOfLines = 0;
    [self.contentView addSubview:_areaL];
    
    _refencePriceL = [[UILabel alloc] init];
    _refencePriceL.textColor = CLTitleLabColor;
    _refencePriceL.font = FONT(13 *SIZE);
    _refencePriceL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_refencePriceL];
    
    _houseTypeL = [[UILabel alloc] init];
    _houseTypeL.textColor = CLTitleLabColor;
    _houseTypeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_houseTypeL];
    
    _decorateL = [[UILabel alloc] init];
    _decorateL.textColor = CLTitleLabColor;
    _decorateL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_decorateL];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = CLTitleLabColor;
    _typeL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_typeL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = CLTitleLabColor;
    _numL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_numL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = CLTitleLabColor;
    _addressL.font = FONT(13 *SIZE);
    [self.contentView addSubview:_addressL];
    
    _intentL = [[UILabel alloc] init];
    _intentL.textColor = CLTitleLabColor;
    _intentL.font = FONT(13 *SIZE);
    _intentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_intentL];
    
    _mySeeL = [[UILabel alloc] init];
    _mySeeL.textColor = CLTitleLabColor;
    _mySeeL.font = FONT(13 *SIZE);
    _mySeeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_mySeeL];
    
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
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_offset(100 *SIZE);
        make.height.mas_offset(80 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(50 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_statusL.mas_right).offset(10 *SIZE);
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
    
    [_refencePriceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
        make.top.equalTo(self->_statusL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(90 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(190 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(80 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_houseTypeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
        
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(170 *SIZE);
    }];
        
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
               
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_numL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(170 *SIZE);
    }];
        
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(170 *SIZE);
    }];
        
    [_mySeeL mas_makeConstraints:^(MASConstraintMaker *make) {
               
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_numL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(170 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_addressL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0 *SIZE);
    }];
    
}

@end
