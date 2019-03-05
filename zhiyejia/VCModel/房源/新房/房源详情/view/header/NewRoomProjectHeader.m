//
//  NewRoomProjectHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomProjectHeader.h"

#import <MapKit/MapKit.h>

@interface NewRoomProjectHeader ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{

    NSInteger _num;
    NSInteger _nowNum;
    float _longitude;
    float _latitude;
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}
@end

@implementation NewRoomProjectHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:(NSString *)reuseIdentifier];
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

- (void)ActionTapMethod{
    
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(_latitude, _longitude);
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    toLocation.name = _addressL.text;
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    if (self.newRoomProjectHeaderMoreBlock) {
        
        self.newRoomProjectHeaderMoreBlock();
    }
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
    
    if (dataDic[@"developer_name"]) {
        
        _developerL.text = [NSString stringWithFormat:@"开发商：%@",dataDic[@"developer_name"]];
    }
    
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
    
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
    [_propertyColl reloadData];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
//        [self ReMasonryUI];
        [self->_propertyColl mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.contentView).offset(10 *SIZE);
            make.top.equalTo(self->_titleL.mas_bottom).offset(11 *SIZE);
            make.width.mas_equalTo(260 *SIZE);
            make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
        }];
//    });
    
    
}

- (void)ActionImgBtn{
    
    if (self.newRoomProjectHeaderImgBtnBlock) {
        
        if (_imgArr.count) {
            
            self.newRoomProjectHeaderImgBtnBlock(_nowNum, _imgArr);
            
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _nowNum = scrollView.contentOffset.x / SCREEN_Width;
    _numL.text = [NSString stringWithFormat:@"%.0f/%ld",(scrollView.contentOffset.x / SCREEN_Width) + 1, (long)_num];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(260 *SIZE, 9 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    return 10;
    if (section == 1) {

        return _tagArr.count;
    }
    return _propertyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] init];//WithFrame:CGRectMake(0, 0, 60 *SIZE, 20 *SIZE)];
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
    [self.contentView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = COLOR(27, 152, 255, 1);
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:SIZE];
    _propertyFlowLayout.estimatedItemSize = CGSizeMake(40 *SIZE, 20 *SIZE);
    if (@available(iOS 10.0, *)) {
        _propertyFlowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    } else {
        // Fallback on earlier versions
    }
    
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
    [self.contentView addSubview:_attentL];
    
    _developerL = [[UILabel alloc] init];
    _developerL.textColor = CL86Color;
    _developerL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_developerL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = COLOR(250, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:16 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _addressImg = [[UIImageView alloc] init];
    _addressImg.image = [UIImage imageNamed:@"map"];
    [self.contentView addSubview:_addressImg];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = CLContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_addressL];
    _addressL.userInteractionEnabled = YES;
    [_addressL addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTapMethod)]];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
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
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_imgScroll.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(30 *SIZE);
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(260 *SIZE);
        make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];

    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_developerL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_developerL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
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
        make.bottom.equalTo(self.contentView).offset(-22 *SIZE);
    }];
}

- (void)ReMasonryUI{
    
    [_imgScroll mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(202.5 *SIZE);
    }];
    
    [_numL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.bottom.equalTo(self->_imgScroll.mas_bottom).offset(-9 *SIZE);
        make.width.height.mas_equalTo(30 *SIZE);
    }];
    
    [_titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_imgScroll.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
    }];
    
    [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_imgScroll.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(30 *SIZE);
    }];
    
    [_propertyColl mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(260 *SIZE);
        make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    
    [_attentL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self->_titleL.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_developerL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_developerL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_addressImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(8 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(287 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_addressL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(31 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-70 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-22 *SIZE);
    }];

}

@end
