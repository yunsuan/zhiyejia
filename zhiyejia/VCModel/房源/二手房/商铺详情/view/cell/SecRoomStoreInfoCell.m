//
//  SecRoomStoreInfoCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomStoreInfoCell.h"

@interface SecRoomStoreInfoCell ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}
@end

@implementation SecRoomStoreInfoCell

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

- (void)setModel:(SecRoomStoreDetailModel *)model{

    
    _propertyArr = [NSMutableArray arrayWithArray:model.project_tags];
    _tagArr = [NSMutableArray arrayWithArray:model.house_tags];
    
    [_propertyColl reloadData];
    SS(strongSelf);
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(strongSelf->_propertyColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
    }];
    
    if ([model.unit_price integerValue]) {
        
        _priceL.text = [NSString stringWithFormat:@"单价：%@元/m²",model.unit_price];
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"单价：暂无数据"];
    }
    
    if (model.permit_time.length) {
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间：%@",model.permit_time];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间：暂无数据"];
    }
    
    if ([model.property_limit integerValue]) {
        
        _yearL.text = [NSString stringWithFormat:@"产权年限：%@",model.property_limit];
    }else{
        
        _yearL.text = [NSString stringWithFormat:@"产权年限：暂无数据"];
    }
    
    
    if ([model.rent_money integerValue]) {
        
        _rentPriceL.text = [NSString stringWithFormat:@"当前租金：%@元/月",model.rent_money];
    }else{
        
        _rentPriceL.text = [NSString stringWithFormat:@"当前租金：暂无数据"];
    }
    
    if ([model.reference_rent integerValue]) {
        
        _referRentPriceL.text = [NSString stringWithFormat:@"参考租金：%@元/月",model.reference_rent];
    }else{
        
        _referRentPriceL.text = [NSString stringWithFormat:@"参考租金：暂无数据"];
    }
    
    if ([model.rent_over_time integerValue]) {
        
        _rentTimeL.text = [NSString stringWithFormat:@"租期结束时间：%@",model.rent_over_time];
    }else{
        
        _rentTimeL.text = [NSString stringWithFormat:@"租期结束时间：暂无数据"];
    }
    
    if (model.format_tags.length) {
        
        _formatL.text = [NSString stringWithFormat:@"适合业态：%@",model.format_tags];
    }else{
        
        _formatL.text = [NSString stringWithFormat:@"适合业态：暂无数据"];
    }
    
    if (model.comment.length) {
        
        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",model.comment];
    }else{
        
        _markL.text = [NSString stringWithFormat:@"其他要求：暂无数据"];
    }
}

- (void)setOfficeModel:(SecRoomOfficeDetailModel *)officeModel{
    
//    [_tagView setData:officeModel.project_tags];
//    [_tagView2 setData:officeModel.house_tags];
    
//    if ([officeModel.unit_price integerValue]) {
//
//        _codeL.text = [NSString stringWithFormat:@"房源编号：%@",officeModel.price];
//    }else{
//
//        _codeL.text = [NSString stringWithFormat:@"房源编号：暂无数据"];
//    }
    
    _propertyArr = [NSMutableArray arrayWithArray:officeModel.project_tags];
    _tagArr = [NSMutableArray arrayWithArray:officeModel.house_tags];
    
    [_propertyColl reloadData];
    SS(strongSelf);
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(strongSelf->_propertyColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
    }];
    
    if ([officeModel.unit_price integerValue]) {
        
        _priceL.text = [NSString stringWithFormat:@"单价：%@元/m²",officeModel.unit_price];
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"单价：暂无数据"];
    }
    
    if (officeModel.permit_time.length) {
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间：%@",officeModel.permit_time];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间：暂无数据"];
    }
    
    
    if ([officeModel.property_limit integerValue]) {
        
        _yearL.text = [NSString stringWithFormat:@"产权年限：%@年",officeModel.property_limit];
    }else{
        
        _yearL.text = [NSString stringWithFormat:@"产权年限：暂无数据"];
    }
    
    if (officeModel.floor_type.length) {
        
        _timeL.text = [NSString stringWithFormat:@"楼层：%@",officeModel.floor_type];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"楼层：暂无数据"];
    }
    
    if ([officeModel.rent_money integerValue]) {
        
        _rentPriceL.text = [NSString stringWithFormat:@"当前租金：%@元/㎡",officeModel.rent_money];
    }else{
        
        _rentPriceL.text = [NSString stringWithFormat:@"当前租金：暂无数据"];
    }
    
    if (officeModel.rent_over_time.length) {
        
        _rentTimeL.text = [NSString stringWithFormat:@"租期结束时间：%@",officeModel.rent_over_time];
    }else{
        
        _rentTimeL.text = [NSString stringWithFormat:@"租期结束时间：暂无数据"];
    }
    
//    _.textColor = YJBlueBtnColor;
    //    if ([officeModel.unit_price integerValue]) {
    //
    //        _proLimitL.text = [NSString stringWithFormat:@"参考租金：%@",officeModel.price];
    //    }else{
    //
    _referRentPriceL.text = [NSString stringWithFormat:@"参考租金：暂无数据"];
    //    }
    
    if (officeModel.comment.length) {
        
        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",officeModel.comment];
    }else{
        
        _markL.text = [NSString stringWithFormat:@"其他要求：暂无数据"];
    }
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
                _rentTimeL = label;
                [self.contentView addSubview:_rentTimeL];
                break;
            }
            case 4:
            {
                _rentPriceL = label;
                [self.contentView addSubview:_rentPriceL];
                break;
            }
            case 5:
            {
                _referRentPriceL = label;
                [self.contentView addSubview:_referRentPriceL];
                break;
            }
            case 6:
            {
                _formatL = label;
                [self.contentView addSubview:_formatL];
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
        make.top.equalTo(self.contentView).offset(11 *SIZE);
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
    
    [_rentPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        
    }];
    
    [_referRentPriceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_yearL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_rentTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_rentPriceL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_rentTimeL.mas_bottom).offset(16 *SIZE);
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
