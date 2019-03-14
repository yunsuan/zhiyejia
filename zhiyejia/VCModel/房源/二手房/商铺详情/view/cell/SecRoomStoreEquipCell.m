//
//  SecRoomStoreEquipCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomStoreEquipCell.h"

#import "EquipMentCollCell.h"

@interface SecRoomStoreEquipCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation SecRoomStoreEquipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EquipMentCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EquipMentCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[EquipMentCollCell alloc] initWithFrame:CGRectMake(0, 0, 72 *SIZE, 60 *SIZE)];
    }
    
    NSString *imgurl =_dataArr[indexPath.item][@"url"];
    if (imgurl.length>0) {
        
        [cell.typeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.item][@"url"]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                cell.typeImg.image = [UIImage imageNamed:@""];
            }
        }];
    }
    else
    {
#warning 默认图片？
    }
    cell.titleL.text = self.dataArr[indexPath.item][@"name"];
    
    
    return cell;
}


- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self.contentView addSubview:_whiteView];
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.estimatedItemSize = CGSizeMake(72 *SIZE, 60 *SIZE);
    _layout.minimumLineSpacing = 0 *SIZE;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 17 *SIZE, 340 *SIZE, 60 *SIZE) collectionViewLayout:_layout];
    _coll.pagingEnabled = YES;
    _coll.backgroundColor = [UIColor whiteColor];
    _coll.delegate = self;
    _coll.dataSource = self;
    _coll.showsVerticalScrollIndicator = NO;
    _coll.showsHorizontalScrollIndicator = NO;
    [_coll registerClass:[EquipMentCollCell class] forCellWithReuseIdentifier:@"EquipMentCollCell"];
    [_whiteView addSubview:_coll];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(8 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(93 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
