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

//    [_tagView setData:model.project_tags];
//    [_tagView2 setData:model.house_tags];

//    if (model.house_code.length) {
//
//        _codeL.text = [NSString stringWithFormat:@"房源编号：%@",model.house_code];
//    }else{
//
//        _codeL.text = [NSString stringWithFormat:@"房源编号：暂无数据"];
//    }
    
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

    //    if ([model.unit_price integerValue]) {
    //
    //        _yearL.text = [NSString stringWithFormat:@"建成年代：%@",model.price];
    //    }else{
    //
    _yearL.text = [NSString stringWithFormat:@"建成年代：暂无数据"];
    //    }


    if (model.decoration.length) {

        _decorateL.text = [NSString stringWithFormat:@"装修：%@",model.decoration];
    }else{

        _decorateL.text = [NSString stringWithFormat:@"装修：暂无数据"];
    }

    if (model.permit_time.length) {

        _timeL.text = [NSString stringWithFormat:@"拿证时间：%@",model.permit_time];
    }else{

        _timeL.text = [NSString stringWithFormat:@"拿证时间：暂无数据"];
    }

    if (model.floor_type.length) {

        _floorL.text = [NSString stringWithFormat:@"楼层：%@",model.floor_type];
    }else{

        _floorL.text = [NSString stringWithFormat:@"楼层：暂无数据"];
    }

    if (model.check_in_time.length && ![model.check_in_time containsString:@"0000"]) {

        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：%@后",model.check_in_time];
    }else{

        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：随时入住"];
    }

    if ([model.property_limit integerValue]) {

        _proLimitL.text = [NSString stringWithFormat:@"产权年限：%@年",model.property_limit];
    }else{

        _proLimitL.text = [NSString stringWithFormat:@"产权年限：暂无数据"];
    }

    if (model.comment.length) {

        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",model.comment];
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
    
    for (int i = 0; i < 9; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL86Color;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
//                _codeL = label;
                //                [self.contentView addSubview:_codeL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
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
                _timeL = label;
                [self.contentView addSubview:_timeL];
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
                _inTimeL = label;
                [self.contentView addSubview:_inTimeL];
                break;
            }
            case 7:
            {
                _proLimitL = label;
                [self.contentView addSubview:_proLimitL];
                break;
            }
            case 8:
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
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_yearL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_proLimitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(self->_floorL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_inTimeL.mas_bottom).offset(16 *SIZE);
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
