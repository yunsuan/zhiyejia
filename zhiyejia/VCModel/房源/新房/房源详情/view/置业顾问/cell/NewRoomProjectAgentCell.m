//
//  NewRoomProjectAgentCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewRoomProjectAgentCell.h"

#import "NewRoomProjectAgentCollCell.h"

@interface NewRoomProjectAgentCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    
}
@end

@implementation NewRoomProjectAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewRoomProjectAgentCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewRoomProjectAgentCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[NewRoomProjectAgentCollCell alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 130 *SIZE)];
    }
    
    cell.nameL.text = @"李翠";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.newRoomProjectAgentCellBlock) {
        
        self.newRoomProjectAgentCellBlock(indexPath.item);
    }
}

- (void)initUI{
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:30 *SIZE];
    _layout.itemSize = CGSizeMake(100 *SIZE, 130 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[NewRoomProjectAgentCollCell class] forCellWithReuseIdentifier:@"NewRoomProjectAgentCollCell"];
    [self.contentView addSubview:_coll];
    
    [self MasonyUI];
}

- (void)MasonyUI{
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(-0 *SIZE);
        make.height.mas_equalTo(100 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
