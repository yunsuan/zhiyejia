//
//  DemandBuyCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "DemandBuyCell.h"

#import "DemandBuyCollCell.h"

@interface DemandBuyCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
 
    NSMutableArray *_dataArr;
}
@end

@implementation DemandBuyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    
    _dataArr = [[NSMutableArray alloc] initWithArray:dataArr];
    [_coll reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self->_coll mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(11 *SIZE);
            make.top.equalTo(self.contentView).offset(6 *SIZE);
            make.width.mas_equalTo(338 *SIZE);
            make.height.mas_equalTo(self->_coll.collectionViewLayout.collectionViewContentSize.height);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-11 *SIZE);
        }];
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DemandBuyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemandBuyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[DemandBuyCollCell alloc] initWithFrame:CGRectMake(0, 0, 338 *SIZE, 155 *SIZE)];
    }
    
    cell.dataDic = _dataArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.demandBuyCellBlock) {
        
        self.demandBuyCellBlock(indexPath.item);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    self.backgroundColor = CLWhiteColor;
    
    _layout = [[GZQFlowLayout alloc] initWithType:0 betweenOfCell:0];
    _layout.itemSize = CGSizeMake(338 *SIZE, 155 *SIZE);
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    
    _coll.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.6].CGColor;
    _coll.layer.shadowOffset = CGSizeMake(0,1);
    _coll.layer.shadowOpacity = 0.5;
    _coll.layer.borderWidth = SIZE;
    _coll.layer.borderColor = COLOR(231, 231, 231, 1).CGColor;
    _coll.layer.shadowRadius = 5 *SIZE;
    _coll.layer.masksToBounds = NO;
    [_coll registerClass:[DemandBuyCollCell class] forCellWithReuseIdentifier:@"DemandBuyCollCell"];
    [self.contentView addSubview:_coll];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(self.contentView).offset(6 *SIZE);
        make.width.mas_equalTo(338 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-11 *SIZE);
    }];
}

@end
