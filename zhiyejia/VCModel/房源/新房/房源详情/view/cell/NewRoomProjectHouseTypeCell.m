//
//  NewRoomProjectHouseTypeCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "NewRoomProjectHouseTypeCell.h"

#import "HouseTypeRoomCellCollCell.h"

@interface NewRoomProjectHouseTypeCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation NewRoomProjectHouseTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HouseTypeRoomCellCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HouseTypeRoomCellCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[HouseTypeRoomCellCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 220 *SIZE)];
    }
    
    [cell.typeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,self.dataArr[indexPath.item][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            cell.typeImg.image = [UIImage imageNamed:@"default_3"];
        }
    }];
    
    cell.letterL.text = self.dataArr[indexPath.item][@"house_type_name"];
    cell.areaL.text = [NSString stringWithFormat:@"%@㎡",self.dataArr[indexPath.item][@"property_area_min"]];
    cell.typeL.text = self.dataArr[indexPath.item][@"house_type"];
    if (self.dataArr[indexPath.item][@"current_surplus"]) {
        
        cell.statusL.text = [NSString stringWithFormat:@"剩余：%@套",self.dataArr[indexPath.item][@"current_surplus"]];
    }else{
        
        cell.statusL.text = self.dataArr[indexPath.item][@"sale_state"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.collCellBlock) {
        
        self.collCellBlock(indexPath.item);
    }
}

- (void)initUI{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 9 *SIZE, 65 *SIZE, 15 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"户型信息";
    [self.contentView addSubview:label];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 220 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _cellColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 33 *SIZE, SCREEN_Width, 220 *SIZE) collectionViewLayout:_flowLayout];
    _cellColl.backgroundColor = self.contentView.backgroundColor;
    _cellColl.delegate = self;
    _cellColl.dataSource = self;
    
    [_cellColl registerClass:[HouseTypeRoomCellCollCell class] forCellWithReuseIdentifier:@"HouseTypeRoomCellCollCell"];
    [self.contentView addSubview:_cellColl];
    
    [_cellColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(33 *SIZE);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.offset(360 *SIZE);
        make.height.offset(220 *SIZE);
    }];
}

@end
