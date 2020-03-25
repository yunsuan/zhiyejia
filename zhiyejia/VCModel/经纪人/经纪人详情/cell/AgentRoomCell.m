//
//  AgentRoomCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/15.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "AgentRoomCell.h"

#import "AgentRoomCollCell.h"

@interface AgentRoomCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
 
    NSMutableArray *_dataArr;
}

@end

@implementation AgentRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _dataArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    
    _dataArr = [NSMutableArray arrayWithArray:dataArr];
    [_coll reloadData];
    [_coll layoutIfNeeded];
    [_coll mas_updateConstraints:^(MASConstraintMaker *make) {

        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentRoomCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AgentRoomCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AgentRoomCollCell alloc] initWithFrame:CGRectMake(0, 0, 342 *SIZE, 90 *SIZE)];
    }
    
    cell.dataDic = _dataArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.agentRoomCellBlock) {
        
        self.agentRoomCellBlock(indexPath.item);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLLineColor;
    
    _layout = [[GZQFlowLayout alloc] initWithType:0 betweenOfCell:0];
    _layout.itemSize = CGSizeMake(342 *SIZE, 90 *SIZE);
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    _coll.layer.cornerRadius = 10 *SIZE;
    _coll.clipsToBounds = YES;
    _coll.layer.borderWidth = SIZE;
    _coll.layer.borderColor = COLOR(231, 231, 231, 1).CGColor;
    [_coll registerClass:[AgentRoomCollCell class] forCellWithReuseIdentifier:@"AgentRoomCollCell"];
    [self.contentView addSubview:_coll];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(9 *SIZE);
        make.top.equalTo(self.contentView).offset(6 *SIZE);
        make.width.mas_equalTo(342 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
        make.bottom.equalTo(self.contentView).offset(-11 *SIZE);
    }];
}

@end
