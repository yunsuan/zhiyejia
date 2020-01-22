//
//  SecRoomProjectHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomProjectHeader.h"

#import "TagCollCell.h"

@interface SecRoomProjectHeader ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _num;
    NSInteger _nowNum;
    float _longitude;
    float _latitude;
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}
@end

@implementation SecRoomProjectHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
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

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    _num = imgArr.count;
    if (imgArr.count) {
        
        _numL.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)imgArr.count];
    }else{
        
        _numL.text = @"0/0";
    }
    [_imgScroll setContentSize:CGSizeMake(imgArr.count *SCREEN_Width, 202.5 *SIZE)];
    for (UIView *view in _imgScroll.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (imgArr.count) {
        
        for (int i = 0; i < imgArr.count; i++) {
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, 202.5 *SIZE)];
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.clipsToBounds = YES;
            NSString *imgname = imgArr[i][@"img_url"];
            
            if (imgname.length > 0) {
                
                [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,imgArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    if (error) {
                        
                        img.image = [UIImage imageNamed:@"banner_default_2"];
                    }
                }];
                
            }else{
                
                img.image = [UIImage imageNamed:@"banner_default_2"];
            }
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImgBtn)];
            [img addGestureRecognizer:tap];
            img.userInteractionEnabled = YES;
            [_imgScroll addSubview:img];
        }
    }else{
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        img.image = [UIImage imageNamed:@"banner_default_2"];
        [_imgScroll addSubview:img];
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    //    if (dataDic[@"developer_name"]) {
    //
    //        _developerL.text = [NSString stringWithFormat:@"开发商：%@",dataDic[@"developer_name"]];
    //    }
    
    if (dataDic[@"latitude"]) {
        _latitude = [dataDic[@"latitude"] floatValue];
    }
    
    if (dataDic[@"longitude"]) {
        _longitude = [dataDic[@"longitude"] floatValue];
    }
    
    if (dataDic[@"project_name"]) {
        
        _titleL.text = dataDic[@"project_name"];
    }
    
    if (dataDic[@"absolute_address"]) {
        
        _addressL.text = dataDic[@"absolute_address"];
    }
    
    if (dataDic[@"sale_state"]) {
        
        _statusL.text = [NSString stringWithFormat:@"%@",dataDic[@"sale_state"]];
    }
    
    
    _propertyArr = [NSMutableArray arrayWithArray:dataDic[@"property_type"]];
    _tagArr = [NSMutableArray arrayWithArray:dataDic[@"project_tags"]];
    
    if (dataDic[@"average_price"]) {
        
        if (![dataDic[@"average_price"] integerValue]) {
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 暂无数据"]];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, attr.length)];
            [attr addAttribute:NSForegroundColorAttributeName value:CLContentLabColor range:NSMakeRange(0, attr.length)];
            _priceL.attributedText = attr;
        }else{
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 ￥%@/㎡",dataDic[@"average_price"]]];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 *SIZE] range:NSMakeRange(3, 1)];
            [attr addAttribute:NSForegroundColorAttributeName value:CLContentLabColor range:NSMakeRange(0, 3)];
            _priceL.attributedText = attr;
        }
    }else{
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 "]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:CLContentLabColor range:NSMakeRange(0, 3)];
        _priceL.attributedText = attr;
    }
    
    [_titleL mas_updateConstraints:^(MASConstraintMaker *make) {
        
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(self->_imgScroll.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(self->_titleL.mj_textWidth + 5 *SIZE);
//        make.right.mas_lessThanOrEqualTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_propertyColl reloadData];
    SS(strongSelf);
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(strongSelf->_propertyColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
    }];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.secRoomProjectHeaderMoreBlock) {
        
        self.secRoomProjectHeaderMoreBlock();
    }
}

- (void)ActionTapMethod{
    
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(_latitude, _longitude);
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    toLocation.name = _addressL.text;
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

- (void)ActionImgBtn{
    
    if (self.secRoomProjectHeaderImgBtnBlock) {
        
        if (_imgArr.count) {
            
            self.secRoomProjectHeaderImgBtnBlock(_nowNum, _imgArr);
            
        }
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.secRoomProjectHeaderTagBlock) {
        
        self.secRoomProjectHeaderTagBlock(btn.tag);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//    return CGSizeMake(260 *SIZE, 9 *SIZE);
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 1) {
    
        return _tagArr.count;
    }
    return _propertyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 20 *SIZE)];
    }
    
    if (indexPath.section == 1) {
        
        [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        
    }else{
        
        [cell setStyleByType:@"0" lab:_propertyArr[indexPath.item]];
    }
    
    return cell;
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
    _imgScroll.pagingEnabled = YES;
    _imgScroll.delegate = self;
    _imgScroll.showsVerticalScrollIndicator = NO;
    _imgScroll.showsHorizontalScrollIndicator = NO;
//    _imgScroll.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imgScroll];
    
    _numL = [[UILabel alloc] init];
    _numL.backgroundColor = COLOR(255, 255, 255, 0.6);
    _numL.textColor = CLTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:10 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.layer.cornerRadius = 15 *SIZE;
    _numL.clipsToBounds = YES;
    _numL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_numL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = CLTitleLabColor;
    _titleL.numberOfLines = 0;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _titleL.text = @"DUNX自由青年公寓DUNX自由青年公寓DUNX自由青年公寓DUNX自由青年公寓DUNX自由青年公寓DUNX自由青年公寓DUNX自由青年公寓DUNX自由青年公寓DUNX自由青年公寓";
    [self.contentView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = COLOR(27, 152, 255, 1);
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
//    _statusL.text = @"在售";
    [self.contentView addSubview:_statusL];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:0 betweenOfCell:4 *SIZE];
    _propertyFlowLayout.estimatedItemSize = CGSizeMake(40 *SIZE, 20 *SIZE);
    if (@available(iOS 10.0, *)) {
        _propertyFlowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    } else {
        // Fallback on earlier versions
    }
//    _propertyFlowLayout.minimumInteritemSpacing = 4 *SIZE;
    
    //    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_propertyFlowLayout];
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 33 *SIZE + CGRectGetMaxY(_imgScroll.frame), 260 *SIZE, 20 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = CLWhiteColor;
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    _attentL = [[UILabel alloc] init];
    _attentL.textColor = CLContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _attentL.textAlignment = NSTextAlignmentRight;
//    _attentL.text = @"关注人数：23";
    [self.contentView addSubview:_attentL];
    
    _saleNumL = [[UILabel alloc] init];
    _saleNumL.textColor = CLContentLabColor;
    _saleNumL.font = [UIFont systemFontOfSize:12 *SIZE];
    _saleNumL.textAlignment = NSTextAlignmentRight;
//    _saleNumL.text = @"在租：23套";
    [self.contentView addSubview:_saleNumL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = COLOR(250, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:16 *SIZE];
//    _priceL.text = @"均价：￥16000元/㎡";
    [self.contentView addSubview:_priceL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = CLContentLabColor;
    _codeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _codeL.textAlignment = NSTextAlignmentRight;
//    _codeL.text = @"项目编号：XQBH-19987";
    [self.contentView addSubview:_codeL];
    
    _addressImg = [[UIImageView alloc] init];
    _addressImg.image = [UIImage imageNamed:@"map"];
    [self.contentView addSubview:_addressImg];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = CLContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _addressL.text = @"高新区-天府五街230号";
    [self.contentView addSubview:_addressL];
    _addressL.userInteractionEnabled = YES;
    [_addressL addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTapMethod)]];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 344 *SIZE, SCREEN_Width, 107 *SIZE)];
    _btnView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width , SIZE)];
    line.backgroundColor = CLLineColor;
    [_btnView addSubview:line];
    
    NSArray *titleArr = @[@"我要买房",@"我要卖房",@"二手房源",@"买房成交"];
    NSArray *imgArr = @[@"release",@"secondhand",@"clinch",@"summarize"];
    for (int i = 0; i < 4; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(22 *SIZE + i *89 *SIZE, 15 *SIZE, 47 *SIZE, 47 *SIZE)];
        img.image = [UIImage imageNamed:imgArr[i]];
        [_btnView addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 4 * i, 80 *SIZE, SCREEN_Width /4, 11 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titleArr[i];
        [_btnView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(17 *SIZE + i *89 *SIZE, 10 *SIZE, 57 *SIZE, 57 *SIZE);
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:btn];
    }
    [self.contentView addSubview:_btnView];

    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_imgScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(202.5 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.bottom.equalTo(self->_imgScroll.mas_bottom).offset(-9 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_imgScroll.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(self->_titleL.mj_textWidth + 5 *SIZE);
        make.right.mas_lessThanOrEqualTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_titleL.mas_right).offset(0 *SIZE);
        make.top.equalTo(self->_imgScroll.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(30 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_imgScroll.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_saleNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_attentL.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(260 *SIZE);
        make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-170 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(8 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(287 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(31 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-70 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-22 *SIZE);
    }];
    
    [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_addressL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(107 *SIZE));
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
