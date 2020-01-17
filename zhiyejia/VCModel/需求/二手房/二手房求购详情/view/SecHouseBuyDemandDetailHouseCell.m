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
{
    
    NSMutableArray *_projectArr;
}
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
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:IMAGE_WITH_NAME(@"default_2") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            self->_headImg.image = IMAGE_WITH_NAME(@"default_2");
        }
    }];
    _statusL.text = dataDic[@"house_state"];
//    if ([_statusL.text isEqualToString:@"在售"]) {
//
//        _statusL.textColor = [UIColor greenColor];
//    }else{
//
//        _statusL.textColor = [UIColor redColor];
//    }
    _titleL.text = dataDic[@"title"];
    _priceL.text = [NSString stringWithFormat:@"%@万",dataDic[@"price"]];;
    if ([dataDic[@"price_change"] integerValue] == 0) {
        
        _priceImg.image = IMAGE_WITH_NAME(@"");
    }else if ([dataDic[@"price_change"] integerValue] == 1){
        
        _priceImg.image = IMAGE_WITH_NAME(@"rising");
    }else{
        
        _priceImg.image = IMAGE_WITH_NAME(@"falling");
    }
    _houseTypeL.text = dataDic[@"describe"];
//    _areaL.text = @"24㎡";
//    _decorateL.text = @"精装";
    _typeL.text = dataDic[@"property_type"];
//    _refencePriceL.text = @"参考价：150万";
    _numL.text = [NSString stringWithFormat:@"看房人数：%@",dataDic[@"take_num"]];
    _addressL.text = [NSString stringWithFormat:@"详细地址：%@",dataDic[@"absolute_address"]];
    _intentL.text = [NSString stringWithFormat:@"关注量：%@",dataDic[@"intent"]];
    _mySeeL.text = [NSString stringWithFormat:@"我的看房次数：%@",dataDic[@"take_visit_num"]];
    
    _projectArr = [[NSMutableArray alloc] initWithArray:dataDic[@"house_tags"]];
    [_coll reloadData];
    
    [_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_houseTypeL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _projectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.font = FONT(12 *SIZE);
    cell.contentL.text = _projectArr[indexPath.item];
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
    _statusL.textColor = [UIColor whiteColor];
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentCenter;
    _statusL.backgroundColor = [UIColor blackColor];
    _statusL.alpha = 0.5;
    [_headImg addSubview:_statusL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = FONT(15 *SIZE);
    [self.contentView addSubview:_titleL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = [UIColor redColor];
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
       
        make.left.equalTo(_headImg).offset(0 *SIZE);
        make.top.equalTo(_headImg).offset(62 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
    }];
    
    [_priceImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_priceL.mas_right).offset(10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_offset(15 *SIZE);
        make.height.mas_offset(15 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(190 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_refencePriceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(90 *SIZE);
    }];
    
    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(120 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
//        make.width.mas_lessThanOrEqualTo(100 *SIZE);
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(230 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(60 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-20 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(50 *SIZE);
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
        make.width.mas_lessThanOrEqualTo(200 *SIZE);
    }];
        
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
           
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(170 *SIZE);
    }];
        
    [_mySeeL mas_makeConstraints:^(MASConstraintMaker *make) {
               
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_numL.mas_bottom).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(150 *SIZE);
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
