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
        
        _priceL.text = [NSString stringWithFormat:@"单价：%@元/m²",model.unit_price];
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"单价："];
    }
    
    
    if ([model.property_limit integerValue]) {
        
        _yearL.text = [NSString stringWithFormat:@"产权年限：%@",model.property_limit];
    }else{
        
        _yearL.text = [NSString stringWithFormat:@"产权年限："];
    }
    
    if (model.permit_time.length) {
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间：%@",model.permit_time];
    }else{
        
        _timeL.text = [NSString stringWithFormat:@"拿证时间："];
    }
    
    if (model.format_tags.length) {

        _formatL.text = [NSString stringWithFormat:@"适合业态：%@",model.format_tags];
    }else{

        _formatL.text = [NSString stringWithFormat:@"适合业态："];
    }
    
    
    if (model.check_way.length) {

        _seeL.text = [NSString stringWithFormat:@"看房方式：%@",model.check_way];
    }else{

        _seeL.text = [NSString stringWithFormat:@"看房方式："];
    }

    if ([model.intent integerValue]) {

        _intentL.text = [NSString stringWithFormat:@"卖房意愿度：%@",model.intent];
    }else{

        _intentL.text = [NSString stringWithFormat:@"卖房意愿度："];
    }
    
    if ([model.urgency integerValue]) {

        _urgentL.text = [NSString stringWithFormat:@"卖房紧迫度：%@",model.urgency];
    }else{

        _urgentL.text = [NSString stringWithFormat:@"卖房紧迫度："];
    }
    
    if ([model.pay_way count]) {

        _payL.text = [NSString stringWithFormat:@"付款方式：%@",[model.pay_way componentsJoinedByString:@","]];
    }else{

        _payL.text = [NSString stringWithFormat:@"付款方式："];
    }
    
    if (model.comment.length) {
        
        _markL.text = [NSString stringWithFormat:@" 其他要求：%@\n",model.comment];
    }else{
        
        _markL.text = [NSString stringWithFormat:@"其他要求：暂无数据"];
    }
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
    
    if (officeModel.format_tags.length) {

        _formatL.text = [NSString stringWithFormat:@"适合业态：%@",officeModel.format_tags];
    }else{

        _formatL.text = [NSString stringWithFormat:@"适合业态："];
    }
    
    
    if (officeModel.check_way.length) {

        _seeL.text = [NSString stringWithFormat:@"看房方式：%@",officeModel.check_way];
    }else{

        _seeL.text = [NSString stringWithFormat:@"看房方式："];
    }

    if ([officeModel.intent integerValue]) {

        _intentL.text = [NSString stringWithFormat:@"卖房意愿度：%@",officeModel.intent];
    }else{

        _intentL.text = [NSString stringWithFormat:@"卖房意愿度："];
    }
    
    if ([officeModel.urgency integerValue]) {

        _urgentL.text = [NSString stringWithFormat:@"卖房紧迫度：%@",officeModel.urgency];
    }else{

        _urgentL.text = [NSString stringWithFormat:@"卖房紧迫度："];
    }
    
    if ([officeModel.pay_way count]) {

        _payL.text = [NSString stringWithFormat:@"付款方式：%@",[officeModel.pay_way componentsJoinedByString:@","]];
    }else{

        _payL.text = [NSString stringWithFormat:@"付款方式："];
    }
    
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
    
    for (int i = 0; i < 11; i++) {
        
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
    
    [_formatL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
        
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_timeL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_formatL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(180 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(180 *SIZE);
        make.top.equalTo(self->_formatL.mas_bottom).offset(19 *SIZE);
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
