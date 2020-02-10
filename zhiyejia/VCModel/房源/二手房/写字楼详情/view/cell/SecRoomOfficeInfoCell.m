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


- (void)setOfficeModel:(SecRoomOfficeDetailModel *)officeModel{
    
    _propertyArr = [NSMutableArray arrayWithArray:officeModel.house_tags];
    _tagArr = [NSMutableArray arrayWithArray:officeModel.project_tags];
    
    [_propertyColl reloadData];
    SS(strongSelf);
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(strongSelf->_propertyColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
    }];
    
    if (officeModel.level.length) {

        _levelL.text = [NSString stringWithFormat:@"房源等级：%@",officeModel.level];
    }else{

        _levelL.text = [NSString stringWithFormat:@"房源等级："];
    }
    
    if ([officeModel.unit_price integerValue]) {
        
        _priceL.text = [NSString stringWithFormat:@"单价：%@元/m²",officeModel.unit_price];
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"单价："];
    }
    
    
    if ([officeModel.property_limit integerValue]) {
        
        _yearL.text = [NSString stringWithFormat:@"产权年限：%@",officeModel.property_limit];
    }else{
        
        _yearL.text = [NSString stringWithFormat:@"产权年限："];
    }
    
    if (officeModel.permit_time.length) {
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间：%@",officeModel.permit_time];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间："];
    }
    
//    if (officeModel.format_tags.length) {
//
//        _formatL.text = [NSString stringWithFormat:@"适合业态：%@",officeModel.format_tags];
//    }else{
//
//        _formatL.text = [NSString stringWithFormat:@"适合业态："];
//    }
    
    
    if (officeModel.check_way.length) {

        _seeL.text = [NSString stringWithFormat:@"看房方式：%@",officeModel.check_way];
    }else{

        _seeL.text = [NSString stringWithFormat:@"看房方式："];
    }

    if ([officeModel.intent integerValue]) {

        _intentL.text = [NSString stringWithFormat:@"卖房意愿度：%@",officeModel.intent];
    }else{

        _intentL.text = [NSString stringWithFormat:@"卖房意愿度：0"];
    }
    
    if ([officeModel.urgency integerValue]) {

        _urgentL.text = [NSString stringWithFormat:@"卖房紧迫度：%@",officeModel.urgency];
    }else{

        _urgentL.text = [NSString stringWithFormat:@"卖房紧迫度：0"];
    }
    
    if ([officeModel.pay_way count]) {

        _payL.text = [NSString stringWithFormat:@"付款方式：%@",[officeModel.pay_way componentsJoinedByString:@","]];
    }else{

        _payL.text = [NSString stringWithFormat:@"付款方式："];
    }
    
    if (officeModel.floor_type.length) {
        
        _floorL.text = [NSString stringWithFormat:@"楼层：%@",officeModel.floor_type];
    }else{
        
        _floorL.text = [NSString stringWithFormat:@"楼层："];
    }
    
    if (officeModel.comment.length) {
        
        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",officeModel.comment];
    }else{
        
        _markL.text = [NSString stringWithFormat:@"其他要求：暂无数据"];
    }
    
    if ([officeModel.is_rent integerValue] == 1) {
        
        _isRentL.text = @"当前出租：是";
        _rentPriceL.text = [NSString stringWithFormat:@"当前租金：%@",officeModel.rent_money];
        _referenceRentL.text = [NSString stringWithFormat:@"参考租金：%@",officeModel.reference_rent];
        _rentOverTimeL.text = [NSString stringWithFormat:@"租期结束时间：%@",officeModel.rent_over_time];
    }else{
        
        _isRentL.text = @"当前出租：否";
        
        [_intentL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(10 *SIZE);
            make.top.equalTo(self->_isRentL.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(180 *SIZE));
        }];
        
        [_urgentL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(180 *SIZE);
            make.top.equalTo(self->_isRentL.mas_bottom).offset(19 *SIZE);
            make.width.equalTo(@(180 *SIZE));
        }];
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
    
    for (int i = 0; i < 16; i++) {
        
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
                _levelL = label;
                [self.contentView addSubview:_levelL];
                break;
            }
            case 4:
            {
                _seeL = label;
                [self.contentView addSubview:_seeL];
                break;
            }
            case 5:
            {
                _payL = label;
                _payL.numberOfLines = 0;
                [self.contentView addSubview:_payL];
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
            case 8:
            {
                _intentL = label;
                [_markView addSubview:_intentL];
                break;
            }
            case 9:
            {
                _urgentL = label;
                [_markView addSubview:_urgentL];
                break;
            }
            case 10:
            {
                _priceL = label;
                [_markView addSubview:_priceL];
                break;
            }
            case 11:
            {
                _isRentL = label;
                [_markView addSubview:_isRentL];
                break;
            }
            case 12:
            {
                _rentPriceL = label;
                [_markView addSubview:_rentPriceL];
                break;
            }
            case 13:
            {
                _referenceRentL = label;
                [_markView addSubview:_referenceRentL];
                break;
            }
            case 14:
            {
                _rentOverTimeL = label;
                [_markView addSubview:_rentOverTimeL];
                break;
            }
            case 15:
            {
                _floorL = label;
                [_markView addSubview:_floorL];
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
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_levelL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_levelL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
        
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_isRentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_seeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
        
    }];
    
    [_rentPriceL mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_seeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_referenceRentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_isRentL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_rentOverTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_isRentL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_rentOverTimeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_rentOverTimeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.left.equalTo(self.contentView).offset(10 *SIZE);
           make.top.equalTo(self->_urgentL.mas_bottom).offset(19 *SIZE);
           make.width.equalTo(@(340 *SIZE));
       }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_payL.mas_bottom).offset(16 *SIZE);
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
