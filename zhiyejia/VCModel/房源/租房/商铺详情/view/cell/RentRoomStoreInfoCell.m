//
//  RentRoomHouseInfoCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RentRoomStoreInfoCell.h"

@interface RentRoomStoreInfoCell ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}
@end

@implementation RentRoomStoreInfoCell

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

- (void)setStoreModel:(RentRoomStoreDetailModel *)storeModel{
    
    _propertyArr = [NSMutableArray arrayWithArray:storeModel.project_tags];
    _tagArr = [NSMutableArray arrayWithArray:storeModel.house_tags];
    
    [_propertyColl reloadData];
    SS(strongSelf);
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(strongSelf->_propertyColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
    }];
    
    _transferL.text = [NSString stringWithFormat:@"转让费：%@元",storeModel.transfer_money];
    _depositL.text = [NSString stringWithFormat:@"押金：%@元",storeModel.deposit];
    _roomLevelL.text = [NSString stringWithFormat:@"房源等级：%@",storeModel.level];
    _rentTypeL.text = [NSString stringWithFormat:@"租赁类型：%@",storeModel.rent_type];
    _payWayL.text = [NSString stringWithFormat:@"收款方式：%@",[storeModel.receive_way componentsJoinedByString:@","]];
    _minPeriodL.text = [NSString stringWithFormat:@"最短租期：%@",storeModel.rent_min_comment];
    _maxPeriodL.text = [NSString stringWithFormat:@"最长租期：%@",storeModel.rent_max_comment];
    if ([storeModel.check_in_time containsString:@"0000"]) {
        
        _inTimeL.text = @"可入住时间：随时入住";
    }else{
        
        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：%@",storeModel.check_in_time];
    }
    
    _seeL.text = [NSString stringWithFormat:@"看房方式：%@",storeModel.check_way];
    if ([storeModel.rent_free_month integerValue] == 0) {
        
        _rentFreeL.text = @"免租期：无";
    }else{
        
        _rentFreeL.text = [NSString stringWithFormat:@"免租期：%@",storeModel.rent_free_month];
    }
    
    _commercailL.text = [NSString stringWithFormat:@"适合业态：%@",storeModel.format_tags];
    _intentL.text = [NSString stringWithFormat:@"出租意愿度：%@",storeModel.intent];
    _urgentL.text = [NSString stringWithFormat:@"出租急迫度：%@",storeModel.urgency];
    _markL.text = [NSString stringWithFormat:@"%@",storeModel.comment];
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
    
    //    _tagView = [[TagView alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 300 *SIZE, 20 *SIZE) type:@"1"];
    //    [self.contentView addSubview:_tagView];
    //
    //    _tagView2 = [[TagView alloc] initWithFrame:CGRectMake(10 *SIZE, 46 *SIZE, 300 *SIZE, 20 *SIZE) type:@"1"];
    //    [self.contentView addSubview:_tagView2];
    
    
    _markView = [[UIView alloc] init];
    _markView.backgroundColor = COLOR(244, 244, 244, 1);
    [self.contentView addSubview:_markView];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(70 *SIZE, 20 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 11 *SIZE, 340 *SIZE, 20 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = CLWhiteColor;
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    for (int i = 0; i < 14; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        //        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
                
            case 0:{
                
                _transferL = label;
                [self.contentView addSubview:_transferL];
                break;
            }
            case 1:{
                
                _depositL = label;
                [self.contentView addSubview:_depositL];
                break;
            }
            case 2:{
                
                _roomLevelL = label;
                [self.contentView addSubview:_roomLevelL];
                break;
            }
            case 3:{
                
                _rentTypeL = label;
                [self.contentView addSubview:_rentTypeL];
                break;
            }
            case 4:{
                
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 5:{
                
                _minPeriodL = label;
                [self.contentView addSubview:_minPeriodL];
                break;
            }
            case 6:{
                
                _maxPeriodL = label;
                [self.contentView addSubview:_maxPeriodL];
                break;
            }
            case 7:{
                
                _inTimeL = label;
                [self.contentView addSubview:_inTimeL];
                break;
            }
            case 8:{
                
                _seeL = label;
                [self.contentView addSubview:_seeL];
                break;
            }
            case 9:{
                
                _rentFreeL = label;
                [self.contentView addSubview:_rentFreeL];
                break;
            }
            case 10:{
                
                _commercailL = label;
                [self.contentView addSubview:_commercailL];
                break;
            }
            case 11:{
                
                _intentL = label;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 12:{
                
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            case 13:{
                
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
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(self->_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_transferL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(170 *SIZE));
    }];
    
    [_depositL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_transferL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(170 *SIZE));
    }];
    
    [_rentTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_depositL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_roomLevelL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(340 *SIZE));
    }];
    
    [_minPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_payWayL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(170 *SIZE));
    }];
    
    [_maxPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_payWayL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_minPeriodL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(170 *SIZE));
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_maxPeriodL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_rentFreeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_inTimeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(170 *SIZE));
    }];
    
    [_commercailL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_seeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_rentFreeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_commercailL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(170 *SIZE));
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_urgentL.mas_bottom).offset(16 *SIZE);
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
