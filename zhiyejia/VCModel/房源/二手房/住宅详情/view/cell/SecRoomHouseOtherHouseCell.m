//
//  SecRoomHouseOtherHouseCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomHouseOtherHouseCell.h"

#import "SecAllRoomCollCell.h"

@interface SecRoomHouseOtherHouseCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SecRoomHouseOtherHouseCell

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
    
    //    if (self.dataArr.count > indexPath.item) {
    
    SecAllRoomCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SecAllRoomCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SecAllRoomCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 220 *SIZE)];
    }
    if (_dataArr.count) {
        
        NSString *imgurl = _dataArr[indexPath.item][@"img_url"];
        if (imgurl.length>0) {
            
            [cell.typeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,self.dataArr[indexPath.item][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    cell.typeImg.image = [UIImage imageNamed:@"default_3"];
                }
            }];
        }
        else{
            
            cell.typeImg.image = [UIImage imageNamed:@"default_3"];
        }
        cell.nameL.text = self.dataArr[indexPath.item][@"title"];
        cell.areaL.text = [NSString stringWithFormat:@"%@㎡",self.dataArr[indexPath.item][@"build_area"]];
        cell.priceL.text = [NSString stringWithFormat:@"%@万",self.dataArr[indexPath.item][@"price"]];
    }else{
        
        
        cell.typeImg.image = [UIImage imageNamed:@"default_3"];
        
        cell.nameL.text = @"暂无房源信息";
        //        cell.areaL.text = [NSString stringWithFormat:@"%@㎡",self.dataArr[indexPath.item][@"build_area"]];
        //        cell.priceL.text = [NSString stringWithFormat:@"%@万",self.dataArr[indexPath.item][@"price"]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.secRoomHouseOtherHouseCellBlock) {
        
        self.secRoomHouseOtherHouseCellBlock(indexPath.item);
    }
}

- (void)initUI{
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 220 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _cellColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 *SIZE, SCREEN_Width, 220 *SIZE) collectionViewLayout:_flowLayout];
    _cellColl.backgroundColor = self.contentView.backgroundColor;
    _cellColl.delegate = self;
    _cellColl.dataSource = self;
    
    [_cellColl registerClass:[SecAllRoomCollCell class] forCellWithReuseIdentifier:@"SecAllRoomCollCell"];
    [self.contentView addSubview:_cellColl];
    
    [_cellColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.offset(360 *SIZE);
        make.height.offset(220 *SIZE);
    }];
}

@end
