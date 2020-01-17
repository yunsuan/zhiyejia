//
//  SecRoomHouseInfoCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomHouseInfoCell.h"

@interface SecRoomHouseInfoCell ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation SecRoomHouseInfoCell

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


- (void)setModel:(SecRoomHouseDetailModel *)model{
    
    _propertyArr = [NSMutableArray arrayWithArray:model.house_tags];
    _tagArr = [NSMutableArray arrayWithArray:model.project_tags];
    
    [_propertyColl reloadData];
    SS(strongSelf);
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(strongSelf->_propertyColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
    }];


//    if ([model.unit_price integerValue]) {
//
//        _upTimeL.text = [NSString stringWithFormat:@"上架时间：%@",model.unit_price];
//    }else{
//
//        _upTimeL.text = [NSString stringWithFormat:@"上架时间："];
//    }
    
    if (model.level.length) {

        _levelL.text = [NSString stringWithFormat:@"房源等级：%@",model.level];
    }else{

        _levelL.text = [NSString stringWithFormat:@"房源等级："];
    }
    
    if ([model.unit_price integerValue]) {

        _unitL.text = [NSString stringWithFormat:@"单价：%@元/m²",model.unit_price];
    }else{

        _unitL.text = [NSString stringWithFormat:@"单价："];
    }


    if (model.decoration.length) {

        _decorateL.text = [NSString stringWithFormat:@"装修：%@",model.decoration];
    }else{

        _decorateL.text = [NSString stringWithFormat:@"装修："];
    }

    if (model.floor_type.length) {

        _floorL.text = [NSString stringWithFormat:@"楼层：%@",model.floor_type];
    }else{

        _floorL.text = [NSString stringWithFormat:@"楼层："];
    }
    
    if ([model.property_limit integerValue]) {

        _yearL.text = [NSString stringWithFormat:@"产权年限：%@年",model.property_limit];
    }else{

        _yearL.text = [NSString stringWithFormat:@"产权年限："];
    }
    
    if (model.permit_time.length) {

        _proLimitL.text = [NSString stringWithFormat:@"拿证时间：%@",model.permit_time];
    }else{

        _proLimitL.text = [NSString stringWithFormat:@"拿证时间："];
    }

    if (model.check_way.length) {

        _seeL.text = [NSString stringWithFormat:@"看房方式：%@",model.check_way];
    }else{

        _seeL.text = [NSString stringWithFormat:@"看房方式："];
    }

    if (model.check_in_time.length && ![model.check_in_time containsString:@"0000"]) {

        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：%@后",model.check_in_time];
    }else{

        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：随时入住"];
    }

    if ([model.intent integerValue]) {

        _intentL.text = [NSString stringWithFormat:@"卖房意愿度：%@",model.property_limit];
    }else{

        _intentL.text = [NSString stringWithFormat:@"卖房意愿度："];
    }
    
    if ([model.urgency integerValue]) {

        _urgentL.text = [NSString stringWithFormat:@"卖房紧迫度：%@",model.property_limit];
    }else{

        _urgentL.text = [NSString stringWithFormat:@"卖房紧迫度："];
    }
    
    if ([model.pay_way count]) {

        _payL.text = [NSString stringWithFormat:@"付款方式：%@",[model.check_way stringByAppendingPathComponent:@","]];
    }else{

        _payL.text = [NSString stringWithFormat:@"付款方式："];
    }

    if (model.comment.length) {

        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",model.comment];
    }else{

        _markL.text = [NSString stringWithFormat:@"其他要求："];
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
        
        if (_propertyArr.count) {
            
            [cell setStyleByType:@"0" lab:_propertyArr[indexPath.item]];
        }else{
            
            [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        }
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
    
    for (int i = 0; i < 13; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _upTimeL = label;
                [self.contentView addSubview:_upTimeL];
                break;
            }
            case 1:
            {
                _unitL = label;
                [self.contentView addSubview:_unitL];
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
                _decorateL = label;
                [self.contentView addSubview:_decorateL];
                break;
            }
            case 4:
            {
                _levelL = label;
                [self.contentView addSubview:_levelL];
                break;
            }
            case 5:
            {
                _floorL = label;
                [self.contentView addSubview:_floorL];
                break;
            }
            case 6:
            {
                _proLimitL = label;
                [self.contentView addSubview:_proLimitL];
                break;
            }
            case 7:
            {
                _inTimeL = label;
                [self.contentView addSubview:_inTimeL];
                break;
            }
            case 8:
            {
                _markL = label;
                [_markView addSubview:_markL];
                break;
            }
            case 9:
            {
                _seeL = label;
                [_markView addSubview:_seeL];
                break;
            }
            case 10:
            {
                _intentL = label;
                [_markView addSubview:_intentL];
                break;
            }
            case 11:
            {
                _urgentL = label;
                [_markView addSubview:_urgentL];
                break;
            }
            case 12:
            {
                _payL = label;
                [_markView addSubview:_payL];
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
        
//    [_upTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
//    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_levelL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_levelL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_decorateL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_proLimitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_decorateL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_yearL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_yearL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_seeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_seeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_intentL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
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
