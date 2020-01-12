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
    
    NSMutableArray *_agentArr;
}
@end

@implementation NewRoomProjectAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _agentArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    _agentArr = [NSMutableArray arrayWithArray:dataArr];
    [_coll reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _agentArr.count > 3? 3:_agentArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewRoomProjectAgentCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewRoomProjectAgentCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[NewRoomProjectAgentCollCell alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 130 *SIZE)];
    }
    
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_agentArr[indexPath.item][@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            cell.headImg.image = [UIImage imageNamed:@"def_head"];
        }
    }];
    cell.nameL.text = _agentArr[indexPath.item][@"name"];
    
    cell.newRoomProjectAgentCollCellPhoneBlock = ^{
        
        if (self.newRoomProjectAgentCellPhoneBlock) {
            
            self.newRoomProjectAgentCellPhoneBlock(indexPath.item);
        }
    };
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
        make.height.mas_equalTo(130 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
