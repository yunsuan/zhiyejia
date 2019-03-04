//
//  SecRoomHouseOtherHouseCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecRoomHouseOtherHouseCellBlock)(NSInteger index);

@interface SecRoomHouseOtherHouseCell : UITableViewCell

@property (nonatomic, copy) SecRoomHouseOtherHouseCellBlock secRoomHouseOtherHouseCellBlock;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) UICollectionView *cellColl;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
